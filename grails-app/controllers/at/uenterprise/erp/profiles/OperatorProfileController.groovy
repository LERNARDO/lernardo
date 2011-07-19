package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.Msg
import at.uenterprise.erp.Publication
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Evaluation

class OperatorProfileController {
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

    EntityType etOperator = metaDataService.etOperator
    def operators = Entity.createCriteria().list {
      eq("type", etOperator)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalOperators = Entity.countByType(etOperator)

    return [operators: operators, totalOperators: totalOperators]
  }

  def show = {
    Entity operator = Entity.get(params.id)
    Entity entity = params.entity ? operator : entityHelperService.loggedIn

    if (!operator) {
      //flash.message = "OperatorProfile not found with id ${params.id}"
      flash.message = message(code: "operator.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    def allFacilities = Entity.findAllByType(metaDataService.etFacility)
    // find all facilities of this operator
    List facilities = functionService.findAllByLink(null, entity, metaDataService.ltOperation)

    return [operator: operator, entity: entity, facilities: facilities, allFacilities: allFacilities]

  }

  def delete = {
    Entity operator = Entity.get(params.id)
    if (operator) {
      // delete all links
      Link.findAllBySourceOrTarget(operator, operator).each {it.delete()}
      Msg.findAllBySenderOrReceiver(operator, operator).each {it.delete()}
      Publication.findAllByEntity(operator).each {it.delete()}
      Evaluation.findByOwnerOrWriter(operator, operator).each {it.delete()}
      Comment.findAllByCreator(operator.id.toInteger()).each { Comment comment ->
          // find the profile the comment belongs to and delete it from there
          def c = Entity.createCriteria()
          List entities = c.list {
              or {
                eq("type", metaDataService.etActivity)
                eq("type", metaDataService.etGroupActivity)
                eq("type", metaDataService.etGroupActivityTemplate)
                eq("type", metaDataService.etProject)
                eq("type", metaDataService.etProjectTemplate)
                eq("type", metaDataService.etTemplate)
              }
          }
          entities.each { Entity entity ->
              Comment profileComment = entity?.profile?.comments?.find {it.id == comment.id} as Comment
              if (profileComment)
                entity.profile.removeFromComments(profileComment)
          }
      }
      try {
        flash.message = message(code: "operator.deleted", args: [operator.profile.fullName])
        operator.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "operator.notDeleted", args: [operator.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      //flash.message = message(code: "operator.idNotFound", args: [params.id])
      flash.message = "OperatorProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity operator = Entity.get(params.id)

    if (!operator) {
      //flash.message = "OperatorProfile not found with id ${params.id}"
      flash.message = message(code: "operator.idNotFound", args: [params.id])
      redirect action: 'list'
      return
    }

    return [operator: operator]

  }

  def update = {
    Entity operator = Entity.get(params.id)

    operator.profile.properties = params
    operator.user.properties = params

    if (!operator.profile.calendar) operator.profile.calendar = new ECalendar().save()

    if (operator.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, operator.user.locale)

    if (operator.profile.save() && operator.user.save() && operator.save()) {
      flash.message = message(code: "operator.updated", args: [operator.profile.fullName])
      redirect action: 'show', id: operator.id, params: [entity: operator.id]
    }
    else {
      render view: 'edit', model: [operator: operator]
    }
  }

  def create = {}

  def save = {
    EntityType etOperator = metaDataService.etOperator

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.fullName), etOperator, params.email, params.fullName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.calendar = new ECalendar().save()
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      flash.message = message(code: "operator.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [operator: ee.entity])
    }

  }

  def addFacility = {
    def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltOperation)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    render template: 'facilities', model: [facilities: linking.results, operator: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltOperation)
    render template: 'facilities', model: [facilities: breaking.results, operator: breaking.target, entity: entityHelperService.loggedIn]
  }
}
