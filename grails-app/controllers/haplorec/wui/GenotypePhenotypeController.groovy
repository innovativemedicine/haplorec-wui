package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class GenotypePhenotypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [genotypePhenotypeInstanceList: GenotypePhenotype.list(params), genotypePhenotypeInstanceTotal: GenotypePhenotype.count()]
    }

    def create() {
        [genotypePhenotypeInstance: new GenotypePhenotype(params)]
    }

    def save() {
        def genotypePhenotypeInstance = new GenotypePhenotype(params)
        if (!genotypePhenotypeInstance.save(flush: true)) {
            render(view: "create", model: [genotypePhenotypeInstance: genotypePhenotypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype'), genotypePhenotypeInstance.id])
        redirect(action: "show", id: genotypePhenotypeInstance.id)
    }

    def show(Long id) {
        def genotypePhenotypeInstance = GenotypePhenotype.get(id)
        if (!genotypePhenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype'), id])
            redirect(action: "list")
            return
        }

        [genotypePhenotypeInstance: genotypePhenotypeInstance]
    }

    def edit(Long id) {
        def genotypePhenotypeInstance = GenotypePhenotype.get(id)
        if (!genotypePhenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype'), id])
            redirect(action: "list")
            return
        }

        [genotypePhenotypeInstance: genotypePhenotypeInstance]
    }

    def update(Long id, Long version) {
        def genotypePhenotypeInstance = GenotypePhenotype.get(id)
        if (!genotypePhenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (genotypePhenotypeInstance.version > version) {
                genotypePhenotypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype')] as Object[],
                          "Another user has updated this GenotypePhenotype while you were editing")
                render(view: "edit", model: [genotypePhenotypeInstance: genotypePhenotypeInstance])
                return
            }
        }

        genotypePhenotypeInstance.properties = params

        if (!genotypePhenotypeInstance.save(flush: true)) {
            render(view: "edit", model: [genotypePhenotypeInstance: genotypePhenotypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype'), genotypePhenotypeInstance.id])
        redirect(action: "show", id: genotypePhenotypeInstance.id)
    }

    def delete(Long id) {
        def genotypePhenotypeInstance = GenotypePhenotype.get(id)
        if (!genotypePhenotypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype'), id])
            redirect(action: "list")
            return
        }

        try {
            genotypePhenotypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'genotypePhenotype.label', default: 'GenotypePhenotype'), id])
            redirect(action: "show", id: id)
        }
    }
}
