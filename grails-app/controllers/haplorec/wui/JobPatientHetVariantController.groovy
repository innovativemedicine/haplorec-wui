package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

@Mixin(JobPatientControllerMixin)
class JobPatientHetVariantController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

	def list(Integer max, Long jobId) { jobPatientList(JobPatientHetVariant, max, jobId) }
	
	def listTemplate(Integer max, Long jobId) { jobPatientListTemplate(JobPatientHetVariant, max, jobId) }
	
    def create() {
        [jobPatientHetVariantInstance: new JobPatientHetVariant(params)]
    }

    def save() {
        def jobPatientHetVariantInstance = new JobPatientHetVariant(params)
        if (!jobPatientHetVariantInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientHetVariantInstance: jobPatientHetVariantInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant'), jobPatientHetVariantInstance.id])
        redirect(action: "show", id: jobPatientHetVariantInstance.id)
    }

    def show(Long id) {
        def jobPatientHetVariantInstance = JobPatientHetVariant.get(id)
        if (!jobPatientHetVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant'), id])
            redirect(action: "list")
            return
        }

        [jobPatientHetVariantInstance: jobPatientHetVariantInstance]
    }

    def edit(Long id) {
        def jobPatientHetVariantInstance = JobPatientHetVariant.get(id)
        if (!jobPatientHetVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant'), id])
            redirect(action: "list")
            return
        }

        [jobPatientHetVariantInstance: jobPatientHetVariantInstance]
    }

    def update(Long id, Long version) {
        def jobPatientHetVariantInstance = JobPatientHetVariant.get(id)
        if (!jobPatientHetVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientHetVariantInstance.version > version) {
                jobPatientHetVariantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant')] as Object[],
                          "Another user has updated this JobPatientHetVariant while you were editing")
                render(view: "edit", model: [jobPatientHetVariantInstance: jobPatientHetVariantInstance])
                return
            }
        }

        jobPatientHetVariantInstance.properties = params

        if (!jobPatientHetVariantInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientHetVariantInstance: jobPatientHetVariantInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant'), jobPatientHetVariantInstance.id])
        redirect(action: "show", id: jobPatientHetVariantInstance.id)
    }

    def delete(Long id) {
        def jobPatientHetVariantInstance = JobPatientHetVariant.get(id)
        if (!jobPatientHetVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientHetVariantInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientHetVariant.label', default: 'JobPatientHetVariant'), id])
            redirect(action: "show", id: id)
        }
    }
}
