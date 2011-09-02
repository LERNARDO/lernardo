package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService
import java.text.SimpleDateFormat
import java.util.regex.Pattern

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
    render template: "evaluations", model:[evaluations: evaluations, totalEvaluations: Evaluation.count(), entity: entity, currentEntity: entityHelperService.loggedIn]
  }

  def showByEducator = {
    params.max = 5
    params.offset = params.offset ? params.int('offset') : 0
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

    render template: "eevaluations", model:[evaluations: evaluations, totalEvaluations: totalEvaluations, entity: entity, value: params.value, currentEntity: entityHelperService.loggedIn]
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

    render template: "cevaluations", model:[evaluations: evaluations, totalEvaluations: totalEvaluations, entity: entity, value: params.value, currentEntity: entityHelperService.loggedIn]
  }

  // show all evaluations of clients and parents linked to a given educator
  def interestingevaluations = {
    Entity entity = Entity.get(params.id)

    // first get all facilities the educator is linked with
    List facilities = functionService.findAllByLink(entity, null, metaDataService.ltWorking)
    facilities.addAll(functionService.findAllByLink(entity, null, metaDataService.ltLeadEducator))

    // for each facility get the clients in that facility
    List clients = []
    facilities.each { Entity facility ->
      clients.addAll(functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient))
    }

    // get all evaluations for all clients
    List evaluations = []
    clients.each { Entity client ->
      evaluations.addAll(Evaluation.findAllByOwner(client))
    }

    // for each client get the parents
    List parents = []
    clients.each { Entity client ->
      // find family of client
      Entity groupFamily = functionService.findByLink(client, null, metaDataService.ltGroupFamily)
      // find parents of groupFamily
      List localParents = []
      if (groupFamily)
        functionService.findAllByLink(null, groupFamily, metaDataService.ltGroupMemberParent)
      // add each one to the list if not already in there
      localParents.each {
        if (!parents.contains(it))
          parents.add(it)
      }
    }

    // get all evaluations for all parents
    parents.each { Entity parent ->
      evaluations.addAll(Evaluation.findAllByOwner(parent))
    }

    return [evaluationInstanceList: evaluations,
            evaluationInstanceTotal: evaluations.size(),
            entity: entity]

  }

  def show = {
    Evaluation evaluationInstance = Evaluation.get(params.id)

    if (evaluationInstance) {
      [evaluationInstance: evaluationInstance]
    }
    else {
      flash.message = message(code: "evaluation.idNotFound", args: [params.id])
      redirect action: list
    }

  }

  def del = {
    Evaluation evaluationInstance = Evaluation.get(params.id)

    Entity entity = evaluationInstance.owner

    if (evaluationInstance) {
      try {
        evaluationInstance.delete(flush: true)
        flash.message = message(code: "evaluation.deleted")
        redirect action: "list", id: entity.id
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "Evaluation ${params.id} could not be deleted"
        redirect action: "show", id: params.id
      }
    }
    else {
      //flash.message = "Evaluation not found with id ${params.id}"
      flash.message = message(code: "evaluation.idNotFound", args: [params.id])
      redirect action: "list"
    }
  }

  def edit = {
    Evaluation evaluationInstance = Evaluation.get(params.id)
    Entity entity = Entity.get(params.entity)

    if (!evaluationInstance) {
      //flash.message = "Evaluation not found with id ${params.id}"
      flash.message = message(code: "evaluation.idNotFound", args: [params.id])
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
      Entity linkedEntity = Entity.get(params.int('linkedentity'))
      if (linkedEntity)
        evaluationInstance.linkedTo = linkedEntity
      if (!evaluationInstance.hasErrors() && evaluationInstance.save()) {
        flash.message = message(code: "evaluation.updated")
        redirect action: 'list', id:  evaluationInstance.owner.id
      }
      else {
        render view: 'edit', model: [evaluationInstance: evaluationInstance]
      }
    }
    else {
      //flash.message = "Evaluation not found with id ${params.id}"
      flash.message = message(code: "evaluation.idNotFound", args: [params.id])
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
    Entity linkedEntity = Entity.get(params.int('linkedentity'))
    if (linkedEntity)
      evaluationInstance.linkedTo = linkedEntity
    if (evaluationInstance.save(flush: true)) {
      flash.message = message(code: "evaluation.created")
      redirect action: "list", id:  evaluationInstance.owner.id
    }
    else {
      render view: 'create', model: [evaluationInstance: evaluationInstance, entity: Entity.get(params.entity)]
    }
  }

   /*
   * retrieves users matching the search parameter of the instant search
   */
  def searchMe = {
    Date searchDate = new Date()
    if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.myDate))
        searchDate = Date.parse("dd. MM. yy", params.myDate)

    def c = Entity.createCriteria()
    List entities = c.list {
      or {
          eq("type", metaDataService.etGroupActivity)
          eq("type", metaDataService.etProjectUnit)
        }
    }

    SimpleDateFormat sdf = new SimpleDateFormat("d M yyyy", new Locale("en"))

    List results = []
    results.addAll(entities?.findAll { entity ->
      sdf.format(entity.profile.date) == sdf.format(searchDate)
    })

    if (results.size() == 0) {
      render '<span class="italic">' + message(code: "searchMe.empty") + '</span>'
      return
    }
    else {
      render(template: 'searchresults', model: [results: results])
    }
  }

  def addResult = {
    Entity entity = Entity.get(params.id)

    // def msg = "Auswahl:"
    def msg = message(code: "selection")
    render ('<b>' + msg + '</b> <a href="' + createLink(controller: entity.type.supertype.name +'Profile', action:'show', id: entity.id) + '">' + entity.profile.fullName + '</a>')
  }

  def removeLinkedTo = {
    Evaluation evaluation = Evaluation.get(params.id)
    evaluation.linkedTo = null
    evaluation.save()
    render '<span class="italic">'+message(code: "links.notLinked")+'</span>'
  }
}
