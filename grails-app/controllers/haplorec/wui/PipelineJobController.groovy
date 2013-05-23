package haplorec.wui
import grails.converters.JSON
import haplorec.wui.Util
import haplorec.util.Input


//import haplorec.util.*
import haplorec.util.pipeline.PipelineInput
import haplorec.util.pipeline.Pipeline
import haplorec.util.pipeline.Report

import haplorec.util.Input.InvalidInputException
import haplorec.util.Row

import org.codehaus.groovy.grails.web.mapping.LinkGenerator;
import org.springframework.dao.DataIntegrityViolationException
import javax.sql.DataSource
import groovy.sql.Sql

class PipelineJobController {
    DataSource dataSource
	LinkGenerator grailsLinkGenerator

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	// http://grails.org/doc/latest/guide/theWebLayer.html#commandObjects
	@grails.validation.Validateable
	static class DependencyInputCommand {
		String datatype
		byte[] input
		
		static constraints = {
			datatype validator: { haplorec.util.pipeline.PipelineInput.inputTables.contains(it?.toString()) }
			input size: 0..5*1024*1024
		}
	}
	
    def index() {
		log.error(PipelineInput.inputTables)
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobInstanceList: Job.list(params), jobInstanceTotal: Job.count()]
    }

    def create() {
        // [jobInstance: new Job(params), dependencyGraphJSON: dependencyGraphJSON()]
        
    	[jobInstance: new Job(params), dependencyGraphJSON: dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator, context: grailsApplication.mainContext,sampleInputs:true)]
		}
	
	
	def jsonList() {
		render ( 
            Job.list(params).collect { job ->
                def props = [
                    id: job.id,
                    jobName: job.jobName,
                ]
                return props
            }
        as JSON )
	}

    def save() {
        log.error("SAVE PARAMS: $params")
		
		// inputs['variants'] == [file1, file2, ...]
		Map inputs = new LinkedHashMap();
		PipelineInput.inputTables.each { inputs[it + 's'] = [] }
		params.each { p, v ->
			def m = (p =~ /^[^\d]+/)
			if (m.getCount() == 1) {
				def inputTable = m[0]
				if (PipelineInput.inputTables.contains(inputTable)) {
					inputs[inputTable + 's'].push(new BufferedReader(new InputStreamReader(v.getInputStream())))
				}
			}
		}
		log.error("INPUT PARAMS: $inputs")

        def jobInstance = new Job(params)
        if (!jobInstance.save(flush: true)) {
            render(view: "create", model: [jobInstance: jobInstance, dependencyGraphJSON: dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator)])
            return
        }

        try {
            // Run the pipeline
            withSql(dataSource) { sql ->
                Pipeline.drugRecommendations(inputs + [jobId: jobInstance.id], sql)
            } 
        } catch (InvalidInputException e) {
			jobInstance.refresh()
            jobInstance.delete(flush: true)
            jobInstance.errors.reject('job.errors.invalidInput', e.message)
            render(view: "create", model: [jobInstance: jobInstance, dependencyGraphJSON: dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator)])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'job.label', default: 'Job'), jobInstance.id])
        redirect(action: "show", id: jobInstance.id)
    }

    def show(Long id) {
        def jobInstance = Job.get(id)
        if (!jobInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'job.label', default: 'Job'), id])
            redirect(action: "list")
            return
        }

        def json
        withSql(dataSource) { sql ->
            json = dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator, sql: sql, job_id: id, counts: true)
        }

        [jobInstance: jobInstance, dependencyGraphJSON: json]
    }

    def edit(Long id) {
        def jobInstance = Job.get(id)
        if (!jobInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'job.label', default: 'Job'), id])
            redirect(action: "list")
            return
        }

        [jobInstance: jobInstance, dependencyGraphJSON: dependencyGraphJSON()]
    }

    def update(Long id, Long version) {
        def jobInstance = Job.get(id)
        if (!jobInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'job.label', default: 'Job'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobInstance.version > version) {
                jobInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'job.label', default: 'Job')] as Object[],
                          "Another user has updated this Job while you were editing")
                render(view: "edit", model: [jobInstance: jobInstance])
                return
            }
        }

        jobInstance.properties = params

        if (!jobInstance.save(flush: true)) {
            render(view: "edit", model: [jobInstance: jobInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'job.label', default: 'Job'), jobInstance.id])
        redirect(action: "show", id: jobInstance.id)
    }

    def delete(Long id) {
        def jobInstance = Job.get(id)
        if (!jobInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'job.label', default: 'Job'), id])
            redirect(action: "list")
            return
        }

        try {
            jobInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'job.label', default: 'Job'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'job.label', default: 'Job'), id])
            redirect(action: "show", id: id)
        }
    }
	
	
    def private static dependencyGraphJSON(Map kwargs = [:])  {
		
        if (kwargs.counts == null) { kwargs.counts = false }
		if (kwargs.sampleInputs == null) { kwargs.sampleInputs = false }
        def (tbl, dependencies) = Pipeline.dependencyGraph()
        List deps = dependencies.values().collect { d ->
            Util.makeRenderable(d) 
        } 
        if (kwargs.counts) {
            deps.each { d ->
				// add counts for tables
                d['count'] = kwargs.sql.rows("select count(*) as count from ${d.table} where job_id = :job_id", kwargs)[0]['count']
				d['jobId'] = kwargs.job_id
				d['listUrl'] = kwargs.grailsLinkGenerator.link(controller: d.table.replaceAll(/_([a-z])/, { it[0][1].toUpperCase() }), action: "listTemplate") 
            }
        }
		
		if (kwargs.sampleInputs) {
			deps.each { d ->
				// add sample input for each dependency
				def filename = "/sample_input/${d.target}.txt"
				def absoluteFilename = kwargs.context.getResource(filename).getFile().getCanonicalPath()
				def rows = []
				Input.dsv(['asList': true], absoluteFilename).each { row ->
					rows.add(row) // row is a list of strings, e.g. [PLATE, EXPERIMENT, CHIP, WELL_POSITION, ASSAY_ID, GENOTYPE_ID, DESCRIPTION, SAMPLE_ID, ENTRY_OPERATOR]
					}
				d['header']=rows[0]
				d['rows'] = rows[1,2,3,4,5,6,7,8,9]
				// error with rows[1..-1]?
				
			}
		}

        def level = dependencies.phenotypeDrugRecommendation.levels(startAt: [
            dependencies.phenotypeDrugRecommendation, 
            dependencies.genotypeDrugRecommendation])
        def depGraph = [
            level: level,
            dependencies: deps,
        ]

        return depGraph as JSON
    }

    def private report(Map kwargs = [:], Long id, generateReport) {
        if (kwargs.filename == null) { kwargs.filename = 'output.txt' }

        def jobInstance = Job.get(id)
        if (!jobInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'job.label', default: 'Job'), id])
            redirect(action: "list")
            return
        }

        withSql(dataSource) { sql ->
            def rows = generateReport([sqlParams: [job_id: id]], sql)

            response.setHeader "Content-disposition", "attachment; filename='${kwargs.filename}'"
            response.contentType = 'text/csv'

            response.outputStream.withWriter { w ->
                Row.asDSV(rows, w)
            }
        }

    }

    def private static withSql(DataSource d, Closure f) {
        Sql sql = new Sql(d)
        try {
            f(sql)
        } finally {
            sql.close()
        }
    }

    def genotypeReport(Long id) {
        report(id, Report.&genotypeDrugRecommendationReport,
            filename: 'genotype_drug_recommendation_report.txt', 
        )
    }

    def phenotypeReport(Long id) {
        report(id, Report.&phenotypeDrugRecommendationReport,
            filename: 'phenotype_drug_recommendation_report.txt', 
        )
    }

}
