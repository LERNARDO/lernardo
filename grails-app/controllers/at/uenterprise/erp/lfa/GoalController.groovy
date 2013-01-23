package at.uenterprise.erp.lfa

import org.springframework.dao.DataIntegrityViolationException

class GoalController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [goalInstanceList: Goal.list(params), goalInstanceTotal: Goal.count()]
    }

    def create() {
        [goalInstance: new Goal(params)]
    }

    def create_new() {

    }

    def save() {
        def goalInstance = new Goal(params)
        goalInstance.type = "main"
        if (!goalInstance.save(flush: true)) {
            render(view: "create", model: [goalInstance: goalInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'goal.label', default: 'Goal'), goalInstance.id])
        redirect(action: "show", id: goalInstance.id)
    }

    def show() {
        def goalInstance = Goal.get(params.id)
        if (!goalInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'goal.label', default: 'Goal'), params.id])
            redirect(action: "list")
            return
        }

        [goalInstance: goalInstance]
    }

    def edit() {
        def goalInstance = Goal.get(params.id)
        if (!goalInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'goal.label', default: 'Goal'), params.id])
            redirect(action: "list")
            return
        }

        [goalInstance: goalInstance]
    }

    def update() {
        def goalInstance = Goal.get(params.id)
        if (!goalInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'goal.label', default: 'Goal'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (goalInstance.version > version) {
                goalInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'goal.label', default: 'Goal')] as Object[],
                        "Another user has updated this Goal while you were editing")
                render(view: "edit", model: [goalInstance: goalInstance])
                return
            }
        }

        goalInstance.properties = params

        if (!goalInstance.save(flush: true)) {
            render(view: "edit", model: [goalInstance: goalInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'goal.label', default: 'Goal'), goalInstance.id])
        redirect(action: "show", id: goalInstance.id)
    }

    def delete() {
        def goalInstance = Goal.get(params.id)
        if (!goalInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'goal.label', default: 'Goal'), params.id])
            redirect(action: "list")
            return
        }

        try {
            goalInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'goal.label', default: 'Goal'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'goal.label', default: 'Goal'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
