package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

@Mixin(JobPatientControllerMixin)
class JobPatientGenotypeDrugRecommendationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
	
	def list(Integer max, Long jobId) { jobPatientList(JobPatientGenotypeDrugRecommendation, max, jobId) }
	
	def listTemplate(Integer max, Long jobId) { jobPatientListTemplate(JobPatientGenotypeDrugRecommendation, max, jobId) }
	
    def create() {
        [jobPatientGenotypeDrugRecommendationInstance: new JobPatientGenotypeDrugRecommendation(params)]
    }

    def save() {
        def jobPatientGenotypeDrugRecommendationInstance = new JobPatientGenotypeDrugRecommendation(params)
        if (!jobPatientGenotypeDrugRecommendationInstance.save(flush: true)) {
            render(view: "create", model: [jobPatientGenotypeDrugRecommendationInstance: jobPatientGenotypeDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation'), jobPatientGenotypeDrugRecommendationInstance.id])
        redirect(action: "show", id: jobPatientGenotypeDrugRecommendationInstance.id)
    }

    def show(Long id) {
        def jobPatientGenotypeDrugRecommendationInstance = JobPatientGenotypeDrugRecommendation.get(id)
        if (!jobPatientGenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [jobPatientGenotypeDrugRecommendationInstance: jobPatientGenotypeDrugRecommendationInstance]
    }

    def edit(Long id) {
        def jobPatientGenotypeDrugRecommendationInstance = JobPatientGenotypeDrugRecommendation.get(id)
        if (!jobPatientGenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [jobPatientGenotypeDrugRecommendationInstance: jobPatientGenotypeDrugRecommendationInstance]
    }

    def update(Long id, Long version) {
        def jobPatientGenotypeDrugRecommendationInstance = JobPatientGenotypeDrugRecommendation.get(id)
        if (!jobPatientGenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (jobPatientGenotypeDrugRecommendationInstance.version > version) {
                jobPatientGenotypeDrugRecommendationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation')] as Object[],
                          "Another user has updated this JobPatientGenotypeDrugRecommendation while you were editing")
                render(view: "edit", model: [jobPatientGenotypeDrugRecommendationInstance: jobPatientGenotypeDrugRecommendationInstance])
                return
            }
        }

        jobPatientGenotypeDrugRecommendationInstance.properties = params

        if (!jobPatientGenotypeDrugRecommendationInstance.save(flush: true)) {
            render(view: "edit", model: [jobPatientGenotypeDrugRecommendationInstance: jobPatientGenotypeDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation'), jobPatientGenotypeDrugRecommendationInstance.id])
        redirect(action: "show", id: jobPatientGenotypeDrugRecommendationInstance.id)
    }

    def delete(Long id) {
        def jobPatientGenotypeDrugRecommendationInstance = JobPatientGenotypeDrugRecommendation.get(id)
        if (!jobPatientGenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        try {
            jobPatientGenotypeDrugRecommendationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'jobPatientGenotypeDrugRecommendation.label', default: 'JobPatientGenotypeDrugRecommendation'), id])
            redirect(action: "show", id: id)
        }
    }
}
