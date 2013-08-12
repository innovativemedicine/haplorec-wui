package haplorec.wui
import grails.converters.JSON
import haplorec.wui.Util
import haplorec.util.Input


//import haplorec.util.*
import haplorec.util.pipeline.PipelineInput
import haplorec.util.pipeline.Pipeline
import haplorec.util.pipeline.Report
import haplorec.util.data.GeneHaplotypeMatrix
import haplorec.util.data.GeneHaplotypeMatrix.NovelHaplotype
import haplorec.util.data.GeneHaplotypeMatrix.Haplotype
import haplorec.util.dependency.Dependency

import haplorec.util.Input.InvalidInputException
import haplorec.util.Row

import org.codehaus.groovy.grails.web.mapping.LinkGenerator
import org.springframework.dao.DataIntegrityViolationException
import javax.sql.DataSource
import groovy.sql.Sql

class PipelineJobController {
    DataSource dataSource
    LinkGenerator grailsLinkGenerator
    def grailsApplication

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobInstanceList: Job.list(params), jobInstanceTotal: Job.count()]
    }

    def create() {
        [jobInstance: new Job(params), dependencyGraphJSON: dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator, context: grailsApplication.mainContext,sampleInputs:true)]
    }

    /* Changes the list of jobs to a JSON list
     * each job is converted to {id: job.id, jobName: job.jobName}
     */
    def jsonList() {
        render ( 
            Job.list().collect { job ->
                def props = [
                    id: job.id,
                    jobName: job.jobName,
                ]
                return props
            }
        as JSON )
    }

    /* The save function has been altered from the generated save function 
     * -to add input files to the inputs map based on target
     * -for each target define methods beforeBuild, afterBuild, onFail
     * -then build each target
     * -once all the targets are done being built redirct to show page of that job
     */
    def save() {
        log.error("SAVE PARAMS: $params")

        /* inputs['variants'] == [file1, file2, ...]
         */ 
        Map inputs = new LinkedHashMap();
        params.each { p, v ->
            def m = (p =~ /^[^\d]+/)
            if (m.getCount() == 1) {
                def inputTable = m[0]
                if (PipelineInput.inputTables.contains(inputTable)) {
                    def inputKey = inputTable + 's'
                    if (!inputs.containsKey(inputTable)) {
                        inputs[inputKey] = []
                    }
                    inputs[inputKey].push(new BufferedReader(new InputStreamReader(v.getInputStream())))
                }
            }
        }
        log.error("INPUT PARAMS: $inputs")

        def jobInstance = new Job(params)
        if (!jobInstance.save(flush: true)) {
            log.error('bad pipeline job')
            render(view: "create", model: [jobInstance: jobInstance, dependencyGraphJSON: dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator)])
            /* Return a status code other than 200 so that the client can handle invalid input errors appropriately.
             */
            response.status = 400
            return
        }

        try {
            /* Run the pipeline
             */ 
            withSql(dataSource) { sql ->
                def jobId = jobInstance.id
                def (_, job) = Pipeline.pipelineJob(inputs + [jobId: jobInstance.id], sql)
                def beforeBuild = { d ->
                    def jobState = new JobState(job: jobInstance, target: d.target, state: 'running')
                    log.error("before build: ${jobState.properties}")
                    jobState.save(flush: true)
                }
                def afterBuild = { d ->
                    def jobState = JobState.jobTarget(jobId, d.target).get()
                    jobState.state = 'done'
                    log.error("after build: ${jobState.properties}")
                    jobState.save(flush: true)
                }
                def onFail = { d, e ->
                    def jobState = JobState.jobTarget(jobId, d.target).get()
                    jobState.state = 'failed'
                    log.error("failed: ${jobState.properties}")
                    jobState.save(flush: true)
                }


                job.values().each { dependency ->
                    dependency.beforeBuild += beforeBuild 
                    dependency.afterBuild += afterBuild 
                    dependency.onFail += onFail
                }
                Pipeline.buildAll(job)
            } 
        } catch (InvalidInputException e) {
            jobInstance.refresh()
            /* Don't delete the job on failure, since otherwise /pipelineJob/status might miss this occurence (race 
             * condition).
             * jobInstance.delete(flush: true)
             */
            jobInstance.errors.reject('job.errors.invalidInput', e.message)
            render(view: "create", model: [jobInstance: jobInstance, dependencyGraphJSON: dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator)])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'job.label', default: 'Job'), jobInstance.id])
        redirect(action: "show", id: jobInstance.id)
    }

    def show(Long id, String jobName) {
        def jobInstance = getJob(id, jobName) { identifier -> }
        if (!jobInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'job.label', default: 'Job'), id])
            redirect(action: "list")
            return
        }

        /* Defining the dependency graph with current job 
         */
        def json
        withSql(dataSource) { sql ->
            json = dependencyGraphJSON(grailsLinkGenerator: grailsLinkGenerator, sql: sql, job_id: jobInstance.id, counts: true)
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

    /* Defining dependencyGraphJSON
     * takes in map
     * Dispalys Counts on the target if map.counts=true
     * Displays Sample Input files if map.sampleInputs = true
     * running function levels on the dependencies
     * returns JSON of dependency Graph, which includes level and dependencies
     */
    def private static dependencyGraphJSON(Map kwargs = [:])  {

        if (kwargs.counts == null) { kwargs.counts = false }
        if (kwargs.sampleInputs == null) { kwargs.sampleInputs = false }
        def (tbl, dependencies) = Pipeline.dependencyGraph()
        List deps = dependencies.values().collect { d ->
            Util.makeRenderable(d) 
        } 
        if (kwargs.counts) {
            deps.each { d ->
                /* add counts for tables
                 */
                d['count'] = kwargs.sql.rows("select count(*) as count from ${d.table} where job_id = :job_id", kwargs)[0]['count']
                d['jobId'] = kwargs.job_id
                d['listUrl'] = kwargs.grailsLinkGenerator.link(controller: d.table.replaceAll(/_([a-z])/, { it[0][1].toUpperCase() }), action: "listTemplate") 
            }
        }

        if (kwargs.sampleInputs) {
            deps.each { d ->
                /* add sample input for each dependency
                 */ 
                def filename = "/sample_input/${d.target}.txt"
                def rows = []
                try {
                    def absoluteFilename = kwargs.context.getResource(filename).getFile().getCanonicalPath()
                    Input.dsv(absoluteFilename, asList: true).each { row ->
                        rows.add(row) 
                        /* row is a list of strings, e.g. [PLATE, EXPERIMENT, CHIP, WELL_POSITION, ASSAY_ID, GENOTYPE_ID, DESCRIPTION, SAMPLE_ID, ENTRY_OPERATOR]
                         */
                    } 
                    d['header']=rows[0]
                    d['rows'] = rows[1,2..rows.size()-1]
                } catch (FileNotFoundException e) {
                    /* don't add rows/ headers since we don't have a sample input file
                     */
                } 
            }
        }
		
        Map<Dependency, Integer> level = Dependency.levels(dependencies.values())
		Map<Dependency, Integer> rowLevel = Dependency.rowLvls(dependencies.values() as Set)
		
        def depGraph = [
            level: level,
			rowLevel: rowLevel,
            dependencies: deps,
        ]

        return depGraph as JSON
    }

    /** Outputs a report as text file (for the current response).
     *
     * Optional:
     * @param id a job_id
     * @param kwargs.filename the name of the output file (HTTP header)
     * @param kwargs.output a function of type ( iterable, java.io.Writer -> void ) that writes the 
     * iterable to the response output stream
     * @param generateReport a function from haplorec.util.pipeline.Report (which generates the 
     * iterable passed to kwargs.output
     */ 
    def private report(Map kwargs = [:], Long id, generateReport) {
        if (kwargs.filename == null) { kwargs.filename = 'output.txt' }
        if (kwargs.output == null) {
            kwargs.output = Row.&asDSV
        }

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

            response.outputStream.withWriter { writer ->
                kwargs.output(rows, writer)
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

    /* Creating reports for genotypeDrugRecommendation, phenotypeDrugRecommendation and novelHaplotypes
     */
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

    /* Takes in id and outputs data from each gene's geneHaplotypeMatrix
     * as a textfile
     */
    def novelHaplotypeReport(Long id) {
        report(id, Report.&novelHaplotypeReport,
            filename: 'novel_haplotype_report.txt', 
            output: { rows, writer ->

                /* for each gene
                 */
                rows.each { geneHaplotypeMatrix ->
                    /* Output a gene header
                     */
                    writer.append(geneHaplotypeMatrix.geneName)
                    writer.append(System.getProperty("line.separator"))
                    Row.asDSV(new Object() {
                        def each(Closure f) {
                            /* Ouput Haplotype header and snpIds headers on one line
                             */
                            f(["Haplotype"] + geneHaplotypeMatrix.snpIds)
                            geneHaplotypeMatrix.each { haplotype, alleles ->
                                String haplotypeStr
                                if (haplotype instanceof NovelHaplotype) {
                                    haplotypeStr = "${haplotype.patientId}, chr${haplotype.physicalChromosome} (${haplotype.hetCombo ?: 1}/${haplotype.hetCombos ?: 1})"
                                } else {
                                    assert haplotype instanceof Haplotype
                                    haplotypeStr = haplotype.haplotypeName
                                }
                                /* For each haplotype and alleles pair
                                 * output haplotypestr under the Haplotype Header and 
                                 * the alleles under the snpIds headers
                                 */
                                f([haplotypeStr] + alleles)
                            }
                        }
                    }, writer)
                    writer.append(System.getProperty("line.separator"))
                }
            },
        )
    }

    def main() {}

    /* Checks if the job exists 
     * and returns jobInstance if the Job exits
     */
    private Job getJob(Long jobId, String jobName, Closure notFound) {
        def jobInstance = null
        if (jobId != null) {
            jobInstance = Job.get(jobId)
            if (!jobInstance) {
                notFound(jobId)
            }
        } else if (jobName != null) {
            jobInstance = Job.findByJobName(jobName)
            if (!jobInstance) {
                notFound(jobName)
            }
        } else {
            notFound(null)
        }
        return jobInstance
    }
    // SPHINX insert
    /* Render a response consisting of newline separated JSON objects:
     * { target: "variant", state: "running" }
     * { target: "variant", state: "done" }
     * { target: "geneHaplotype", state: "running" }
     * ...
     *
     * Each JSON object represents a state update to a target in the pipeline, where the possible 
     * states are 'running', 'done', and 'failed' (refer to src/sql/mysql/haplorec_wui.sql for the 
     * meaning of the states).
     *
     * The response will continue to render (in one long GET request) if the job is in the midst of 
     * processing, and the client will incrementally receive the state updates as the job processes.
     *
     * 
     *
     */
     
    def status(Long jobId, String jobName) {

        def jobInstance = getJob(jobId, jobName) { identifier ->
            /* The default HTTP reponse for grails renders an error page, but the status code is 
             * still "200 OK". Send back an error code so the client knows to keep polling until the 
             * Job gets created.
             */
            response.status = 404
        }
        
        if (!jobInstance) {
            return
        }

        response.contentType = 'application/json'
        response.outputStream.flush()
        def pollTimeout = 1 
         
        def (_, dependencies) = Pipeline.dependencyGraph() 

        /*Checks if the Job is done or if one of the dependencies failed by checking states
         */
        def jobDone = {rows ->

            return (
                 rows.find{ it.state == 'failed' } != null ||
                 (rows.findAll{it.state == 'done'}.collect{it.target} as Set) == dependencies.keySet()
            )

        }

        /* Convert a JobState object to JSON.
         */
        def json = { jobState ->
            def jobStateProps = ['target', 'state'].inject([:]) { m, prop ->
              m[prop] = jobState[prop]
              m
            }
            (jobStateProps as JSON).toString()
        }

        def request_timeout = 10
        def start_time = System.currentTimeMillis()
        def rows=[]

        /* Ouputs any new or changed rows from job_state table, and
         * stops if jobDone returns true or time exceeds 10 minutes
         */
        withSql(dataSource) { sql ->
            while (true) {
                def new_rows = sql.rows('select * from job_state where job_id = :jobId order by id', [jobId:jobInstance.id])
                if ((rows.collect{it.state}!=new_rows.collect{it.state})){
                    response.outputStream <<  new_rows.findAll{!(it in rows)}.collect { json(it) + '\n' }.join('')
                    response.outputStream.flush()

                    rows = new_rows
                }

                def time_passed = start_time - System.currentTimeMillis()
                if (jobDone(rows) || time_passed >= request_timeout*60*1000) {
                    log.error("its done or failed")
                    break
                }
                sleep(pollTimeout*1000)
            }
        }
         
    }
    // SPHINX end insert

}
