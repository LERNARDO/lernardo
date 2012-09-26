package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType

class UserProfileController {
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
    int totalUsers = Entity.countByType(metaDataService.etUser)

    return [totalUsers: totalUsers]
  }

  def show = {
    Entity user = Entity.get(params.id)

    if (!user) {
      flash.message = message(code: "object.notFound", args: [message(code: "user")])
      redirect(action: list)
      return
    }

    return [user: user]
  }

  def delete = {
    Entity user = Entity.get(params.id)
    if (user) {
      functionService.deleteReferences(user)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "user"), user.profile.fullName])
        user.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "user"), user.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "user")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity user = Entity.get(params.id)
    Entity entity = params.entity ? user : entityHelperService.loggedIn

    if (!user) {
      flash.message = message(code: "object.notFound", args: [message(code: "user")])
      redirect action: 'list'
      return
    }

    return [user: user, entity: entity]
  }

  def update = {
    Entity user = Entity.get(params.id)

    user.profile.properties = params
    user.profile.fullName = params.lastName + " " + params.firstName
    user.user.properties = params

    if (user.profile.save() && user.user.save() && user.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "user"), user.profile.fullName])
      redirect action: 'show', id: user.id
    }
    else {
      render view: 'edit', model: [user: user]
    }
  }

  def create = {}

  def save = {
    EntityType etUser = metaDataService.etUser

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etUser, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
      }

      flash.message = message(code: "object.created", args: [message(code: "user"), entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.uenterprise.erp.base.EntityException ee) {
      render view: "create", model: [user: ee.entity]
    }

  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().listDistinct  {
      eq('type', metaDataService.etUser)
      user {
        eq('enabled', params.active ? true : false)
      }
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        order(params.sort, params.order)
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'user', params: params]
  }
}
