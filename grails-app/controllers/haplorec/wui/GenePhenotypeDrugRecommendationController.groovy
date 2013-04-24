package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class GenePhenotypeDrugRecommendationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [genePhenotypeDrugRecommendationInstanceList: GenePhenotypeDrugRecommendation.list(params), genePhenotypeDrugRecommendationInstanceTotal: GenePhenotypeDrugRecommendation.count()]
    }

    def create() {
        [genePhenotypeDrugRecommendationInstance: new GenePhenotypeDrugRecommendation(params)]
    }

    def save() {
        def genePhenotypeDrugRecommendationInstance = new GenePhenotypeDrugRecommendation(params)
        if (!genePhenotypeDrugRecommendationInstance.save(flush: true)) {
            render(view: "create", model: [genePhenotypeDrugRecommendationInstance: genePhenotypeDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation'), genePhenotypeDrugRecommendationInstance.id])
        redirect(action: "show", id: genePhenotypeDrugRecommendationInstance.id)
    }

    def show(Long id) {
        def genePhenotypeDrugRecommendationInstance = GenePhenotypeDrugRecommendation.get(id)
        if (!genePhenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [genePhenotypeDrugRecommendationInstance: genePhenotypeDrugRecommendationInstance]
    }

    def edit(Long id) {
        def genePhenotypeDrugRecommendationInstance = GenePhenotypeDrugRecommendation.get(id)
        if (!genePhenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        [genePhenotypeDrugRecommendationInstance: genePhenotypeDrugRecommendationInstance]
    }

    def update(Long id, Long version) {
        def genePhenotypeDrugRecommendationInstance = GenePhenotypeDrugRecommendation.get(id)
        if (!genePhenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (genePhenotypeDrugRecommendationInstance.version > version) {
                genePhenotypeDrugRecommendationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation')] as Object[],
                          "Another user has updated this GenePhenotypeDrugRecommendation while you were editing")
                render(view: "edit", model: [genePhenotypeDrugRecommendationInstance: genePhenotypeDrugRecommendationInstance])
                return
            }
        }

        genePhenotypeDrugRecommendationInstance.properties = params

        if (!genePhenotypeDrugRecommendationInstance.save(flush: true)) {
            render(view: "edit", model: [genePhenotypeDrugRecommendationInstance: genePhenotypeDrugRecommendationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation'), genePhenotypeDrugRecommendationInstance.id])
        redirect(action: "show", id: genePhenotypeDrugRecommendationInstance.id)
    }

    def delete(Long id) {
        def genePhenotypeDrugRecommendationInstance = GenePhenotypeDrugRecommendation.get(id)
        if (!genePhenotypeDrugRecommendationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation'), id])
            redirect(action: "list")
            return
        }

        try {
            genePhenotypeDrugRecommendationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'genePhenotypeDrugRecommendation.label', default: 'GenePhenotypeDrugRecommendation'), id])
            redirect(action: "show", id: id)
        }
    }
}
