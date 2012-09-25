package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.Resource

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
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    // only find those resources that are linked to a colony or facility but NOT to an activity template
    List temp = Entity.findAllByType(metaDataService.etResource)
    List resources = temp.inject([]) {result, resource ->
      def res = functionService.findByLink(resource, null, metaDataService.ltResource)
      res?.type?.id != metaDataService.etTemplate.id ? result + resource : result
    }

    // do pagination stuff
    def resourceTotal = resources.size()
    def upperBound = params.offset + params.max < resourceTotal ? params.offset + params.max : resourceTotal
    resources = resources.subList(params.offset, upperBound)

    return [resourceList: resources,
            resourceTotal: resourceTotal]
  }

  def show = {
    Entity resourceInstance = Entity.get(params.id)

    if (!resourceInstance) {
      flash.message = message(code: "object.notFound", args: [message(code: "resource")])
      redirect(action: list)
    }
    else {
      Entity location = functionService.findByLink(resourceInstance, null, metaDataService.ltResource)
      Entity resowner = functionService.findByLink(null, resourceInstance, metaDataService.ltOwner)
      List resresponsible = functionService.findAllByLink(null, resourceInstance, metaDataService.ltResponsible)
      [resourceInstance: resourceInstance, location: location, resowner: resowner, resresponsible: resresponsible]
    }
  }

  def del = {
    Entity resource = Entity.get(params.id)
    if (resource) {
      functionService.deleteReferences(resource)
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
      [resourceInstance: resource, entity: resource]
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
      render view: 'edit', model: [resourceInstance: resource]
    }
  }

  def create = {}

  def save = {
    EntityType etResource = metaDataService.etResource

    try {
      Entity entity = entityHelperService.createEntity("resource", etResource) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "object.created", args: [message(code: "resource"), entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [resourceInstance: ee.entity]
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
    else if (params.value.size() < 2) {
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().list {
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
      render template: 'ownerresults', model: [results: results, resourceInstance: params.id]
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
          render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile.fullName]))}
      render template: 'owner', model: [resowner: linking.sources, resourceInstance: linking.target]
    }
    else {
      render {span(class: 'italic red', message(code: 'alreadyAssignedToOwner'))}
      render template: 'owner', model: [resowner: functionService.findByLink(null, resource, metaDataService.ltOwner), resourceInstance: resource]
    }

  }

  def removeOwner = {
    def breaking = functionService.breakEntities(params.owner, params.id, metaDataService.ltOwner)
    render template: 'owner', model: [resowner: breaking.sources, resourceInstance: breaking.target]
  }

  /*
   * retrieves all entities matching the search parameter
   */
  def remoteResponsible = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().list {
      or {
        eq('type', metaDataService.etOperator)
        eq('type', metaDataService.etUser)
        eq('type', metaDataService.etEducator)
        eq('type', metaDataService.etParent)
        eq('type', metaDataService.etPate)
        eq('type', metaDataService.etPartner)
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
      render template: 'responsibleresults', model: [results: results, resourceInstance: params.id]
    }
  }

  // adds a responsible
  def addResponsible = {
    def linking = functionService.linkEntities(params.entity, params.id, metaDataService.ltResponsible)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile.fullName]))}
    render template: 'responsible', model: [resresponsible: linking.sources, resourceInstance: linking.target]

  }

  def removeResponsible = {
    def breaking = functionService.breakEntities(params.responsible, params.id, metaDataService.ltResponsible)
    render template: 'responsible', model: [resresponsible: breaking.sources, resourceInstance: breaking.target]
  }

  // Required resources below

  /*
  * adds a resource
  */
  def addResource = {
    Entity template = Entity.get(params.id)

    Resource resource = new Resource(params)
    template.profile.addToResources(resource)

    render template: '/requiredResources/resources', model: [template: template]
  }

  /*
   * removes a resource
   */
  def removeResource = {
    Entity template = Entity.get(params.id)

    Resource resource = Resource.get(params.resourceInstance)
    template.profile.removeFromResources(resource)

    render template: '/requiredResources/resources', model: [template: template]
  }

  def editResource = {
    Entity template = Entity.get(params.id)

    Resource resource = Resource.get(params.resourceInstance)
    render template: '/requiredResources/editresource', model: [template: template, resourceInstance: resource, i: params.i]
  }

  def updateResource = {
    Entity template = Entity.get(params.id)

    Resource resource = Resource.get(params.resourceInstance)
    resource.properties = params
    resource.save()
    render template: '/requiredResources/showresource', model: [template: template, resourceInstance: resource, i: params.i]
  }


}
