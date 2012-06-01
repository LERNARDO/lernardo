package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService

class HelperController {
  FunctionService functionService
  MetaDataService metaDataService
  EntityHelperService entityHelperService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    Entity currentEntity = entityHelperService.loggedIn

    List helpers = []
    if (currentEntity.type.id == metaDataService.etUser.id)
      helpers = Helper.list()
    else {
      Helper.list().each {
        if (it.types.contains(currentEntity.type.name))
          helpers << it
      }
    }

    return [helperInstanceList: helpers,
            helperInstanceTotal: helpers.size()]
  }

  def show = {
    Helper helperInstance = Helper.get(params.id)

    if (helperInstance) {
      [helperInstance: helperInstance]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "helper")])
      redirect action: list
    }

  }

  def del = {
    Helper helperInstance = Helper.get(params.id)
    if (helperInstance) {
      try {
        helperInstance.delete(flush: true)
        flash.message = message(code: "helper.deleted")
        redirect action: "list", id: params.entity
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "Helper ${params.id} could not be deleted"
        redirect action: "show", id: params.id
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "helper")])
      redirect action: "list"
    }
  }

  def edit = {
    Helper helperInstance = Helper.get(params.id)

    if (!helperInstance) {
      flash.message = message(code: "object.notFound", args: [message(code: "helper")])
      redirect action: 'list'
      return
    }

    return [helperInstance: helperInstance]

  }

  def update = {
    Helper helperInstance = Helper.get(params.id)

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

      if (helperInstance.save()) {
        flash.message = message(code: "helper.updated")
        redirect action: 'list'
      }
      else {
        render view: 'edit', model: [helperInstance: helperInstance]
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "helper")])
      redirect action: 'list'
    }
  }

  def create = {
    Helper helperInstance = new Helper()
    helperInstance.properties = params

    return [helperInstance: helperInstance]
  }

  def save = {
    Helper helperInstance = new Helper(params)
    Entity currentEntity = entityHelperService.loggedIn

    List types = params.list('types')

    types.each {
      helperInstance.addToTypes(it)
    }

    if (helperInstance.save(flush: true)) {
      functionService.createEvent(EVENT_TYPE.HELPER_CREATED, currentEntity.id.toInteger(), helperInstance.id.toInteger())

      flash.message = message(code: "helper.created")
      redirect action: "list"
    }
    else {
      render view: 'create', model: [helperInstance: helperInstance]
    }
  }
}
