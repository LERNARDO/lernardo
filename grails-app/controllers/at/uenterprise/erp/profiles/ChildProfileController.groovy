package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.Msg
import at.uenterprise.erp.Publication
import java.util.regex.Pattern
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Evaluation
import at.uenterprise.erp.Event

//import java.util.regex.Pattern

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
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
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
    if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd. MM. yy", params.birthDate)
    else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd.MM.yy", params.birthDate)
    else
      params.birthDate = null

    Entity child = Entity.get(params.id)

    child.profile.properties = params
    // child.profile.birthDate = functionService.convertToUTC(child.profile.birthDate)
    child.profile.fullName = params.lastName + " " + params.firstName
    child.user.properties = params

    if (child.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, child.user.locale)

    if (child.profile.save() && child.user.save() && child.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "child"), child.profile.fullName])
      redirect action: 'show', id: child.id, params: [entity: child.id]
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
        if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd. MM. yy", params.birthDate)
        else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd.MM.yy", params.birthDate)
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.birthDate = functionService.convertToUTC(ent.profile.birthDate)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "object.created", args: [message(code: "child"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [child: ee.entity])
    }

  }

}
