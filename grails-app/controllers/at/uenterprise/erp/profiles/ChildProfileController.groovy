package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.LinkDataService

class ChildProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  FunctionService functionService
  LinkDataService linkDataService
  def securityManager

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: "list", params: params
  }

  def list = {
    int totalChildren = Entity.countByType(metaDataService.etChild)
    List families = Entity.findAllByType(metaDataService.etGroupFamily)

    return [totalChildren: totalChildren,
            families: families,
            facilities: Entity.findAllByType(metaDataService.etFacility)]
  }

  def show = {
    Entity child = Entity.get(params.id)

    if (!child) {
      flash.message = message(code: "object.notFound", args: [message(code: "child")])
      redirect(action: list)
      return
    }

    Entity family = linkDataService.getFamily(child)

    return [child: child, family: family, ajax: params.ajax, ajaxId: params.ajaxId]
  }

  def delete = {
    Entity child = Entity.get(params.id)

    if (child) {
      functionService.deleteReferences(child)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "child"), child.profile])
        child.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "child"), child.profile])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "child")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity child = Entity.get(params.id)

    if (!child) {
      flash.message = message(code: "object.notFound", args: [message(code: "child")])
      redirect action: 'list'
      return
    }

    return [child: child]
  }

  def update = {
    params.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
    
    Entity child = Entity.get(params.id)

    child.profile.properties = params
    child.profile.fullName = params.lastName + " " + params.firstName
    child.user.properties = params

    if (child.profile.save() && child.user.save() && child.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "child"), child.profile])
      redirect action: 'show', id: child.id
    }
    else {
      render view: 'edit', model: [child: child]
    }
  }

  def create = {}

  def save = {
    EntityType etChild = metaDataService.etChild

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etChild, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.profile.birthDate = params.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.birthDate = functionService.convertToUTC(ent.profile.birthDate)
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
      }

      flash.message = message(code: "object.created", args: [message(code: "child"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [child: ee.entity]
    }

  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().listDistinct  {
      eq('type', metaDataService.etChild)
      user {
        eq('enabled', params.active ? true : false)
      }
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        order(params.sort, params.order)
      }
    }

    // 2. pass - filter by family
    if (params.family != "") {
      results = results.findAll { Entity entity ->
        Link.createCriteria().get {
          eq('source', entity)
          eq('target', Entity.get(params.family))
          eq('type', metaDataService.ltGroupMemberChild)
        }
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'child', params: params]
  }

}
