package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import java.util.regex.Pattern
import at.openfactory.ep.Link

class ParentProfileController {
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

    EntityType etParent = metaDataService.etParent
    def parents = Entity.createCriteria().list {
      eq("type", etParent)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalParents = Entity.countByType(etParent)

    return [parents: parents, totalParents: totalParents]
  }

  def show = {
    Entity parent = Entity.get(params.id)

    if (!parent) {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect(action: list)
      return
    }

    Entity colony = functionService.findByLink(null, parent, metaDataService.ltColonia)
    // find family of the parent if there is one
    Entity family = functionService.findByLink(parent, null, metaDataService.ltGroupMemberParent)

    return [parent: parent, family: family, colony: colony]

  }

  def delete = {
    Entity parent = Entity.get(params.id)
    if (parent) {
      functionService.deleteReferences(parent)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "parent"), parent.profile.fullName])
        parent.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "parent"), parent.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect(action: "list")
    }
  }

  def edit = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    Entity parent = Entity.get(params.id)

    if (!parent) {
      flash.message = message(code: "object.notFound", args: [message(code: "parent")])
      redirect action: 'list'
      return
    }

    Entity colony = functionService.findByLink(null, parent, metaDataService.ltColonia)

    def c = Entity.createCriteria()
    def allColonies = c.list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    return [parent: parent, colony: colony, allColonies: allColonies]

  }

  def update = {
    if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd. MM. yy", params.birthDate)
    else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd.MM.yy", params.birthDate)
    else
      params.birthDate = null

    Entity parent = Entity.get(params.id)

    parent.profile.properties = params
    // parent.profile.birthDate = functionService.convertToUTC(parent.profile.birthDate)
    parent.profile.fullName = params.lastName + " " + params.firstName
    parent.user.properties = params

    //if (parent.id == entityHelperService.loggedIn.id)
    //  RequestContextUtils.getLocaleResolver(request).setLocale(request, response, parent.user.locale)

    // TODO: find out how to properly handle this cascading validation stuff
    // "parent.hasErrors()" returns false even though properties in the nested class "profile" did not validate
    
    // when validating a parent object it should check validation of nested objects as well because right now nested
    // properties that failed validation are not saved and the "show" view is called as if everything worked fine

    //if (!parent.hasErrors() && parent.save() && !parent.profile.hasErrors()) {
    //println "parent object has errors? " + parent.hasErrors()
    //println parent.errors.each {println it}
    //println "child object has errors? " + parent.profile.hasErrors()
    //println parent.profile.errors.each {println it}

    // update link to colony
    Link.findByTargetAndType(parent, metaDataService.ltColonia)?.delete()
    new Link(source: Entity.get(params.currentColony), target: parent, type: metaDataService.ltColonia).save()

    if (parent.profile.save() && parent.user.save() && parent.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "parent"), parent.profile.fullName])
      redirect action: 'show', id: parent.id, params: [entity: parent.id]
    }
    else {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"
      Entity colony = functionService.findByLink(null, parent, metaDataService.ltColonia)

      def c = Entity.createCriteria()
      def allColonies = c.list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }
      render view: 'edit', model: [parent: parent, colony: colony, allColonies: allColonies]
    }
  }

  def create = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def allColonies = c.list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    return [allColonies: allColonies]
  }

  def save = {
    EntityType etParent = metaDataService.etParent

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName,params.lastName), etParent, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd. MM. yy", params.birthDate)
        else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd.MM.yy", params.birthDate)
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        //ent.profile.birthDate = functionService.convertToUTC(ent.profile.birthDate)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      // create link to colony
      new Link(source: Entity.get(params.currentColony), target: entity, type: metaDataService.ltColonia).save()
      
      flash.message = message(code: "object.created", args: [message(code: "parent"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"

      def c = Entity.createCriteria()
      def allColonies = c.list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }
      render(view: "create", model: [parent: ee.entity, allColonies: allColonies])
    }

  }
}
