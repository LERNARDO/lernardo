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
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Evaluation

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

    def c = Entity.createCriteria()
    def children = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etChild)
      profile {
        order(params.sort, params.order)
      }
    }

    return [children: children]
  }

  def show = {
    Entity child = Entity.get(params.id)
    Entity entity = params.entity ? child : entityHelperService.loggedIn

    if (!child) {
      //flash.message = "ChildProfile not found with id ${params.id}"
      flash.message = message(code: "child.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    // check if the child belongs to a family
    Entity family = functionService.findByLink(child, null, metaDataService.ltGroupMemberChild)

    return [child: child, family: family, entity: entity]

  }

  def delete = {
    Entity child = Entity.get(params.id)
    if (child) {
      // delete all links to and from this child
      Link.findAllBySourceOrTarget(child, child).each {it.delete()}
      Msg.findAllBySenderOrReceiver(child, child).each {it.delete()}
      Event.findAllByEntity(child).each {it.delete()}
      Publication.findAllByEntity(child).each {it.delete()}
      Evaluation.findByOwnerOrWriter(child, child).each {it.delete()}
      Comment.findAllByCreator(child.id.toInteger()).each { Comment comment ->
          // find the profile the comment belongs to and delete it from there
          def c = Entity.createCriteria()
          List entities = c.list {
              or {
                eq("type", metaDataService.etActivity)
                eq("type", metaDataService.etGroupActivity)
                eq("type", metaDataService.etGroupActivityTemplate)
                eq("type", metaDataService.etProject)
                eq("type", metaDataService.etProjectTemplate)
                eq("type", metaDataService.etTemplate)
              }
          }
          entities.each { Entity entity ->
              Comment profileComment = entity?.profile?.comments?.find {it.id == comment.id} as Comment
              if (profileComment)
                entity.profile.removeFromComments(profileComment)
          }
      }
      try {
        flash.message = message(code: "child.deleted", args: [child.profile.fullName])
        child.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "child.notDeleted", args: [child.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      // flash.message = "ChildProfile not found with id ${params.id}"
      flash.message = message(code: "child.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity child = Entity.get(params.id)

    if (!child) {
      // flash.message = "ChildProfile not found with id ${params.id}"
      flash.message = message(code: "child.idNotFound", args: [params.id])
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
    if (!child.profile.calendar) child.profile.calendar = new ECalendar().save()

    child.user.properties = params

    if (child.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, child.user.locale)

    if (child.profile.save() && child.user.save() && child.save()) {
      flash.message = message(code: "child.updated", args: [child.profile.fullName])
      redirect action: 'show', id: child.id
    }
    else {
      render view: 'edit', model: [child: child]
    }
  }

  def create = {}

  def save = {
    println params
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
        ent.profile.calendar = new ECalendar().save()
        ent.profile.birthDate = functionService.convertToUTC(ent.profile.birthDate)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "child.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [child: ee.entity])
    }

  }

}
