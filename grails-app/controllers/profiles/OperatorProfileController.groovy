package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import standard.FunctionService
import standard.MetaDataService
import lernardo.Msg
import lernardo.Event
import lernardo.Publication

class OperatorProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def operators = c.list {
      eq("type", metaDataService.etOperator)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [operatorList: operators,
            operatorTotal: Entity.countByType(metaDataService.etOperator)]
  }

  def show = {
    Entity operator = Entity.get(params.id)
    Entity entity = params.entity ? operator : entityHelperService.loggedIn

    if (!operator) {
      flash.message = "OperatorProfile not found with id ${params.id}"
      redirect(action: list)
      return
    }

    def allFacilities = Entity.findAllByType(metaDataService.etFacility)
    // find all facilities of this operator
    List facilities = functionService.findAllByLink(null, entity, metaDataService.ltOperation)

    return [operator: operator, entity: entity, facilities: facilities, allFacilities: allFacilities]

  }

  def del = {
    Entity operator = Entity.get(params.id)
    if (operator) {
      // delete all links
      Link.findAllBySourceOrTarget(operator, operator).each {it.delete()}
      Msg.findAllByEntity(operator).each {it.delete()}
      Event.findAllByEntity(operator).each {it.delete()}
      Publication.findAllByEntity(operator).each {it.delete()}
      try {
        flash.message = message(code: "operator.deleted", args: [operator.profile.fullName])
        operator.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "operator.notDeleted", args: [operator.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "OperatorProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity operator = Entity.get(params.id)

    if (!operator) {
      flash.message = "OperatorProfile not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    return [operator: operator]

  }

  def update = {
    Entity operator = Entity.get(params.id)

    operator.profile.properties = params
    operator.user.properties = params
    if (operator.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, operator.user.locale)

    if (!operator.hasErrors() && operator.save()) {
      flash.message = message(code: "operator.updated", args: [operator.profile.fullName])
      redirect action: 'show', id: operator.id
    }
    else {
      render view: 'edit', model: [operator: operator]
    }
  }

  def create = {}

  def save = {
    EntityType etOperator = metaDataService.etOperator

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etOperator, params.email, params.fullName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "operator.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [operator: ee.entity])
      return
    }

  }

  def addFacility = {
    def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltOperation)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'facilities', model: [facilities: linking.results, operator: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltOperation)
    render template: 'facilities', model: [facilities: breaking.results, operator: breaking.target, entity: entityHelperService.loggedIn]
  }
}
