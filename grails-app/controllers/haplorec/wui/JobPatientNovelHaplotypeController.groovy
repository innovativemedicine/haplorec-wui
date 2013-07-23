package haplorec.wui

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import haplorec.wui.Util
import javax.sql.DataSource
import haplorec.util.pipeline.Report
import haplorec.util.pipeline.Report.GeneHaplotypeMatrix
import haplorec.util.pipeline.Report.GeneHaplotypeMatrix.NovelHaplotype
import haplorec.util.pipeline.Report.GeneHaplotypeMatrix.Haplotype


@Mixin(JobPatientControllerMixin)
class JobPatientNovelHaplotypeController {
    DataSource dataSource

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    private def geneHaplotypeMatrixJSON(geneHaplotypeMatrix) {
        def matrix = [:]
		matrix=[geneName: geneHaplotypeMatrix.geneName, snpIds:geneHaplotypeMatrix.snpIds,haplotypes:[],novelHaplotypes:[]]
        geneHaplotypeMatrix.each { haplotype, alleles ->
            /* Add attributes mimicing JSON structure to matrix.
             */
            if (haplotype instanceof NovelHaplotype) {
                matrix.novelHaplotypes.add([sampleId: haplotype.patientId, physicalChromosome: haplotype.physicalChromosome, alleles: alleles])
            } else {
                matrix.haplotypes.add([haplotypeName: haplotype.haplotypeName, alleles: alleles])
            }
        }
        return matrix
    }

    private def addMatrixJSON(model) {
            def matrices = []
            /* Add matrixJSON to model.
             */
            Util.withSql(dataSource) { sql ->
                Report.novelHaplotypeReport([sqlParams: [job_id: model.jobId]], sql).each { geneHaplotypeMatrix ->
                    matrices.add(geneHaplotypeMatrixJSON(geneHaplotypeMatrix))
                }
            }
            model.matrixJSON = ([geneNameList: matrices.collect{it.geneName}, matrices: matrices] as JSON)
    }

	def list(Integer max, Long jobId) { 
        jobPatientList(JobPatientNovelHaplotype, max, jobId, withModel: this.&addMatrixJSON) 
    }

	def listTemplate(Integer max, Long jobId) { jobPatientListTemplate(JobPatientNovelHaplotype, max, jobId, withModel: this.&addMatrixJSON) }

    def create() {
        [jobPatientNovelHaplotypeInstance: new JobPatientNovelHaplotype(params)]
    }

    def save() {
        def jobPatientNovelHaplotypeInstance = new JobPatientNovelHaplotype(params)
        if (!jobPatientNovelHaplotypeInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientNovelHaplotypeInstance: jobPatientNovelHaplotypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype'), jobPatientNovelHaplotypeInstance.id])
        redirect(action: "show", id: jobPatientNovelHaplotypeInstance.id)
    }

    def show(Long id) {
        def jobPatientNovelHaplotypeInstance = JobPatientNovelHaplotype.get(id)
        if (!jobPatientNovelHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientNovelHaplotypeInstance: jobPatientNovelHaplotypeInstance]
    }

    def edit(Long id) {
        def jobPatientNovelHaplotypeInstance = JobPatientNovelHaplotype.get(id)
        if (!jobPatientNovelHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientNovelHaplotypeInstance: jobPatientNovelHaplotypeInstance]
    }

    def update(Long id, Long version) {
        def jobPatientNovelHaplotypeInstance = JobPatientNovelHaplotype.get(id)
        if (!jobPatientNovelHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientNovelHaplotypeInstance.version > version) {
                jobPatientNovelHaplotypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype')] as Object[],
                          "Another user has updated this JobPatientNovelHaplotype while you were editing")
                render(view: "edit", model: [jobPatientNovelHaplotypeInstance: jobPatientNovelHaplotypeInstance])
                return
            }
        }

        jobPatientNovelHaplotypeInstance.properties = params

        if (!jobPatientNovelHaplotypeInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientNovelHaplotypeInstance: jobPatientNovelHaplotypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype'), jobPatientNovelHaplotypeInstance.id])
        redirect(action: "show", id: jobPatientNovelHaplotypeInstance.id)
    }

    def delete(Long id) {
        def jobPatientNovelHaplotypeInstance = JobPatientNovelHaplotype.get(id)
        if (!jobPatientNovelHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientNovelHaplotypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientNovelHaplotype.label', default: 'JobPatientNovelHaplotype'), id])
            redirect(action: "show", id: id)
        }
    }
}
