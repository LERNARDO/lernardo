package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType

class HelperController {
  FunctionService functionService
  MetaDataService metaDataService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    Entity entity = Entity.get(params.id)

    List helpers = []
    if (entity.type.id == metaDataService.etUser.id)
      helpers = Helper.list()
    else {
      Helper.list().each {
        if (it.types.contains(entity.type.name))
          helpers << it
      }
    }

    return [helperInstanceList: helpers,
            helperInstanceTotal: helpers.size(),
            entity: entity]
  }

  def show = {
    Helper helperInstance = Helper.get(params.id)

    if (!helperInstance) {
      flash.message = "Helper not found with id ${params.id}"
      redirect(action: list)
      return
    }

    return [helperInstance: helperInstance]

  }

  def del = {
    Helper helperInstance = Helper.get(params.id)
    if (helperInstance) {
      try {
        helperInstance.delete(flush: true)
        flash.message = message(code: "helper.deleted")
        redirect(action: "list", id: params.entity)
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "Helper ${params.id} could not be deleted"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "Helper not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Helper helperInstance = Helper.get(params.id)
    Entity entity = Entity.get(params.entity)

    if (!helperInstance) {
      flash.message = "Helper not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    return [helperInstance: helperInstance,
              entity: entity]

  }

  def update = {
    Helper helperInstance = Helper.get(params.id)
    Entity entity = Entity.get(params.name)
    if (helperInstance) {
      helperInstance.properties = params

      List types = params.list('types')

      List temp = helperInstance.types.toList()
      temp.each {
        helperInstance.removeFromTypes (it)
      }

      types.each {
        helperInstance.addToTypes(it)
      }

      if (!helperInstance.hasErrors() && helperInstance.save()) {
        flash.message = message(code: "helper.updated")
        redirect action: 'list', id: entity.id
      }
      else {
        render view: 'edit', model: [helperInstance: helperInstance, entity: entity]
      }
    }
    else {
      flash.message = "Helper not found with id ${params.id}"
      redirect action: 'list'
    }
  }

  def create = {
    Helper helperInstance = new Helper()
    helperInstance.properties = params
    Entity entity = Entity.get(params.entity)

    return [helperInstance: helperInstance,
            entity: entity]
  }

  def save = {
    Helper helperInstance = new Helper(params)
    Entity entity = Entity.get(params.name)

    List types = params.list('types')

    types.each {
      helperInstance.addToTypes(it)
    }

    List receivers = []
    types.each { type ->
      EntityType entityType = null
      if (type == 'operator')
        entityType = metaDataService.etOperator
      else if (type == 'educator')
        entityType = metaDataService.etEducator
      else if (type == 'client')
        entityType = metaDataService.etClient
      else if (type == 'partner')
        entityType = metaDataService.etPartner
      else if (type == 'pate')
        entityType = metaDataService.etPate
      else if (type == 'parent')
        entityType = metaDataService.etParent
      receivers.addAll(Entity.findAllByType(entityType))
    }

    receivers.each {
      functionService.createEvent(it as Entity, 'Es wurde das Hilfethema <a href="' + createLink(controller: 'helper', action: 'list') + '">' + helperInstance.title + '</a> angelegt.')
    }

    if (helperInstance.save(flush: true)) {
      flash.message = message(code: "helper.created")
      redirect action: "list", id: entity.id
    }
    else {
      render view: 'create', model: [helperInstance: helperInstance, entity: entity]
    }
  }
}
