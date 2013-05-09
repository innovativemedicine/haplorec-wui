package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

@Mixin(JobPatientControllerMixin)
class JobPatientPhenotypeDrugRecommendationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
	
	def list(Integer max, Long jobId) { jobPatientList(JobPatientPhenotypeDrugRecommendation, max, jobId) }
	
	def listTemplate(Integer max, Long jobId) { jobPatientListTemplate(JobPatientPhenotypeDrugRecommendation, max, jobId) }
	
    def create() {
        [jobPatientPhenotypeDrugRecommendationInstance: new JobPatientPhenotypeDrugRecommendation(params)]
    }

    def save() {
        def jobPatientPhenotypeDrugRecommendationInstance = new JobPatientPhenotypeDrugRecommendation(params)
        if (!jobPatientPhenotypeDrugRecommendationInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientPhenotypeDrugRecommendationInstance: jobPatientPhenotypeDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation'), jobPatientPhenotypeDrugRecommendationInstance.id])
        redirect(action: "show", id: jobPatientPhenotypeDrugRecommendationInstance.id)
    }

    def show(Long id) {
        def jobPatientPhenotypeDrugRecommendationInstance = JobPatientPhenotypeDrugRecommendation.get(id)
        if (!jobPatientPhenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [jobPatientPhenotypeDrugRecommendationInstance: jobPatientPhenotypeDrugRecommendationInstance]
    }

    def edit(Long id) {
        def jobPatientPhenotypeDrugRecommendationInstance = JobPatientPhenotypeDrugRecommendation.get(id)
        if (!jobPatientPhenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [jobPatientPhenotypeDrugRecommendationInstance: jobPatientPhenotypeDrugRecommendationInstance]
    }

    def update(Long id, Long version) {
        def jobPatientPhenotypeDrugRecommendationInstance = JobPatientPhenotypeDrugRecommendation.get(id)
        if (!jobPatientPhenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientPhenotypeDrugRecommendationInstance.version > version) {
                jobPatientPhenotypeDrugRecommendationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation')] as Object[],
                          "Another user has updated this JobPatientPhenotypeDrugRecommendation while you were editing")
                render(view: "edit", model: [jobPatientPhenotypeDrugRecommendationInstance: jobPatientPhenotypeDrugRecommendationInstance])
                return
            }
        }

        jobPatientPhenotypeDrugRecommendationInstance.properties = params

        if (!jobPatientPhenotypeDrugRecommendationInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientPhenotypeDrugRecommendationInstance: jobPatientPhenotypeDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation'), jobPatientPhenotypeDrugRecommendationInstance.id])
        redirect(action: "show", id: jobPatientPhenotypeDrugRecommendationInstance.id)
    }

    def delete(Long id) {
        def jobPatientPhenotypeDrugRecommendationInstance = JobPatientPhenotypeDrugRecommendation.get(id)
        if (!jobPatientPhenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientPhenotypeDrugRecommendationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientPhenotypeDrugRecommendation.label', default: 'JobPatientPhenotypeDrugRecommendation'), id])
            redirect(action: "show", id: id)
        }
    }
}
