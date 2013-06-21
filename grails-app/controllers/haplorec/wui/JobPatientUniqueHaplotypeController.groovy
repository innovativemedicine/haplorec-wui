package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

@Mixin(JobPatientControllerMixin)
class JobPatientUniqueHaplotypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

	def list(Integer max, Long jobId) { jobPatientList(JobPatientUniqueHaplotype, max, jobId) }

	def listTemplate(Integer max, Long jobId) { jobPatientListTemplate(JobPatientUniqueHaplotype, max, jobId) }

    def create() {
        [jobPatientUniqueHaplotypeInstance: new JobPatientUniqueHaplotype(params)]
    }

    def save() {
        def jobPatientUniqueHaplotypeInstance = new JobPatientUniqueHaplotype(params)
        if (!jobPatientUniqueHaplotypeInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientUniqueHaplotypeInstance: jobPatientUniqueHaplotypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype'), jobPatientUniqueHaplotypeInstance.id])
        redirect(action: "show", id: jobPatientUniqueHaplotypeInstance.id)
    }

    def show(Long id) {
        def jobPatientUniqueHaplotypeInstance = JobPatientUniqueHaplotype.get(id)
        if (!jobPatientUniqueHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientUniqueHaplotypeInstance: jobPatientUniqueHaplotypeInstance]
    }

    def edit(Long id) {
        def jobPatientUniqueHaplotypeInstance = JobPatientUniqueHaplotype.get(id)
        if (!jobPatientUniqueHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientUniqueHaplotypeInstance: jobPatientUniqueHaplotypeInstance]
    }

    def update(Long id, Long version) {
        def jobPatientUniqueHaplotypeInstance = JobPatientUniqueHaplotype.get(id)
        if (!jobPatientUniqueHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientUniqueHaplotypeInstance.version > version) {
                jobPatientUniqueHaplotypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype')] as Object[],
                          "Another user has updated this JobPatientUniqueHaplotype while you were editing")
                render(view: "edit", model: [jobPatientUniqueHaplotypeInstance: jobPatientUniqueHaplotypeInstance])
                return
            }
        }

        jobPatientUniqueHaplotypeInstance.properties = params

        if (!jobPatientUniqueHaplotypeInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientUniqueHaplotypeInstance: jobPatientUniqueHaplotypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype'), jobPatientUniqueHaplotypeInstance.id])
        redirect(action: "show", id: jobPatientUniqueHaplotypeInstance.id)
    }

    def delete(Long id) {
        def jobPatientUniqueHaplotypeInstance = JobPatientUniqueHaplotype.get(id)
        if (!jobPatientUniqueHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientUniqueHaplotypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientUniqueHaplotype.label', default: 'JobPatientUniqueHaplotype'), id])
            redirect(action: "show", id: id)
        }
    }
}
