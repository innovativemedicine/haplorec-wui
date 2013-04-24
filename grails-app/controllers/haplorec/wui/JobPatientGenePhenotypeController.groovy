package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class JobPatientGenePhenotypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobPatientGenePhenotypeInstanceList: JobPatientGenePhenotype.list(params), jobPatientGenePhenotypeInstanceTotal: JobPatientGenePhenotype.count()]
    }

    def create() {
        [jobPatientGenePhenotypeInstance: new JobPatientGenePhenotype(params)]
    }

    def save() {
        def jobPatientGenePhenotypeInstance = new JobPatientGenePhenotype(params)
        if (!jobPatientGenePhenotypeInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientGenePhenotypeInstance: jobPatientGenePhenotypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype'), jobPatientGenePhenotypeInstance.id])
        redirect(action: "show", id: jobPatientGenePhenotypeInstance.id)
    }

    def show(Long id) {
        def jobPatientGenePhenotypeInstance = JobPatientGenePhenotype.get(id)
        if (!jobPatientGenePhenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientGenePhenotypeInstance: jobPatientGenePhenotypeInstance]
    }

    def edit(Long id) {
        def jobPatientGenePhenotypeInstance = JobPatientGenePhenotype.get(id)
        if (!jobPatientGenePhenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype'), id])
            redirect(action: "list")
            return
        }

        [jobPatientGenePhenotypeInstance: jobPatientGenePhenotypeInstance]
    }

    def update(Long id, Long version) {
        def jobPatientGenePhenotypeInstance = JobPatientGenePhenotype.get(id)
        if (!jobPatientGenePhenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientGenePhenotypeInstance.version > version) {
                jobPatientGenePhenotypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype')] as Object[],
                          "Another user has updated this JobPatientGenePhenotype while you were editing")
                render(view: "edit", model: [jobPatientGenePhenotypeInstance: jobPatientGenePhenotypeInstance])
                return
            }
        }

        jobPatientGenePhenotypeInstance.properties = params

        if (!jobPatientGenePhenotypeInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientGenePhenotypeInstance: jobPatientGenePhenotypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype'), jobPatientGenePhenotypeInstance.id])
        redirect(action: "show", id: jobPatientGenePhenotypeInstance.id)
    }

    def delete(Long id) {
        def jobPatientGenePhenotypeInstance = JobPatientGenePhenotype.get(id)
        if (!jobPatientGenePhenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientGenePhenotypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientGenePhenotype.label', default: 'JobPatientGenePhenotype'), id])
            redirect(action: "show", id: id)
        }
    }
}
