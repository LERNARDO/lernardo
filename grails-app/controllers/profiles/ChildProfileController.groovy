package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import standard.FunctionService

class ChildProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  FunctionService functionService
  def securityManager

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    return [childList: Entity.findAllByType(metaDataService.etChild),
            childTotal: Entity.countByType(metaDataService.etChild),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity child = Entity.get(params.id)
    Entity entity = params.entity ? child : entityHelperService.loggedIn

    if (!child) {
      flash.message = "ChildProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      // check if the child belongs to a family
      def link = Link.findBySourceAndType(child, metaDataService.ltGroupMemberChild)
      Entity family = link?.target

      return [child: child, entity: entity, family: family]
    }
  }

  def del = {
    Entity child = Entity.get(params.id)
    if (child) {
      // delete all links to and from this child
      Link.findAllBySourceOrTarget(child, child).each {it.delete()}
      try {
        flash.message = message(code: "child.deleted", args: [child.profile.fullName])
        child.delete(flush: true)
        redirect(controller: "profile", action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "child.notDeleted", args: [child.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "ChildProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity child = Entity.get(params.id)

    if (!child) {
      flash.message = "ChildProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      return [child: child, entity: entityHelperService.loggedIn]
    }
  }

  def update = {
    Entity child = Entity.get(params.id)

    child.profile.properties = params
    child.profile.fullName = params.lastName + " " + params.firstName

    child.user.properties = params
    if (child == entityHelperService.loggedIn)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, child.user.locale)

    if (!child.hasErrors() && child.save()) {
      flash.message = message(code: "child.updated", args: [child.profile.fullName])
      redirect action: 'show', id: child.id
    }
    else {
      render view: 'edit', model: [child: child, entity: entityHelperService.loggedIn]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn]
  }

  def save = {
    EntityType etChild = metaDataService.etChild
    println params

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etChild, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "child.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [child: ee.entity, entity: entityHelperService.loggedIn])
      return
    }

  }
}
