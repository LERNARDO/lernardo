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

class ParentProfileController {
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

    EntityType etParent = metaDataService.etParent
    def parents = Entity.createCriteria().list {
      eq("type", etParent)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalParents = Entity.countByType(etParent)

    return [parents: parents, totalParents: totalParents]
  }

  def show = {
    Entity parent = Entity.get(params.id)
    Entity entity = params.entity ? parent : entityHelperService.loggedIn

    if (!parent) {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect(action: list)
      return
    }

    // find family of the parent if there is one
    Entity family = functionService.findByLink(parent, null, metaDataService.ltGroupMemberParent)

    return [parent: parent, entity: entity, family: family]

  }

  def delete = {
    Entity parent = Entity.get(params.id)
    if (parent) {
      // delete all links
      Link.findAllBySourceOrTarget(parent, parent).each {it.delete()}
      Msg.findAllBySenderOrReceiver(parent, parent).each {it.delete()}
      Publication.findAllByEntity(parent).each {it.delete()}
      Evaluation.findByOwnerOrWriter(parent, parent).each {it.delete()}
      Comment.findAllByCreator(parent.id.toInteger()).each { Comment comment ->
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
        flash.message = message(code: "object.deleted", args: [message(code: "parent"), parent.profile.fullName])
        parent.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "parent"), parent.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity parent = Entity.get(params.id)

    if (!parent) {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect action: 'list'
      return
    }

    return [parent: parent]

  }

  def update = {
    if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd. MM. yy", params.birthDate)
    else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd.MM.yy", params.birthDate)
    else
      params.birthDate = null

    Entity parent = Entity.get(params.id)

    parent.profile.properties = params
    // parent.profile.birthDate = functionService.convertToUTC(parent.profile.birthDate)
    parent.profile.fullName = params.lastName + " " + params.firstName
    if (!parent.profile.calendar) parent.profile.calendar = new ECalendar().save()

    parent.user.properties = params

    if (parent.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, parent.user.locale)

    // TODO: find out how to properly handle this cascading validation stuff
    // "parent.hasErrors()" returns false even though properties in the nested class "profile" did not validate
    
    // when validating a parent object it should check validation of nested objects as well because right now nested
    // properties that failed validation are not saved and the "show" view is called as if everything worked fine

    //if (!parent.hasErrors() && parent.save() && !parent.profile.hasErrors()) {
    //println "parent object has errors? " + parent.hasErrors()
    //println parent.errors.each {println it}
    //println "child object has errors? " + parent.profile.hasErrors()
    //println parent.profile.errors.each {println it}

    if (parent.profile.save() && parent.user.save() && parent.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "parent"), parent.profile.fullName])
      redirect action: 'show', id: parent.id, params: [entity: parent.id]
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
        else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd.MM.yy", params.birthDate)
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.calendar = new ECalendar().save()
        //ent.profile.birthDate = functionService.convertToUTC(ent.profile.birthDate)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "object.created", args: [message(code: "parent"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [parent: ee.entity])
    }

  }
}
