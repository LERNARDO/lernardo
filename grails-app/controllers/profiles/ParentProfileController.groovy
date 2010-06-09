package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import de.uenterprise.ep.EntityHelperService
import org.grails.plugins.springsecurity.service.AuthenticateService
import standard.MetaDataService
import standard.FunctionService

class ParentProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  AuthenticateService authenticateService
  FunctionService functionService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    return [parentList: Entity.findAllByType(metaDataService.etParent),
            parentTotal: Entity.countByType(metaDataService.etParent),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity parent = Entity.get(params.id)
    Entity entity = params.entity ? parent : entityHelperService.loggedIn

    if (!parent) {
      flash.message = "ParentProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      // check if the parent belongs to a family
      def link = Link.findBySourceAndType(parent, metaDataService.ltGroupMemberParent)
      Entity family = link?.target

      return [parent: parent, entity: entity, family: family]
    }
  }

  def del = {
    Entity parent = Entity.get(params.id)
    if (parent) {
      // delete all links
      Link.findAllBySourceOrTarget(parent, parent).each {it.delete()}
      try {
        flash.message = message(code: "parent.deleted", args: [parent.profile.fullName])
        parent.delete(flush: true)
        redirect(controller:"profile", action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "parent.notDeleted", args: [parent.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "ParentProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity parent = Entity.get(params.id)

    if (!parent) {
      flash.message = "ParentProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      return [parent: parent, entity: entityHelperService.loggedIn]
    }
  }

  def update = {
    Entity parent = Entity.get(params.id)

    parent.profile.properties = params
    parent.profile.fullName = params.lastName + " " + params.firstName

    parent.user.properties = params
    RequestContextUtils.getLocaleResolver(request).setLocale(request, response, parent.user.locale)

    if (!parent.hasErrors() && parent.save()) {
      flash.message = message(code: "parent.updated", args: [parent.profile.fullName])
      redirect action: 'show', id: parent.id
    }
    else {
      render view: 'edit', model: [parent: parent, entity: entityHelperService.loggedIn]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn]
  }

  def save = {
    EntityType etParent = metaDataService.etParent

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etParent, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = authenticateService.encodePassword("pass")
      }
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "parent.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (de.uenterprise.ep.EntityException ee) {
      render(view: "create", model: [parent: ee.entity, entity: entityHelperService.loggedIn])
      return
    }

  }
}
