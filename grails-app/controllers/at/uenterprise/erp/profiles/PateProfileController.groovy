package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService

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
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etPate = metaDataService.etPate
    def pates = Entity.createCriteria().list {
      eq("type", etPate)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalPates = Entity.countByType(etPate)

    return [pates: pates, totalPates: totalPates]
  }

  def show = {
    Entity pate = Entity.get(params.id)

    if (!pate) {
      flash.message = message(code: "object.notFound", args: [message(code: "pate")])
      redirect(action: list)
      return
    }

    List godchildren = functionService.findAllByLink(null, pate, metaDataService.ltPate)

    return [pate: pate, allChildren: Entity.findAllByType(metaDataService.etClient).findAll{it.user.enabled}, godchildren: godchildren]

  }

  def delete = {
    Entity pate = Entity.get(params.id)
    if (pate) {
      functionService.deleteReferences(pate)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "pate"), pate.profile.fullName])
        pate.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "pate"), pate.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "pate")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity pate = Entity.get(params.id)

    if (!pate) {
      flash.message = message(code: "object.notFound", args: [message(code: "pate")])
      redirect action: 'list'
      return
    }

    return [pate: pate, clients: Entity.findAllByType(metaDataService.etClient).findAll{it.user.enabled}]
    
  }

  def update = {
    Entity pate = Entity.get(params.id)
    
    pate.profile.properties = params
    pate.profile.fullName = params.lastName + " " + params.firstName
    pate.user.properties = params
    //if (pate.id == entityHelperService.loggedIn.id)
    //  RequestContextUtils.getLocaleResolver(request).setLocale(request, response, pate.user.locale)

    if (pate.profile.save() && pate.user.save() && pate.save()) {

      flash.message = message(code: "object.updated", args: [message(code: "pate"), pate.profile.fullName])
      redirect action: 'show', id: pate.id
    }
    else {
      render view: 'edit', model: [pate: pate]
    }
  }

  def create = {
    return [clients: Entity.findAllByType(metaDataService.etClient).findAll{it.user.enabled}]
  }

  def save = {
    EntityType etPate = metaDataService.etPate

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etPate, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.save()
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "object.created", args: [message(code: "pate"), entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render view: "create", model: [pate: ee.entity, clients: Entity.findAllByType(metaDataService.etClient).findAll{it.user.enabled}]
    }

  }

  def addGodchildren = {
    def linking = functionService.linkEntities(params.child, params.id, metaDataService.ltPate)
    if (linking.duplicate)
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+ '</p>'
    render template:'godchildren', model: [godchildren: linking.sources, pate: linking.target]
  }

  def removeGodchildren = {
    def breaking = functionService.breakEntities(params.child, params.id, metaDataService.ltPate)
    render template:'godchildren', model: [godchildren: breaking.sources, pate: breaking.target]
  }

  /*
   * retrieves all clients matching the search parameter
   */
  def remoteClients = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render '<span class="gray">Bitte mindestens 2 Zeichen eingeben!</span>'
      return
    }

    def results = Entity.createCriteria().list {
      eq('type', metaDataService.etClient)
      user {
        eq("enabled", true)
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
          order('fullName','asc')
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+ '</span>'
      return
    }
    else {
      render template: 'clientresults', model: [results: results, pate: params.id]
    }
  }
}
