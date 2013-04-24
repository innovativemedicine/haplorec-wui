package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class GenotypeDrugRecommendationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [genotypeDrugRecommendationInstanceList: GenotypeDrugRecommendation.list(params), genotypeDrugRecommendationInstanceTotal: GenotypeDrugRecommendation.count()]
    }

    def create() {
        [genotypeDrugRecommendationInstance: new GenotypeDrugRecommendation(params)]
    }

    def save() {
        def genotypeDrugRecommendationInstance = new GenotypeDrugRecommendation(params)
        if (!genotypeDrugRecommendationInstance.save(flush: true)) {
            render(view: "create", model: [genotypeDrugRecommendationInstance: genotypeDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation'), genotypeDrugRecommendationInstance.id])
        redirect(action: "show", id: genotypeDrugRecommendationInstance.id)
    }

    def show(Long id) {
        def genotypeDrugRecommendationInstance = GenotypeDrugRecommendation.get(id)
        if (!genotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [genotypeDrugRecommendationInstance: genotypeDrugRecommendationInstance]
    }

    def edit(Long id) {
        def genotypeDrugRecommendationInstance = GenotypeDrugRecommendation.get(id)
        if (!genotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [genotypeDrugRecommendationInstance: genotypeDrugRecommendationInstance]
    }

    def update(Long id, Long version) {
        def genotypeDrugRecommendationInstance = GenotypeDrugRecommendation.get(id)
        if (!genotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (genotypeDrugRecommendationInstance.version > version) {
                genotypeDrugRecommendationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation')] as Object[],
                          "Another user has updated this GenotypeDrugRecommendation while you were editing")
                render(view: "edit", model: [genotypeDrugRecommendationInstance: genotypeDrugRecommendationInstance])
                return
            }
        }

        genotypeDrugRecommendationInstance.properties = params

        if (!genotypeDrugRecommendationInstance.save(flush: true)) {
            render(view: "edit", model: [genotypeDrugRecommendationInstance: genotypeDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation'), genotypeDrugRecommendationInstance.id])
        redirect(action: "show", id: genotypeDrugRecommendationInstance.id)
    }

    def delete(Long id) {
        def genotypeDrugRecommendationInstance = GenotypeDrugRecommendation.get(id)
        if (!genotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        try {
            genotypeDrugRecommendationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'genotypeDrugRecommendation.label', default: 'GenotypeDrugRecommendation'), id])
            redirect(action: "show", id: id)
        }
    }
}
