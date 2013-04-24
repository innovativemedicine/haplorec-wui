package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class JobPatientChromosomeVariantController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobPatientChromosomeVariantInstanceList: JobPatientChromosomeVariant.list(params), jobPatientChromosomeVariantInstanceTotal: JobPatientChromosomeVariant.count()]
    }

    def create() {
        [jobPatientChromosomeVariantInstance: new JobPatientChromosomeVariant(params)]
    }

    def save() {
        def jobPatientChromosomeVariantInstance = new JobPatientChromosomeVariant(params)
        if (!jobPatientChromosomeVariantInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientChromosomeVariantInstance: jobPatientChromosomeVariantInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant'), jobPatientChromosomeVariantInstance.id])
        redirect(action: "show", id: jobPatientChromosomeVariantInstance.id)
    }

    def show(Long id) {
        def jobPatientChromosomeVariantInstance = JobPatientChromosomeVariant.get(id)
        if (!jobPatientChromosomeVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant'), id])
            redirect(action: "list")
            return
        }

        [jobPatientChromosomeVariantInstance: jobPatientChromosomeVariantInstance]
    }

    def edit(Long id) {
        def jobPatientChromosomeVariantInstance = JobPatientChromosomeVariant.get(id)
        if (!jobPatientChromosomeVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant'), id])
            redirect(action: "list")
            return
        }

        [jobPatientChromosomeVariantInstance: jobPatientChromosomeVariantInstance]
    }

    def update(Long id, Long version) {
        def jobPatientChromosomeVariantInstance = JobPatientChromosomeVariant.get(id)
        if (!jobPatientChromosomeVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientChromosomeVariantInstance.version > version) {
                jobPatientChromosomeVariantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant')] as Object[],
                          "Another user has updated this JobPatientChromosomeVariant while you were editing")
                render(view: "edit", model: [jobPatientChromosomeVariantInstance: jobPatientChromosomeVariantInstance])
                return
            }
        }

        jobPatientChromosomeVariantInstance.properties = params

        if (!jobPatientChromosomeVariantInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientChromosomeVariantInstance: jobPatientChromosomeVariantInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant'), jobPatientChromosomeVariantInstance.id])
        redirect(action: "show", id: jobPatientChromosomeVariantInstance.id)
    }

    def delete(Long id) {
        def jobPatientChromosomeVariantInstance = JobPatientChromosomeVariant.get(id)
        if (!jobPatientChromosomeVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientChromosomeVariantInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientChromosomeVariant.label', default: 'JobPatientChromosomeVariant'), id])
            redirect(action: "show", id: id)
        }
    }
}
