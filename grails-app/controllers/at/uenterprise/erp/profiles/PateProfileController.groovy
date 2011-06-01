package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.Msg
import at.uenterprise.erp.Event
import at.uenterprise.erp.Publication
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Evaluation

class PateProfileController {
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

    def c = Entity.createCriteria()
    def pates = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etPate)
      profile {
        order(params.sort, params.order)
      }
    }

    return [pates: pates]
  }

  def show = {
    Entity pate = Entity.get(params.id)
    Entity entity = params.entity ? pate : entityHelperService.loggedIn

    if (!pate) {
      flash.message = "PateProfile not found with id ${params.id}"
      redirect(action: list)
      return
    }

    List godchildren = functionService.findAllByLink(null, pate, metaDataService.ltPate)

    return [pate: pate, entity: entity, allChildren: Entity.findAllByType(metaDataService.etClient), godchildren: godchildren]

  }

  def delete = {
    Entity pate = Entity.get(params.id)
    if (pate) {
      // delete all links to this entity
      Link.findAllByTargetAndType(pate, metaDataService.ltPate).each {it.delete()}
      Msg.findAllBySenderOrReceiver(pate, pate).each {it.delete()}
      Event.findAllByEntity(pate).each {it.delete()}
      Publication.findAllByEntity(pate).each {it.delete()}
      Evaluation.findByOwnerOrWriter(pate, pate).each {it.delete()}
      Comment.findAllByCreator(pate.id.toInteger()).each { Comment comment ->
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
        flash.message = message(code: "pate.deleted", args: [pate.profile.fullName])
        pate.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "pate.notDeleted", args: [pate.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "PateProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity pate = Entity.get(params.id)

    if (!pate) {
      flash.message = "PateProfile not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    return [pate: pate, clients: Entity.findAllByType(metaDataService.etClient)]
    
  }

  def update = {
    Entity pate = Entity.get(params.id)

    pate.profile.properties = params
    pate.profile.fullName = params.lastName + " " + params.firstName
    if (!pate.profile.calendar) pate.profile.calendar = new ECalendar().save()

    pate.user.properties = params
    if (pate.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, pate.user.locale)

    if (pate.profile.save() && pate.user.save() && pate.save()) {

      flash.message = message(code: "pate.updated", args: [pate.profile.fullName])
      redirect action: 'show', id: pate.id
    }
    else {
      render view: 'edit', model: [pate: pate]
    }
  }

  def create = {
    return [clients: Entity.findAllByType(metaDataService.etClient)]
  }

  def save = {
    EntityType etPate = metaDataService.etPate

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etPate, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.calendar = new ECalendar().save()
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "pate.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [pate: ee.entity, clients: Entity.findAllByType(metaDataService.etClient)])
    }

  }

  def addGodchildren = {
    def linking = functionService.linkEntities(params.child, params.id, metaDataService.ltPate)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template:'godchildren', model: [godchildren: linking.results, pate: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeGodchildren = {
    def breaking = functionService.breakEntities(params.child, params.id, metaDataService.ltPate)
    render template:'godchildren', model: [godchildren: breaking.results, pate: breaking.target, entity: entityHelperService.loggedIn]
  }

  /*
   * retrieves all clients matching the search parameter
   */
  def remoteClients = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etClient)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'clientresults', model: [results: results, pate: params.id])
    }
  }
}
