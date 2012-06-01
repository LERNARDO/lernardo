package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService

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
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etOperator = metaDataService.etOperator
    def operators = Entity.createCriteria().list {
      eq("type", etOperator)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalOperators = Entity.countByType(etOperator)

    return [operators: operators, totalOperators: totalOperators]
  }

  def show = {
    Entity operator = Entity.get(params.id)

    if (!operator) {
      flash.message = message(code: "object.notFound", args: [message(code: "operator")])
      redirect(action: list)
      return
    }

    def allFacilities = Entity.findAllByType(metaDataService.etFacility)
    // find all facilities of this operator
    List facilities = functionService.findAllByLink(null, operator, metaDataService.ltOperation)

    return [operator: operator, facilities: facilities, allFacilities: allFacilities]

  }

  def delete = {
    Entity operator = Entity.get(params.id)
    if (operator) {
      functionService.deleteReferences(operator)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "operator"), operator.profile.fullName])
        operator.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "operator"), operator.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "operator")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity operator = Entity.get(params.id)

    if (!operator) {
      flash.message = message(code: "object.notFound", args: [message(code: "operator")])
      redirect action: 'list'
      return
    }

    return [operator: operator]

  }

  def update = {
    Entity operator = Entity.get(params.id)

    operator.profile.properties = params
    operator.user.properties = params

    //if (operator.id == entityHelperService.loggedIn.id)
    //  RequestContextUtils.getLocaleResolver(request).setLocale(request, response, operator.user.locale)

    if (operator.profile.save() && operator.user.save() && operator.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "operator"), operator.profile.fullName])
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
        ent.profile.save()
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "object.created", args: [message(code: "operator"), entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [operator: ee.entity]
    }

  }

  def addFacility = {
    def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltOperation)
    if (linking.duplicate)
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+ '</p>'
    render template: 'facilities', model: [facilities: linking.sources, operator: linking.target]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltOperation)
    render template: 'facilities', model: [facilities: breaking.sources, operator: breaking.target]
  }
}
