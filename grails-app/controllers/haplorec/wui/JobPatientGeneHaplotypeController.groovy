package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class JobPatientGeneHaplotypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobPatientGeneHaplotypeInstanceList: JobPatientGeneHaplotype.list(params), jobPatientGeneHaplotypeInstanceTotal: JobPatientGeneHaplotype.count()]
    }

    def create() {
        [jobPatientGeneHaplotypeInstance: new JobPatientGeneHaplotype(params)]
    }

    def save() {
        def jobPatientGeneHaplotypeInstance = new JobPatientGeneHaplotype(params)
        if (!jobPatientGeneHaplotypeInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientGeneHaplotypeInstance: jobPatientGeneHaplotypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype'), jobPatientGeneHaplotypeInstance.id])
        redirect(action: "show", id: jobPatientGeneHaplotypeInstance.id)
    }

    def show(Long id) {
        def jobPatientGeneHaplotypeInstance = JobPatientGeneHaplotype.get(id)
        if (!jobPatientGeneHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientGeneHaplotypeInstance: jobPatientGeneHaplotypeInstance]
    }

    def edit(Long id) {
        def jobPatientGeneHaplotypeInstance = JobPatientGeneHaplotype.get(id)
        if (!jobPatientGeneHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientGeneHaplotypeInstance: jobPatientGeneHaplotypeInstance]
    }

    def update(Long id, Long version) {
        def jobPatientGeneHaplotypeInstance = JobPatientGeneHaplotype.get(id)
        if (!jobPatientGeneHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientGeneHaplotypeInstance.version > version) {
                jobPatientGeneHaplotypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype')] as Object[],
                          "Another user has updated this JobPatientGeneHaplotype while you were editing")
                render(view: "edit", model: [jobPatientGeneHaplotypeInstance: jobPatientGeneHaplotypeInstance])
                return
            }
        }

        jobPatientGeneHaplotypeInstance.properties = params

        if (!jobPatientGeneHaplotypeInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientGeneHaplotypeInstance: jobPatientGeneHaplotypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype'), jobPatientGeneHaplotypeInstance.id])
        redirect(action: "show", id: jobPatientGeneHaplotypeInstance.id)
    }

    def delete(Long id) {
        def jobPatientGeneHaplotypeInstance = JobPatientGeneHaplotype.get(id)
        if (!jobPatientGeneHaplotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientGeneHaplotypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientGeneHaplotype.label', default: 'JobPatientGeneHaplotype'), id])
            redirect(action: "show", id: id)
        }
    }
}
