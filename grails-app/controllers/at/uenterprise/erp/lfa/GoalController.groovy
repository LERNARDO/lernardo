package at.uenterprise.erp.lfa

import org.springframework.dao.DataIntegrityViolationException

class GoalController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [goalInstanceList: Maingoal.list(params), goalInstanceTotal: Maingoal.count()]
    }

    def create() {
        [goalInstance: new Goal(params)]
    }

    def show_new() {
        def subgoal = Subgoal.get(params.id)

        [subgoal: subgoal]

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

    def addMainGoal() {
        Maingoal mainGoal = new Maingoal(params)
        mainGoal.save(flush: true)

        forward action: "showMainGoals"
    }

    def removeMainGoal() {
        Maingoal mainGoal = Maingoal.get(params.id)
        mainGoal.delete(flush: true)

        forward action: "showMainGoals"
    }

    def addSubGoal() {
        Maingoal mainGoal = Maingoal.get(params.id)

        Subgoal subGoal = new Subgoal(params)
        mainGoal.addToSubGoals(subGoal)

        render template: "subgoals", model: [maingoal: mainGoal, i: params.i]
    }

    def removeSubGoal() {
        println params
        Maingoal mainGoal = Maingoal.get(params.id)
        Subgoal subGoal = Subgoal.get(params.long('subgoal'))

        mainGoal.removeFromSubGoals(subGoal)
        subGoal.delete(flush: true)

        render template: "subgoals", model: [maingoal: mainGoal, i: params.i]
    }

    def showMainGoals() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        render template: "maingoals", model: [goalInstanceList: Maingoal.list(params), goalInstanceTotal: Maingoal.count()]
    }

    def editMainGoal() {
        Maingoal mainGoal = Maingoal.get(params.id)

        render template: "editmaingoal", model: [maingoal: mainGoal, i: params.i]
    }

    def updateMainGoal() {
        Maingoal mainGoal = Maingoal.get(params.id)
        mainGoal.properties = params
        mainGoal.save(flush: true)

        render template: "showmaingoal", model: [maingoal: mainGoal, i: params.i]
    }

    def updateElement() {
        def element
        if (params.type == "maingoal") {
            element = Maingoal.get(params.id)
        }
        else if (params.type == "subgoal")
            element = Subgoal.get(params.id)
        else if (params.type == "result")
            element = Result.get(params.id)

        element.properties = params
        element.save()

        redirect action: "show_new", id: params.masterId
    }

    def addResult() {
        Subgoal subgoal = Subgoal.get(params.id)

        subgoal.addToResults(description: "Neues Resultat")

        redirect action: "show_new", id: subgoal.id
    }
}
