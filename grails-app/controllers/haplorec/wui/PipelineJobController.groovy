package haplorec.wui
import grails.converters.JSON
import haplorec.wui.Util

//import haplorec.util.*
import haplorec.util.haplotype.HaplotypeInput
import haplorec.util.Haplotype

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
			datatype validator: { haplorec.util.haplotype.HaplotypeInput.inputTables.contains(it?.toString()) }
			input size: 0..5*1024*1024
		}
	}
	
    def index() {
		log.error(HaplotypeInput.inputTables)
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobInstanceList: Job.list(params), jobInstanceTotal: Job.count()]
    }

    def create() {
        // [jobInstance: new Job(params), dependencyGraphJSON: dependencyGraphJSON()]
        [jobInstance: new Job(params), dependencyGraphJSON: dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator)]
    }

    def save() {
        log.error("SAVE PARAMS: $params")
		
		// inputs['variants'] == [file1, file2, ...]
		Map inputs = new LinkedHashMap();
		HaplotypeInput.inputTables.each { inputs[it + 's'] = [] }
		params.each { p, v ->
			def m = (p =~ /^[^\d]+/)
			if (m.getCount() == 1) {
				def inputTable = m[0]
				if (HaplotypeInput.inputTables.contains(inputTable)) {
					inputs[inputTable + 's'].push(new BufferedReader(new InputStreamReader(v.getInputStream())))
				}
			}
		}
		log.error("INPUT PARAMS: $inputs")

        def jobInstance = new Job(params)
        if (!jobInstance.save(flush: true)) {
            render(view: "create", model: [jobInstance: jobInstance])
            return
        }

        Sql sql = new Sql(dataSource)
        Haplotype.drugRecommendations(inputs + [jobId: jobInstance.id], sql)

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

        Sql sql = new Sql(dataSource)
        [jobInstance: jobInstance, dependencyGraphJSON: dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator, sql: sql, job_id: id, counts: true)]
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
	
    def private static dependencyGraphJSON(Map kwargs = [:]) {
        if (kwargs.counts == null) { kwargs.counts = false }
        def (tbl, dependencies) = haplorec.util.Haplotype.dependencyGraph()
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

        def level = dependencies.drugRecommendation.levels()
        def depGraph = [
            level: level,
            dependencies: deps,
        ]

        return depGraph as JSON
    }
}
