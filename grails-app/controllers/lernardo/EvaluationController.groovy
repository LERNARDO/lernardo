package lernardo

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class EvaluationController {
  EntityHelperService entityHelperService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    Entity entity = Entity.get(params.id)
    List evaluations = Evaluation.findAllByOwner(entity)

    return [evaluationInstanceList: evaluations,
            evaluationInstanceTotal: evaluations.size(),
            entity: entity]
  }

  def show = {
    Evaluation evaluationInstance = Evaluation.get(params.id)

    if (!evaluationInstance) {
      flash.message = "Evaluation not found with id ${params.id}"
      redirect(action: list)
      return
    }

    return [evaluationInstance: evaluationInstance]

  }

  def del = {
    Evaluation evaluationInstance = Evaluation.get(params.id)
    if (evaluationInstance) {
      try {
        evaluationInstance.delete(flush: true)
        flash.message = message(code: "evaluation.deleted")
        redirect(action: "list", params: [name: params.name])
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "Evaluation ${params.id} could not be deleted"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "Evaluation not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Evaluation evaluationInstance = Evaluation.get(params.id)
    Entity entity = Entity.get(params.entity)

    if (!evaluationInstance) {
      flash.message = "Evaluation not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    return [evaluationInstance: evaluationInstance, entity: entity]

  }

  def update = {
    Evaluation evaluationInstance = Evaluation.get(params.id)
    if (evaluationInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (evaluationInstance.version > version) {

          evaluationInstance.errors.rejectValue("version", "evaluation.optimistic.locking.failure", "Another user has updated this Evaluation while you were editing.")

          render view: 'edit', model: [evaluationInstance: evaluationInstance]
          return
        }
      }
      evaluationInstance.properties = params
      if (!evaluationInstance.hasErrors() && evaluationInstance.save()) {
        flash.message = message(code: "evaluation.updated")
        redirect action: 'list', params: [name: params.name]
      }
      else {
        render view: 'edit', model: [evaluationInstance: evaluationInstance]
      }
    }
    else {
      flash.message = "Evaluation not found with id ${params.id}"
      redirect action: 'list'
    }
  }

  def create = {
    Evaluation evaluationInstance = new Evaluation()
    evaluationInstance.properties = params
    Entity entity = Entity.get(params.id)

    return [evaluationInstance: evaluationInstance,
            entity: entity]
  }

  def save = {
    Evaluation evaluationInstance = new Evaluation(params)
    evaluationInstance.owner = Entity.get(params.entity)
    evaluationInstance.writer = entityHelperService.loggedIn
    if (evaluationInstance.save(flush: true)) {
      flash.message = message(code: "evaluation.created")
      redirect action: "list", params: [name: params.name]
    }
    else {
      render view: 'create', model: [evaluationInstance: evaluationInstance]
    }
  }
}
