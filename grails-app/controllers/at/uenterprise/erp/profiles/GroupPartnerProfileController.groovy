package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Profile
import at.uenterprise.erp.FunctionService

class GroupPartnerProfileController {
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

    EntityType etGroupPartner = metaDataService.etGroupPartner
    def groupPartners = Entity.createCriteria().list {
      eq("type", etGroupPartner)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalGroupPartners = Entity.countByType(etGroupPartner)

    return [groups: groupPartners, totalGroupPartners: totalGroupPartners]
  }

  def show = {
    def group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    def allPartners = Entity.findAllByType(metaDataService.etPartner)
    // find all partners linked to this group
    List partners = functionService.findAllByLink(null, group, metaDataService.ltGroupMember)

    return [group: group,
            entity: entity,
            partners: partners,
            allPartners: allPartners]

  }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {
      // delete all links
      Link.findAllBySourceOrTarget(group, group).each {it.delete()}
      try {
        flash.message = message(code: "group.deleted", args: [group.profile.fullName])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "group.notDeleted", args: [group.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (!group) {
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect action: 'list'
    }
    else {
      [group: group]
    }
  }

  def update = {
    Entity group = Entity.get(params.id)

    group.profile.properties = params

    if (group.profile.save() && group.save()) {
      flash.message = message(code: "group.updated", args: [group.profile.fullName])
      redirect action: 'show', id: group.id, params: [entity: group.id]
    }
    else {
      render view: 'edit', model: [group: group]
    }
  }

  def create = {
    return [templates: Entity.findAllByType(metaDataService.etTemplate)]
  }

  def save = {
    EntityType etGroupPartner = metaDataService.etGroupPartner

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupPartner) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (at.openfactory.ep.EntityException ee) {
      render(view: "create", model: [group: ee.entity])
    }

  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltGroupMember)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'partners', model: [partners: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltGroupMember)
    render template: 'partners', model: [partners: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

}
