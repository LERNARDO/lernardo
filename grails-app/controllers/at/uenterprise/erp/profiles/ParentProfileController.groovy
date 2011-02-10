package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.Msg
import at.uenterprise.erp.Event
import at.uenterprise.erp.Publication
import java.util.regex.Pattern

class ParentProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService

  /*def beforeInterceptor = [
          action:{params.birthDate = params.birthDate ? Date.parse("dd. MM. yy", params.birthDate) : null}, only:['save','update']
  ]*/
  
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
    def parents = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etParent)
      profile {
        order(params.sort, params.order)
      }
    }

    return [parents: parents]
  }

  def show = {
    Entity parent = Entity.get(params.id)
    Entity entity = params.entity ? parent : entityHelperService.loggedIn

    if (!parent) {
      flash.message = "ParentProfile not found with id ${params.id}"
      redirect(action: list)
      return
    }

    // find family of the parent if there is one
    Entity family = functionService.findByLink(parent, null, metaDataService.ltGroupMemberParent)

    return [parent: parent, entity: entity, family: family]

  }

  def del = {
    Entity parent = Entity.get(params.id)
    if (parent) {
      // delete all links
      Link.findAllBySourceOrTarget(parent, parent).each {it.delete()}
      Msg.findAllByEntity(parent).each {it.delete()}
      Event.findAllByEntity(parent).each {it.delete()}
      Publication.findAllByEntity(parent).each {it.delete()}
      try {
        flash.message = message(code: "parent.deleted", args: [parent.profile.fullName])
        parent.delete(flush: true)
        redirect(action: "list")
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
      return
    }

    return [parent: parent]

  }

  def update = {
    Entity parent = Entity.get(params.id)

    parent.profile.properties = params
    parent.profile.fullName = params.lastName + " " + params.firstName
    parent.user.properties = params

    if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
      parent.profile.birthDate = Date.parse("dd. MM. yy", params.birthDate)
    else
      parent.profile.birthDate = null

    if (parent.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, parent.user.locale)

    // TODO
    // "parent.hasErrors()" returns false even though properties in the nested class "profile" did not validate
    
    // when validating a parent object it should check validation of nested objects as well because right now nested
    // properties that failed validation are not saved and the "show" view is called as if everything worked fine

    if (!parent.hasErrors() && parent.save()) {
      flash.message = message(code: "parent.updated", args: [parent.profile.fullName])
      redirect action: 'show', id: parent.id
    }
    else {
      render view: 'edit', model: [parent: parent]
    }
  }

  def create = {}

  def save = {
    EntityType etParent = metaDataService.etParent

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etParent, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd. MM. yy", params.birthDate)
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "parent.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [parent: ee.entity])
    }

  }
}
