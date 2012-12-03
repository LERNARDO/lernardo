package at.uenterprise.erp.lfa

import org.springframework.dao.DataIntegrityViolationException

class SituationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [situationInstanceList: Situation.list(params), situationInstanceTotal: Situation.count()]
    }

    def create() {
        [situationInstance: new Situation(params)]
    }

    def save() {
        def situationInstance = new Situation(params)
        if (!situationInstance.save(flush: true)) {
            render(view: "create", model: [situationInstance: situationInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'situation.label', default: 'Situation'), situationInstance.id])
        redirect(action: "show", id: situationInstance.id)
    }

    def show() {
        def situationInstance = Situation.get(params.id)
        if (!situationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'situation.label', default: 'Situation'), params.id])
            redirect(action: "list")
            return
        }

        [situationInstance: situationInstance]
    }

    def edit() {
        def situationInstance = Situation.get(params.id)
        if (!situationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'situation.label', default: 'Situation'), params.id])
            redirect(action: "list")
            return
        }

        [situationInstance: situationInstance]
    }

    def update() {
        def situationInstance = Situation.get(params.id)
        if (!situationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'situation.label', default: 'Situation'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (situationInstance.version > version) {
                situationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'situation.label', default: 'Situation')] as Object[],
                          "Another user has updated this Situation while you were editing")
                render(view: "edit", model: [situationInstance: situationInstance])
                return
            }
        }

        situationInstance.properties = params

        if (!situationInstance.save(flush: true)) {
            render(view: "edit", model: [situationInstance: situationInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'situation.label', default: 'Situation'), situationInstance.id])
        redirect(action: "show", id: situationInstance.id)
    }

    def delete() {
        def situationInstance = Situation.get(params.id)
        if (!situationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'situation.label', default: 'Situation'), params.id])
            redirect(action: "list")
            return
        }

        try {
            situationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'situation.label', default: 'Situation'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'situation.label', default: 'Situation'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
