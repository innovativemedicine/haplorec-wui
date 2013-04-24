package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class JobPatientDrugRecommendationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [jobPatientDrugRecommendationInstanceList: JobPatientDrugRecommendation.list(params), jobPatientDrugRecommendationInstanceTotal: JobPatientDrugRecommendation.count()]
    }

    def create() {
        [jobPatientDrugRecommendationInstance: new JobPatientDrugRecommendation(params)]
    }

    def save() {
        def jobPatientDrugRecommendationInstance = new JobPatientDrugRecommendation(params)
        if (!jobPatientDrugRecommendationInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientDrugRecommendationInstance: jobPatientDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation'), jobPatientDrugRecommendationInstance.id])
        redirect(action: "show", id: jobPatientDrugRecommendationInstance.id)
    }

    def show(Long id) {
        def jobPatientDrugRecommendationInstance = JobPatientDrugRecommendation.get(id)
        if (!jobPatientDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [jobPatientDrugRecommendationInstance: jobPatientDrugRecommendationInstance]
    }

    def edit(Long id) {
        def jobPatientDrugRecommendationInstance = JobPatientDrugRecommendation.get(id)
        if (!jobPatientDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [jobPatientDrugRecommendationInstance: jobPatientDrugRecommendationInstance]
    }

    def update(Long id, Long version) {
        def jobPatientDrugRecommendationInstance = JobPatientDrugRecommendation.get(id)
        if (!jobPatientDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientDrugRecommendationInstance.version > version) {
                jobPatientDrugRecommendationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation')] as Object[],
                          "Another user has updated this JobPatientDrugRecommendation while you were editing")
                render(view: "edit", model: [jobPatientDrugRecommendationInstance: jobPatientDrugRecommendationInstance])
                return
            }
        }

        jobPatientDrugRecommendationInstance.properties = params

        if (!jobPatientDrugRecommendationInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientDrugRecommendationInstance: jobPatientDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation'), jobPatientDrugRecommendationInstance.id])
        redirect(action: "show", id: jobPatientDrugRecommendationInstance.id)
    }

    def delete(Long id) {
        def jobPatientDrugRecommendationInstance = JobPatientDrugRecommendation.get(id)
        if (!jobPatientDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientDrugRecommendationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientDrugRecommendation.label', default: 'JobPatientDrugRecommendation'), id])
            redirect(action: "show", id: id)
        }
    }
}
