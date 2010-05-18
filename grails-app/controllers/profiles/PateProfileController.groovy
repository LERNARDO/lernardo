package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import de.uenterprise.ep.EntityHelperService
import org.grails.plugins.springsecurity.service.AuthenticateService
import standard.FunctionService
import standard.MetaDataService

class PateProfileController {
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
    return [pateList: Entity.findAllByType(metaDataService.etPate),
            pateTotal: Entity.countByType(metaDataService.etPate)]
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
    println params
    Entity pate = Entity.get(params.id)

    pate.profile.properties = params
    pate.user.properties = params
    RequestContextUtils.getLocaleResolver(request).setLocale(request, response, pate.user.locale)

    if (!pate.hasErrors() && pate.save()) {

/*      Link.findAllByTargetAndType(pate, metaDataService.ltPate).each {it.delete()}
      if (params.clients) {
        if(params.clients.class.isArray())
          params.clients.each {
            new Link(source: Entity.get(it), target: pate, type: metaDataService.ltPate).save()
          }
        else
          new Link(source: Entity.get(params.clients), target: pate, type: metaDataService.ltPate).save()
      }*/

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
        ent.user.password = authenticateService.encodePassword("pass")
      }
/*      if (params.clients) {
        if(params.clients.class.isArray())
          params.clients.each {
            new Link(source: Entity.get(it), target: entity, type: metaDataService.ltPate).save()
          }
        else
          new Link(source: Entity.get(params.clients), target: entity, type: metaDataService.ltPate).save()
      }*/
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "pate.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (de.uenterprise.ep.EntityException ee) {
      render(view: "create", model: [pate: ee.entity, entity: entityHelperService.loggedIn, clients: Entity.findAllByType(metaDataService.etClient)])
      return
    }

  }

    def addGodchildren = {
      Entity pate = Entity.get(params.id)

      // check if the child isn't already linked to the pate
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.child))
        eq('target', pate)
        eq('type', metaDataService.ltPate)
      }
      if (!link)
        new Link(source:Entity.get(params.child), target: pate, type:metaDataService.ltPate).save()

      // find all godchildren of this pate
      def links = Link.findAllByTargetAndType(pate, metaDataService.ltPate)
      List godchildren = links.collect {it.source}

      render template:'godchildren', model: [godchildren: godchildren, pate: pate, entity: entityHelperService.loggedIn]
    }

    def removeGodchildren = {
      Entity pate = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.child))
        eq('target', pate)
        eq('type', metaDataService.ltPate)
      }
      link.delete()

      // find all godchildren of this pate
      def links = Link.findAllByTargetAndType(pate, metaDataService.ltPate)
      List godchildren = links.collect {it.source}

      render template:'godchildren', model: [godchildren: godchildren, pate: pate, entity: entityHelperService.loggedIn]
    }
}
