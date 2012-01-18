package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService
import java.text.SimpleDateFormat
import java.util.regex.Pattern

class EvaluationController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: "list", params: params
  }

  // shows all evaluations of a given client
  def list = {
    params.max = Math.min(params.max ? params.int('max') : 5, 100)
    params.offset = params.offset ?: 0
    params.sort = params.sort ?: 'dateCreated'
    params.order = params.order ?: 'desc'
    Entity entity = Entity.get(params.id)
    List evaluations = Evaluation.findAllByOwner(entity, params)

    return [evaluationInstanceList: evaluations,
            evaluationInstanceTotal: Evaluation.countByOwner(entity),
            entity: entity]
  }

  def allevaluations = {
    params.max = Math.min(params.max ? params.int('max') : 5, 100)
    params.offset = params.offset ?: 0
    params.sort = params.sort ?: 'dateCreated'
    params.order = params.order ?: 'desc'
    def show = params.show ?: false
    List evaluations = Evaluation.list(params)
    Entity entity = Entity.get(params.id)
    return [evaluations: evaluations, totalEvaluations: Evaluation.count(), entity: entity, show: show]
  }

  // shows all evaluations made by a given educator
  def myevaluations = {
    params.max = Math.min(params.max ? params.int('max') : 5, 100)
    params.offset = params.offset ?: 0
    params.sort = params.sort ?: 'dateCreated'
    params.order = params.order ?: 'desc'
    Entity entity = Entity.get(params.id)
    List evaluations = Evaluation.findAllByWriter(entity, params)

    return [evaluationInstanceList: evaluations,
            evaluationInstanceTotal: Evaluation.countByWriter(entity),
            entity: entity]
  }

  def showMine = {
    Entity entity = Entity.get(params.id)
    params.max = params.int('max') ?: 10
    params.offset = params.int('offset') ?: 0

    List clients
    if (!params.value) {
      clients = Entity.findAllByType(metaDataService.etClient)
    }
    else {
      def c = Entity.createCriteria()
      clients = c.list {
        eq('type', metaDataService.etClient)
        or {
          ilike('name', "%" + params.value + "%")
          profile {
            ilike('fullName', "%" + params.value + "%")
          }
        }
      }
    }

    if (clients) {
      List evaluations = Evaluation.list().findAll {clients.contains(it.owner) && it.writer == entity}
      if (evaluations) {

        def totalEvaluations = evaluations.size()
        def upperBound = params.offset + params.max < totalEvaluations ? params.offset + params.max : totalEvaluations
        evaluations = evaluations.subList(params.offset, upperBound)

        render template: "evaluations", model:[evaluationInstanceList: evaluations, entity: entity, currentEntity: entityHelperService.loggedIn, value: params.value, paginate: 'own', totalEvaluations: totalEvaluations]
      }
      else
        render '<span class="italic">' + message(code: 'searchMe.empty') + '</span>'
    }
    else
      render '<span class="italic">' + message(code: 'searchMe.empty') + '</span>'
  }

  def showByClient = {
    params.max = params.int('max') ?: 10
    params.offset = params.int('offset') ?: 0
    Entity entity = Entity.get(params.id)

    if (!params.value) {
      render ""
      return
    }

    // find matching clients
    def c = Entity.createCriteria()
    def clients = c.list {
      eq('type', metaDataService.etClient)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
    }

    if (clients) {
      List evaluations = Evaluation.list().findAll {clients.contains(it.owner)}

      def totalEvaluations = evaluations.size()
      def upperBound = params.offset + params.max < totalEvaluations ? params.offset + params.max : totalEvaluations
      evaluations = evaluations.subList(params.offset, upperBound)

      render template: "evaluations", model:[evaluationInstanceList: evaluations,
                                             totalEvaluations: totalEvaluations,
                                             entity: entity,
                                             value: params.value,
                                             currentEntity: entityHelperService.loggedIn,
                                             paginate: 'allClient']
    }
    else
      render '<span class="italic">' + message(code: 'searchMe.empty') + '</span>'
  }

  def showByEducator = {
    params.max = params.int('max') ?: 10
    params.offset = params.int('offset') ?: 0
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

    if (educators) {
      List evaluations = Evaluation.list().findAll {educators.contains(it.writer)}

      def totalEvaluations = evaluations.size()
      def upperBound = params.offset + params.max < totalEvaluations ? params.offset + params.max : totalEvaluations
      evaluations = evaluations.subList(params.offset, upperBound)

      render template: "evaluations", model:[evaluationInstanceList: evaluations,
                                             totalEvaluations: totalEvaluations,
                                             entity: entity,
                                             value: params.value,
                                             currentEntity: entityHelperService.loggedIn,
                                             paginate: 'allEducator']
    }
    else
      render '<span class="italic">' + message(code: 'searchMe.empty') + '</span>'
  }
  
  // show all evaluations of clients and parents linked to a given educator
  def interestingevaluations = {
    params.max = params.int('max') ?: 10
    params.offset = params.int('offset') ?: 0
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

    def totalEvaluations = evaluations.size()
    def upperBound = params.offset + params.max < totalEvaluations ? params.offset + params.max : totalEvaluations
    evaluations = evaluations.subList(params.offset, upperBound)

    return [evaluationInstanceList: evaluations,
            totalEvaluations: totalEvaluations,
            entity: entity,
            paginate: 'interesting']

  }

  def show = {
    Evaluation evaluationInstance = Evaluation.get(params.id)
    Entity entity = Entity.get(params.entity)

    if (evaluationInstance) {
      [evaluation: evaluationInstance, entity: entity]
    }
    else {
      flash.message = message(code: "evaluation.idNotFound", args: [params.id])
      redirect action: list
    }

  }

  def delete = {
    Evaluation evaluationInstance = Evaluation.get(params.id)

    if (evaluationInstance) {
      try {
        evaluationInstance.delete(flush: true)
        flash.message = message(code: "evaluation.deleted")
        render ""
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "Evaluation ${params.id} could not be deleted"
      }
    }
    else {
      flash.message = message(code: "evaluation.idNotFound", args: [params.id])
    }
  }

  def edit = {
    Evaluation evaluationInstance = Evaluation.get(params.id)
    Entity entity = Entity.get(params.entity)

    if (!evaluationInstance) {
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
        redirect action: 'show', id: evaluationInstance.id, params: [entity: evaluationInstance.owner.id]
      }
      else {
        render view: 'edit', model: [evaluationInstance: evaluationInstance]
      }
    }
    else {
      flash.message = message(code: "evaluation.idNotFound", args: [params.id])
      redirect action: 'list'
    }
  }

  def create = {
    Evaluation evaluationInstance = new Evaluation()
    evaluationInstance.properties = params
    Entity entity = Entity.get(params.id)
    Entity target = Entity.get(params.target)

    return [evaluationInstance: evaluationInstance,
            entity: entity,
            target: target]
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
