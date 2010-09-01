package profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import standard.FunctionService
import standard.MetaDataService
import lernardo.Msg
import lernardo.Event
import lernardo.Publication

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
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def users = c.list {
      eq("type", metaDataService.etUser)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [userList: users,
            userTotal: Entity.countByType(metaDataService.etUser)]
  }

  def show = {
    Entity user = Entity.get(params.id)
    Entity entity = params.entity ? user : entityHelperService.loggedIn

    if (!user) {
      flash.message = "UserProfile not found with id ${params.id}"
      redirect(action: list)
      return
    }

    return [user: user, entity: entity]

  }

  def del = {
    Entity user = Entity.get(params.id)
    if (user) {
      // delete all links
      Link.findAllBySourceOrTarget(user, user).each {it.delete()}
      Msg.findAllByEntity(user).each {it.delete()}
      Event.findAllByEntity(user).each {it.delete()}
      Publication.findAllByEntity(user).each {it.delete()}
      try {
        flash.message = message(code: "user.deleted", args: [user.profile.fullName])
        user.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "user.notDeleted", args: [user.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "UserProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity user = Entity.get(params.id)

    if (!user) {
      flash.message = "UserProfile not found with id ${params.id}"
      redirect action: 'list'
      return
    }

    return [user: user]

  }

  def update = {
    Entity user = Entity.get(params.id)

    user.profile.properties = params
    user.profile.fullName = params.lastName + " " + params.firstName

    user.user.properties = params
    if (user.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, user.user.locale)

    if (!user.hasErrors() && user.save()) {
      flash.message = message(code: "user.updated", args: [user.profile.fullName])
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
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "user.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [user: ee.entity])
      return
    }

  }
}
