package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType
import at.uenterprise.erp.base.Link

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
    int totalOperators = Entity.countByType(metaDataService.etOperator)

    return [totalOperators: totalOperators]
  }

  def show = {
    Entity operator = Entity.get(params.id)

    if (!operator) {
      flash.message = message(code: "object.notFound", args: [message(code: "operator")])
      redirect(action: list)
      return
    }

    return [operator: operator]

  }

  def management = {
      Entity operator = Entity.get(params.id)

      def allFacilities = Entity.findAllByType(metaDataService.etFacility)
      // find all facilities of this operator
      List facilities = functionService.findAllByLink(null, operator, metaDataService.ltOperation)

      render template: "management", model: [operator: operator, facilities: facilities, allFacilities: allFacilities]
  }

  def delete = {
    Entity operator = Entity.get(params.id)
    if (operator) {
      functionService.deleteReferences(operator)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "operator"), operator.profile])
        operator.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "operator"), operator.profile])
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

    if (operator.profile.save() && operator.user.save() && operator.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "operator"), operator.profile])
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
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
      }

      flash.message = message(code: "object.created", args: [message(code: "operator"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [operator: ee.entity]
    }

  }

  def addFacility = {
    def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltOperation)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
    render template: 'facilities', model: [facilities: linking.sources, operator: linking.target]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltOperation)
    render template: 'facilities', model: [facilities: breaking.sources, operator: breaking.target]
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().listDistinct  {
      eq('type', metaDataService.etOperator)
      user {
        eq('enabled', params.active ? true : false)
      }
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        order(params.sort, params.order)
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'operator', params: params]
  }
}
