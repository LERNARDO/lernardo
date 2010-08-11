package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import standard.FunctionService
import standard.MetaDataService
import at.openfactory.ep.security.DefaultSecurityManager
import lernardo.Msg
import lernardo.Event

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
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    return [pateList: Entity.findAllByType(metaDataService.etPate),
            pateTotal: Entity.countByType(metaDataService.etPate),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity pate = Entity.get(params.id)
    Entity entity = params.entity ? pate : entityHelperService.loggedIn

    if (!pate) {
      flash.message = "PateProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      List links = Link.findAllByTargetAndType(pate, metaDataService.ltPate)
      List godchildren = links.collect {it.source}

      return [pate: pate, entity: entity, allChildren: Entity.findAllByType(metaDataService.etClient), godchildren: godchildren]
    }
  }

  def del = {
    Entity pate = Entity.get(params.id)
    if (pate) {
      // delete all links to this entity
      Link.findAllByTargetAndType(pate, metaDataService.ltPate).each {it.delete()}
      Msg.findAllByEntity(pate).each {it.delete()}
      Event.findAllByEntity(pate).each {it.delete()} 
      try {
        flash.message = message(code: "pate.deleted", args: [pate.profile.fullName])
        pate.delete(flush: true)
        redirect(controller:"profile", action: "list")
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
    }
    else {
      return [pate: pate, entity: entityHelperService.loggedIn, clients: Entity.findAllByType(metaDataService.etClient)]
    }
  }

  def update = {
    Entity pate = Entity.get(params.id)

    pate.profile.properties = params
    pate.profile.fullName = params.lastName + " " + params.firstName

    pate.user.properties = params
    if (pate == entityHelperService.loggedIn)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, pate.user.locale)

    if (!pate.hasErrors() && pate.save()) {

      flash.message = message(code: "pate.updated", args: [pate.profile.fullName])
      redirect action: 'show', id: pate.id
    }
    else {
      render view: 'edit', model: [pate: pate, entity: entityHelperService.loggedIn]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn, clients: Entity.findAllByType(metaDataService.etClient)]
  }

  def save = {
    EntityType etPate = metaDataService.etPate

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etPate, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "pate.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [pate: ee.entity, entity: entityHelperService.loggedIn, clients: Entity.findAllByType(metaDataService.etClient)])
      return
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
}
