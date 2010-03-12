package lernardo

import de.uenterprise.ep.Entity

class EvaluationController {
    def entityHelperService
    
    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        def entity = Entity.get(params.id)
        List evaluations = Evaluation.findAllByOwner(entity)

        return [evaluationInstanceList: evaluations,
                evaluationInstanceTotal: evaluations.size(),
                entity: entity]
    }

    def show = {
        def evaluationInstance = Evaluation.get( params.id )

        if(!evaluationInstance) {
            flash.message = "Evaluation not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [evaluationInstance: evaluationInstance]
        }
    }

    def del = {
        def evaluationInstance = Evaluation.get( params.id )
        if(evaluationInstance) {
            try {
                evaluationInstance.delete(flush:true)
                flash.message = message(code:"evaluation.deleted")
                redirect(action:"list", params:[name: params.name])
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Evaluation ${params.id} could not be deleted"
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "Evaluation not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def evaluationInstance = Evaluation.get(params.id)
        def entity = Entity.get(params.entity)

        if(!evaluationInstance) {
            flash.message = "Evaluation not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [evaluationInstance :evaluationInstance,
                    entity: entity]
        }
    }

    def update = {
        def evaluationInstance = Evaluation.get(params.id)
        if(evaluationInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(evaluationInstance.version > version) {
                    
                    evaluationInstance.errors.rejectValue("version", "evaluation.optimistic.locking.failure", "Another user has updated this Evaluation while you were editing.")

                    render view:'edit', model:[evaluationInstance:evaluationInstance]
                    return
                }
            }
            evaluationInstance.properties = params
            if(!evaluationInstance.hasErrors() && evaluationInstance.save()) {
                flash.message = message(code:"evaluation.updated")
                redirect action:'list', params:[name: params.name]
            }
            else {
                render view:'edit', model:[evaluationInstance:evaluationInstance]
            }
        }
        else {
            flash.message = "Evaluation not found with id ${params.id}"
            redirect action:'list'
        }
    }

    def create = {
        def evaluationInstance = new Evaluation()
        evaluationInstance.properties = params
        def entity = Entity.get(params.id)

        return [evaluationInstance: evaluationInstance,
                entity: entity]
    }

    def save = {
        def evaluationInstance = new Evaluation(params)
        evaluationInstance.owner = Entity.get(params.entity)
        evaluationInstance.writer = entityHelperService.loggedIn
        if(evaluationInstance.save(flush:true)) {
            flash.message = message(code:"evaluation.created")
            redirect action:"list", params:[name:params.name]
        }
        else {
            render view:'create', model:[evaluationInstance:evaluationInstance]
        }
    }
}
