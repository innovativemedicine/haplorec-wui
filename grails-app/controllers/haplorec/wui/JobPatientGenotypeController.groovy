package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class JobPatientGenotypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobPatientGenotypeInstanceList: JobPatientGenotype.list(params), jobPatientGenotypeInstanceTotal: JobPatientGenotype.count()]
    }

    def create() {
        [jobPatientGenotypeInstance: new JobPatientGenotype(params)]
    }

    def save() {
        def jobPatientGenotypeInstance = new JobPatientGenotype(params)
        if (!jobPatientGenotypeInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientGenotypeInstance: jobPatientGenotypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype'), jobPatientGenotypeInstance.id])
        redirect(action: "show", id: jobPatientGenotypeInstance.id)
    }

    def show(Long id) {
        def jobPatientGenotypeInstance = JobPatientGenotype.get(id)
        if (!jobPatientGenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientGenotypeInstance: jobPatientGenotypeInstance]
    }

    def edit(Long id) {
        def jobPatientGenotypeInstance = JobPatientGenotype.get(id)
        if (!jobPatientGenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientGenotypeInstance: jobPatientGenotypeInstance]
    }

    def update(Long id, Long version) {
        def jobPatientGenotypeInstance = JobPatientGenotype.get(id)
        if (!jobPatientGenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientGenotypeInstance.version > version) {
                jobPatientGenotypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype')] as Object[],
                          "Another user has updated this JobPatientGenotype while you were editing")
                render(view: "edit", model: [jobPatientGenotypeInstance: jobPatientGenotypeInstance])
                return
            }
        }

        jobPatientGenotypeInstance.properties = params

        if (!jobPatientGenotypeInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientGenotypeInstance: jobPatientGenotypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype'), jobPatientGenotypeInstance.id])
        redirect(action: "show", id: jobPatientGenotypeInstance.id)
    }

    def delete(Long id) {
        def jobPatientGenotypeInstance = JobPatientGenotype.get(id)
        if (!jobPatientGenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientGenotypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientGenotype.label', default: 'JobPatientGenotype'), id])
            redirect(action: "show", id: id)
        }
    }
}
