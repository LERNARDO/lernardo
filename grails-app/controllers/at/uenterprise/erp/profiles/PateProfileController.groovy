package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType
import at.uenterprise.erp.Setup
import at.uenterprise.erp.base.Link

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
    int totalPates = Entity.countByType(metaDataService.etPate)
    List nationalities = Setup.list()[0]?.nationalities

    return [totalPates: totalPates, nationalities: nationalities]
  }

  def show = {
    Entity pate = Entity.get(params.id)

    if (!pate) {
      flash.message = message(code: "object.notFound", args: [message(code: "pate")])
      redirect(action: list)
      return
    }

    return [pate: pate, ajax: params.ajax]
  }

    def management = {
        Entity pate = Entity.get(params.id)

        List godchildren = functionService.findAllByLink(null, pate, metaDataService.ltPate)

        render template: "management", model: [pate: pate, godchildren: godchildren]
    }

  def delete = {
    Entity pate = Entity.get(params.id)
    if (pate) {
      functionService.deleteReferences(pate)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "pate"), pate.profile])
        pate.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "pate"), pate.profile])
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

    if (pate.profile.save() && pate.user.save() && pate.save()) {

      flash.message = message(code: "object.updated", args: [message(code: "pate"), pate.profile])
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
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
      }

      flash.message = message(code: "object.created", args: [message(code: "pate"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [pate: ee.entity, clients: Entity.findAllByType(metaDataService.etClient).findAll{it.user.enabled}]
    }

  }

  def addGodchildren = {
    def linking = functionService.linkEntities(params.child, params.id, metaDataService.ltPate)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
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
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().listDistinct {
      eq('type', metaDataService.etClient)
      user {
        eq("enabled", true)
      }
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render {span(class: 'italic', message(code: 'noResultsFound'))}
      return
    }
    else {
      render template: 'clientresults', model: [results: results, pate: params.id]
    }
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().listDistinct  {
      eq('type', metaDataService.etPate)
      user {
        eq('enabled', params.active ? true : false)
      }
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        if (params.country)
          eq('country', params.country)
        order(params.sort, params.order)
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'pate', params: params]
  }
}
