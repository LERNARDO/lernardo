package profiles

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class ParentProfileController {
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
    return [parentList: Entity.findAllByType(metaDataService.etParent),
            parentTotal: Entity.countByType(metaDataService.etParent)]
  }

  def show = {
    def parent = Entity.get(params.id)
    def entity = params.entity ? parent : entityHelperService.loggedIn

    if (!parent) {
      flash.message = "ParentProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      return [parent: parent, entity: entity]
    }
  }

  def del = {
    def parent = Entity.get(params.id)
    if (parent) {
      // delete all links
      Link.findAllBySourceOrTarget(parent, parent).each {it.delete()}
      try {
        flash.message = message(code: "parent.deleted", args: [parent.profile.fullName])
        parent.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "parent.notDeleted", args: [parent.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "ParentProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    def parent = Entity.get(params.id)

    if (!parent) {
      flash.message = "ParentProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      return [parent: parent, entity: entityHelperService.loggedIn]
    }
  }

  def update = {
    def parent = Entity.get(params.id)

    parent.profile.properties = params

    parent.profile.showTips = params.showTips ?: false
    parent.profile.doesWork = params.doesWork ?: false
    parent.user.enabled = params.enabled ?: false

    if (!parent.profile.hasErrors() && parent.profile.save()) {
      flash.message = message(code: "parent.updated", args: [parent.profile.fullName])
      redirect action: 'show', id: parent.id
    }
    else {
      render view: 'edit', model: [parent: parent, entity: entityHelperService.loggedIn]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn]
  }

  def save = {
    EntityType etParent = metaDataService.etParent

    try {
      def entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etParent, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.password = authenticateService.encodePassword("pass")
        ent.profile.doesWork = params.doesWork ?: false
        ent.user.enabled = params.enabled ?: false
      }
      flash.message = message(code: "parent.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (de.uenterprise.ep.EntityException ee) {
      render(view: "create", model: [parent: ee.entity, entity: entityHelperService.loggedIn])
      return
    }

  }
}
