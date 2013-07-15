package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

@Mixin(JobPatientControllerMixin)
class JobPatientNovelHaplotypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

	def list(Integer max, Long jobId) { jobPatientList(JobPatientNovelHaplotype, max, jobId) }

	def listTemplate(Integer max, Long jobId) { jobPatientListTemplate(JobPatientNovelHaplotype, max, jobId) }

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
