package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class JobPatientVariantController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobPatientVariantInstanceList: JobPatientVariant.list(params), jobPatientVariantInstanceTotal: JobPatientVariant.count()]
    }

    def create() {
        [jobPatientVariantInstance: new JobPatientVariant(params)]
    }

    def save() {
        def jobPatientVariantInstance = new JobPatientVariant(params)
        if (!jobPatientVariantInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientVariantInstance: jobPatientVariantInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant'), jobPatientVariantInstance.id])
        redirect(action: "show", id: jobPatientVariantInstance.id)
    }

    def show(Long id) {
        def jobPatientVariantInstance = JobPatientVariant.get(id)
        if (!jobPatientVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant'), id])
            redirect(action: "list")
            return
        }

        [jobPatientVariantInstance: jobPatientVariantInstance]
    }

    def edit(Long id) {
        def jobPatientVariantInstance = JobPatientVariant.get(id)
        if (!jobPatientVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant'), id])
            redirect(action: "list")
            return
        }

        [jobPatientVariantInstance: jobPatientVariantInstance]
    }

    def update(Long id, Long version) {
        def jobPatientVariantInstance = JobPatientVariant.get(id)
        if (!jobPatientVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientVariantInstance.version > version) {
                jobPatientVariantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant')] as Object[],
                          "Another user has updated this JobPatientVariant while you were editing")
                render(view: "edit", model: [jobPatientVariantInstance: jobPatientVariantInstance])
                return
            }
        }

        jobPatientVariantInstance.properties = params

        if (!jobPatientVariantInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientVariantInstance: jobPatientVariantInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant'), jobPatientVariantInstance.id])
        redirect(action: "show", id: jobPatientVariantInstance.id)
    }

    def delete(Long id) {
        def jobPatientVariantInstance = JobPatientVariant.get(id)
        if (!jobPatientVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientVariantInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientVariant.label', default: 'JobPatientVariant'), id])
            redirect(action: "show", id: id)
        }
    }
}
