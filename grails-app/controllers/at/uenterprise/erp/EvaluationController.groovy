package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class EvaluationController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  // shows all evaluations of a given client
  def list = {
    params.max = Math.min(params.max ? params.int('max') : 5, 100)
    params.offset = params.offset ?: 0
    Entity entity = Entity.get(params.id)
    List evaluations = Evaluation.findAllByOwner(entity, params)

    return [evaluationInstanceList: evaluations,
            evaluationInstanceTotal: Evaluation.countByOwner(entity),
            entity: entity]
  }

  def listall = {
    params.max = Math.min(params.max ? params.int('max') : 5, 100)
    params.offset = params.offset ?: 0
    List evaluations = Evaluation.list(params)
    Entity entity = Entity.get(params.id)
    return [evaluations: evaluations, totalEvaluations: Evaluation.count(), entity: entity]
  }

  // shows all evaluations made by a given educator
  def myevaluations = {
    params.max = Math.min(params.max ? params.int('max') : 5, 100)
    params.offset = params.offset ?: 0
    Entity entity = Entity.get(params.id)
    List evaluations = Evaluation.findAllByWriter(entity, params)

    return [evaluationInstanceList: evaluations,
            evaluationInstanceTotal: Evaluation.countByWriter(entity),
            entity: entity]
  }

  def showall = {
    params.max = 5
    params.offset = params.offset ? params.int('offset'): 0
    List evaluations = Evaluation.list(params)
    Entity entity = Entity.get(params.id)
    render template: "evaluations", model:[evaluations: evaluations, totalEvaluations: Evaluation.count(), entity: entity]
  }

  def showByEducator = {
    println params
    params.max = 5
    params.offset = params.offset ? params.int('offset'): 0
    Entity entity = Entity.get(params.id)

    if (!params.value) {
      render ""
      return
    }

    // find matching educators
    def c = Entity.createCriteria()
    def educators = c.list {
      eq('type', metaDataService.etEducator)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
    }

    List evaluations = Evaluation.list().findAll {educators.contains(it.writer)}

    def totalEvaluations = evaluations.size()
    def upperBound = params.offset + 5 < totalEvaluations ? params.offset + 5 : totalEvaluations
    evaluations = evaluations.subList(params.offset, upperBound)

    render template: "eevaluations", model:[evaluations: evaluations, totalEvaluations: totalEvaluations, entity: entity, value: params.value]
  }

  def showByClient = {
    params.max = 5
    params.offset = params.offset ? params.int('offset'): 0
    Entity entity = Entity.get(params.id)

    if (!params.value) {
      render ""
      return
    }

    // find matching clients
    def c = Entity.createCriteria()
    def educators = c.list {
      eq('type', metaDataService.etClient)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
    }

    List evaluations = Evaluation.list().findAll {educators.contains(it.owner)}

    def totalEvaluations = evaluations.size()
    def upperBound = params.offset + 5 < totalEvaluations ? params.offset + 5 : totalEvaluations
    evaluations = evaluations.subList(params.offset, upperBound)

    render template: "cevaluations", model:[evaluations: evaluations, totalEvaluations: totalEvaluations, entity: entity, value: params.value]
  }

  // show all evaluations of clients linked to a given educator
  def interestingevaluations = {
    Entity entity = Entity.get(params.id)

    // first get all facilities the educator is linked with
    List facilities = functionService.findAllByLink(entity, null, metaDataService.ltWorking)

    // for each facility get the clients in that facility
    List clients = []
    facilities.each { facility ->
      clients.addAll(functionService.findAllByLink(null, facility as Entity, metaDataService.ltGroupMemberClient))
    }

    // get all evaluations for all clients
    List evaluations = []
    clients.each {
      evaluations.addAll(Evaluation.findAllByOwner(it))
    }

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

    Entity entity = evaluationInstance.owner

    if (evaluationInstance) {
      try {
        evaluationInstance.delete(flush: true)
        flash.message = message(code: "evaluation.deleted")
        redirect(action: "list", id: entity.id)
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
        redirect action: 'list', id:  evaluationInstance.owner.id
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
      redirect action: "list", id:  evaluationInstance.owner.id
    }
    else {
      render view: 'create', model: [evaluationInstance: evaluationInstance]
    }
  }
}
