package lernardo

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import standard.MetaDataService
import at.openfactory.ep.Profile
import at.openfactory.ep.Link
import standard.FunctionService

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

    def c = Entity.createCriteria()
    def resources = c.list {
      eq("type", metaDataService.etResource)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [resourceList: resources,
            resourceTotal: Entity.countByType(metaDataService.etResource)]
  }

  def show = {
    Entity resource = Entity.get(params.id)

    if (!resource) {
      flash.message = "ResourceProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      [resource: resource]
    }
  }

  def del = {
    Entity resource = Entity.get(params.id)
    if (resource) {
      // delete all links
      Link.findAllBySourceOrTarget(resource, resource).each {it.delete()}
      try {
        flash.message = message(code: "resource.deleted", args: [resource.profile.fullName])
        resource.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "resource.notDeleted", args: [resource.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "ResourceProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity resource = Entity.get(params.id)

    if (!resource) {
      flash.message = "ResourceProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      [resource: resource]
    }
  }

  def update = {
    Entity resource = Entity.get(params.id)

    resource.profile.properties = params

    if (!resource.profile.hasErrors() && resource.profile.save()) {
      flash.message = message(code: "resource.updated", args: [resource.profile.fullName])
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

      functionService.createEvent(currentEntity, 'Du hast die Resource <a href="' + createLink(controller: 'resourceProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      List receiver = Entity.findAllByType(metaDataService.etEducator)
      receiver.each {
        if (it.id != currentEntity.id)
          functionService.createEvent(it as Entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Resource <a href="' + createLink(controller: 'resourceProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> angelegt.')
      }

      flash.message = message(code: "resource.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [resource: ee.entity, entity: entityHelperService.loggedIn])
      return
    }

  }
}
