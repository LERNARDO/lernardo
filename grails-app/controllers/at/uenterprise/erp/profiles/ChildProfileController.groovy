package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService

class ChildProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  FunctionService functionService
  def securityManager

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: "list", params: params
  }

  def list = {
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etChild = metaDataService.etChild
    def children = Entity.createCriteria().list {
      eq("type", etChild)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalChildren = Entity.countByType(etChild)

    return [children: children, totalChildren: totalChildren]
  }

  def show = {
    Entity child = Entity.get(params.id)

    if (!child) {
      flash.message = message(code: "object.notFound", args: [message(code: "child")])
      redirect(action: list)
      return
    }

    // check if the child belongs to a family
    Entity family = functionService.findByLink(child, null, metaDataService.ltGroupMemberChild)

    return [child: child, family: family]
  }

  def delete = {
    Entity child = Entity.get(params.id)

    if (child) {
      functionService.deleteReferences(child)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "child"), child.profile.fullName])
        child.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "child"), child.profile.fullName])
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
      flash.message = message(code: "object.updated", args: [message(code: "child"), child.profile.fullName])
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
        ent.profile.save()
      }

      flash.message = message(code: "object.created", args: [message(code: "child"), entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [child: ee.entity]
    }

  }

}
