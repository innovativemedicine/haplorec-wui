package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class DrugRecommendationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [drugRecommendationInstanceList: DrugRecommendation.list(params), drugRecommendationInstanceTotal: DrugRecommendation.count()]
    }

    def create() {
        [drugRecommendationInstance: new DrugRecommendation(params)]
    }

    def save() {
        def drugRecommendationInstance = new DrugRecommendation(params)
        if (!drugRecommendationInstance.save(flush: true)) {
            render(view: "create", model: [drugRecommendationInstance: drugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'drugRecommendation.label', default: 'DrugRecommendation'), drugRecommendationInstance.id])
        redirect(action: "show", id: drugRecommendationInstance.id)
    }

    def show(Long id) {
        def drugRecommendationInstance = DrugRecommendation.get(id)
        if (!drugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'drugRecommendation.label', default: 'DrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [drugRecommendationInstance: drugRecommendationInstance]
    }

    def edit(Long id) {
        def drugRecommendationInstance = DrugRecommendation.get(id)
        if (!drugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'drugRecommendation.label', default: 'DrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [drugRecommendationInstance: drugRecommendationInstance]
    }

    def update(Long id, Long version) {
        def drugRecommendationInstance = DrugRecommendation.get(id)
        if (!drugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'drugRecommendation.label', default: 'DrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (drugRecommendationInstance.version > version) {
                drugRecommendationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'drugRecommendation.label', default: 'DrugRecommendation')] as Object[],
                          "Another user has updated this DrugRecommendation while you were editing")
                render(view: "edit", model: [drugRecommendationInstance: drugRecommendationInstance])
                return
            }
        }

        drugRecommendationInstance.properties = params

        if (!drugRecommendationInstance.save(flush: true)) {
            render(view: "edit", model: [drugRecommendationInstance: drugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'drugRecommendation.label', default: 'DrugRecommendation'), drugRecommendationInstance.id])
        redirect(action: "show", id: drugRecommendationInstance.id)
    }

    def delete(Long id) {
        def drugRecommendationInstance = DrugRecommendation.get(id)
        if (!drugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'drugRecommendation.label', default: 'DrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        try {
            drugRecommendationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'drugRecommendation.label', default: 'DrugRecommendation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'drugRecommendation.label', default: 'DrugRecommendation'), id])
            redirect(action: "show", id: id)
        }
    }
}
