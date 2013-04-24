package haplorec.wui

import org.springframework.dao.DataIntegrityViolationException

class GeneHaplotypeVariantController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [geneHaplotypeVariantInstanceList: GeneHaplotypeVariant.list(params), geneHaplotypeVariantInstanceTotal: GeneHaplotypeVariant.count()]
    }

    def create() {
        [geneHaplotypeVariantInstance: new GeneHaplotypeVariant(params)]
    }

    def save() {
        def geneHaplotypeVariantInstance = new GeneHaplotypeVariant(params)
        if (!geneHaplotypeVariantInstance.save(flush: true)) {
            render(view: "create", model: [geneHaplotypeVariantInstance: geneHaplotypeVariantInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant'), geneHaplotypeVariantInstance.id])
        redirect(action: "show", id: geneHaplotypeVariantInstance.id)
    }

    def show(Long id) {
        def geneHaplotypeVariantInstance = GeneHaplotypeVariant.get(id)
        if (!geneHaplotypeVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant'), id])
            redirect(action: "list")
            return
        }

        [geneHaplotypeVariantInstance: geneHaplotypeVariantInstance]
    }

    def edit(Long id) {
        def geneHaplotypeVariantInstance = GeneHaplotypeVariant.get(id)
        if (!geneHaplotypeVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant'), id])
            redirect(action: "list")
            return
        }

        [geneHaplotypeVariantInstance: geneHaplotypeVariantInstance]
    }

    def update(Long id, Long version) {
        def geneHaplotypeVariantInstance = GeneHaplotypeVariant.get(id)
        if (!geneHaplotypeVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (geneHaplotypeVariantInstance.version > version) {
                geneHaplotypeVariantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant')] as Object[],
                          "Another user has updated this GeneHaplotypeVariant while you were editing")
                render(view: "edit", model: [geneHaplotypeVariantInstance: geneHaplotypeVariantInstance])
                return
            }
        }

        geneHaplotypeVariantInstance.properties = params

        if (!geneHaplotypeVariantInstance.save(flush: true)) {
            render(view: "edit", model: [geneHaplotypeVariantInstance: geneHaplotypeVariantInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant'), geneHaplotypeVariantInstance.id])
        redirect(action: "show", id: geneHaplotypeVariantInstance.id)
    }

    def delete(Long id) {
        def geneHaplotypeVariantInstance = GeneHaplotypeVariant.get(id)
        if (!geneHaplotypeVariantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant'), id])
            redirect(action: "list")
            return
        }

        try {
            geneHaplotypeVariantInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'geneHaplotypeVariant.label', default: 'GeneHaplotypeVariant'), id])
            redirect(action: "show", id: id)
        }
    }
}
