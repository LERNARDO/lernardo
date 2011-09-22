package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Profile
import at.openfactory.ep.Link
import at.uenterprise.erp.FunctionService

class ResourceProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
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

    // only list those resources that are linked to a colony or facility but NOT to an activity template
    List temp = Entity.findAllByType(metaDataService.etResource)

    List resources = []
    temp.each { resource ->
      def result = functionService.findByLink(resource, null, metaDataService.ltResource)
      if (result?.type?.id != metaDataService.etTemplate.id)
        resources << resource
    }

    // do pagination stuff
    def resourceTotal = resources.size()
    def upperBound = params.offset + params.max < resourceTotal ? params.offset + params.max : resourceTotal
    resources = resources.subList(params.offset, upperBound)

    return [resourceList: resources,
            resourceTotal: resourceTotal]
  }

  def show = {
    Entity resource = Entity.get(params.id)

    if (!resource) {
      flash.message = message(code: "object.notFound", args: [message(code: "resource")])
      redirect(action: list)
    }
    else {
      Entity location = functionService.findByLink(resource, null, metaDataService.ltResource)
      Entity resowner = functionService.findByLink(null, resource, metaDataService.ltOwner)
      List resresponsible = functionService.findAllByLink(null, resource, metaDataService.ltResponsible)
      [resource: resource, location: location, entity: resource, resowner: resowner, resresponsible: resresponsible]
    }
  }

  def del = {
    Entity resource = Entity.get(params.id)
    if (resource) {
      // delete all links
      Link.findAllBySourceOrTarget(resource, resource).each {it.delete()}
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "resource"), resource.profile.fullName])
        resource.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "resource"), resource.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "resource")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity resource = Entity.get(params.id)

    if (!resource) {
      flash.message = message(code: "object.notFound", args: [message(code: "resource")])
      redirect action: 'list'
    }
    else {
      [resource: resource, entity: resource]
    }
  }

  def update = {
    Entity resource = Entity.get(params.id)

    resource.profile.properties = params

    if (resource.profile.save() && resource.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "resource"), resource.profile.fullName])
      redirect action: 'show', id: resource.id
    }
    else {
      render view: 'edit', model: [resource: resource]
    }
  }

  def create = {}

  def save = {
    EntityType etResource = metaDataService.etResource

    Entity currentEntity = entityHelperService.loggedIn

    try {
      Entity entity = entityHelperService.createEntity("resource", etResource) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "object.created", args: [message(code: "resource"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [resource: ee.entity, entity: currentEntity])
    }

  }

  /*
   * retrieves all entities matching the search parameter
   */
  def remoteOwner = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      or {
        eq('type', metaDataService.etOperator)
        eq('type', metaDataService.etUser)
        eq('type', metaDataService.etEducator)
        eq('type', metaDataService.etParent)
        eq('type', metaDataService.etPate)
        eq('type', metaDataService.etPartner)
        eq('type', metaDataService.etFacility)
        eq('type', metaDataService.etGroupColony)
      }
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
      render(template: 'ownerresults', model: [results: results, resource: params.id])
    }
  }

  // adds a owner
  def addOwner = {
    Entity resource = Entity.get(params.id)

    // make sure there can be only 1 owner
    Link result = Link.findByTargetAndType(resource, metaDataService.ltOwner)
    if (!result) {
      def linking = functionService.linkEntities(params.entity, params.id, metaDataService.ltOwner)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render template: 'owner', model: [resowner: linking.results, resource: linking.target, entity: entityHelperService.loggedIn]
    }
    else {
      render '<span class="red italic">Es wurde bereits ein Besitzer zugewiesen!</span>'
      render template: 'owner', model: [resowner: functionService.findByLink(null, resource, metaDataService.ltOwner), resource: resource, entity: entityHelperService.loggedIn]
    }

  }

  def removeOwner = {
    def breaking = functionService.breakEntities(params.owner, params.id, metaDataService.ltOwner)
    render template: 'owner', model: [resowner: breaking.results, resource: breaking.target, entity: entityHelperService.loggedIn]
  }

  /*
   * retrieves all entities matching the search parameter
   */
  def remoteResponsible = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      or {
        eq('type', metaDataService.etOperator)
        eq('type', metaDataService.etUser)
        eq('type', metaDataService.etEducator)
        eq('type', metaDataService.etParent)
        eq('type', metaDataService.etPate)
        eq('type', metaDataService.etPartner)
      }
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
      render(template: 'responsibleresults', model: [results: results, resource: params.id])
    }
  }

  // adds a responsible
  def addResponsible = {
    def linking = functionService.linkEntities(params.entity, params.id, metaDataService.ltResponsible)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'responsible', model: [resresponsible: linking.results, resource: linking.target, entity: entityHelperService.loggedIn]

  }

  def removeResponsible = {
    def breaking = functionService.breakEntities(params.responsible, params.id, metaDataService.ltResponsible)
    render template: 'responsible', model: [resresponsible: breaking.results, resource: breaking.target, entity: entityHelperService.loggedIn]
  }

}
