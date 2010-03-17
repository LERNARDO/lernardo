package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils

class PateProfileController {
  def metaDataService
  def entityHelperService
  def authenticateService
  def functionService

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
    def pate = Entity.get(params.id)
    def entity = params.entity ? pate : entityHelperService.loggedIn

    if (!pate) {
      flash.message = "PateProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      return [pate: pate, entity: entity]
    }
  }

  def del = {
    def pate = Entity.get(params.id)
    if (pate) {
      // delete all links to this entity
      Link.findAllByTargetAndType(pate, metaDataService.ltPate).each {it.delete()}
      
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
    def pate = Entity.get(params.id)

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
    def pate = Entity.get(params.id)

    pate.profile.properties = params
    pate.user.properties = params

    pate.profile.showTips = params.showTips ?: false
    pate.user.enabled = params.enabled ?: false

    if (params.lang == '1') {
      pate.user.locale = new Locale ("de", "DE")
      Locale locale = pate.user.locale
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
    }
    if (params.lang == '2') {
      pate.user.locale = new Locale ("ES", "ES")
      Locale locale = pate.user.locale
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
    }

    if (!pate.hasErrors() && pate.save()) {

      Link.findAllByTargetAndType(pate, metaDataService.ltPate).each {it.delete()}
      if (params.clients) {
        if(params.clients.class.isArray())
          params.clients.each {
            new Link(source: Entity.get(it), target: pate, type: metaDataService.ltPate).save()
          }
        else
          new Link(source: Entity.get(params.clients), target: pate, type: metaDataService.ltPate).save()
      }

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
      def entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etPate, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.password = authenticateService.encodePassword("pass")
        ent.user.enabled = params.enabled ?: false
      }
      if (params.clients) {
        if(params.clients.class.isArray())
          params.clients.each {
            new Link(source: Entity.get(it), target: pate, type: metaDataService.ltPate).save()
          }
        else
          new Link(source: Entity.get(params.clients), target: pate, type: metaDataService.ltPate).save()
      }
      if (params.lang == '1') {
        entity.user.locale = new Locale ("de", "DE")
        Locale locale = entity.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      if (params.lang == '2') {
        entity.user.locale = new Locale ("ES", "ES")
        Locale locale = entity.user.locale
        RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)
      }
      flash.message = message(code: "pate.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (de.uenterprise.ep.EntityException ee) {
      render(view: "create", model: [pate: ee.entity, entity: entityHelperService.loggedIn, clients: Entity.findAllByType(metaDataService.etClient)])
      return
    }

  }
}
