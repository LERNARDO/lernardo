package groups

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import at.openfactory.ep.Profile
import standard.FunctionService
import at.openfactory.ep.EntityException

class GroupActivityProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: "list", params: params
  }

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    return [groups: Entity.findAllByType(metaDataService.etGroupActivity),
            groupTotal: Entity.countByType(metaDataService.etGroupActivity),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      flash.message = "groupProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      List allClientgroups = Entity.findAllByType(metaDataService.etGroupClient)
      List clients = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberClient).collect {it.source} // find all clients linked to this group

      List allFacilities = Entity.findAllByType(metaDataService.etFacility)
      List facilities = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberFacility).collect {it.source} // find all facilities linked to this group

      List allPartners = Entity.findAllByType(metaDataService.etPartner)
      List partners = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberPartner).collect {it.source} // find all partners linked to this group

      def allParents = functionService.findParents(group)
      List parents = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberParent).collect {it.source} // find all parents linked to this group

      List allEducators = Entity.findAllByType(metaDataService.etEducator)
      List educators = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberEducator).collect {it.source} // find all educators linked to this group

      List groupTemplates = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember).collect {it.source} // find all grouptemplates linked to this group

      def template = Link.findByTargetAndType(group, metaDataService.ltTemplate).source // find template

      def calculatedDuration = 0
      groupTemplates.each {
        calculatedDuration += it.profile.duration
      }

      return [group: group,
              entity: entity,
              templates: groupTemplates,
              calculatedDuration: calculatedDuration,
              allEducators: allEducators,
              educators: educators,
              allParents: allParents,
              parents: parents,
              allPartners: allPartners,
              partners: partners,
              allFacilities: allFacilities,
              facilities: facilities,
              allClientGroups: allClientgroups,
              clients: clients,
              template: template]
    }
  }

  def del = {
    Entity group = Entity.get(params.id)
    if (group) {

      // delete all links to and from this group first
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
      flash.message = "groupProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (!group) {
      flash.message = "groupProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      [group: group, entity: entityHelperService.loggedIn]
    }
  }

  def update = {
    Entity group = Entity.get(params.id)

    group.profile.properties = params

    if (!group.profile.hasErrors() && group.profile.save()) {
      flash.message = message(code: "group.updated", args: [group.profile.fullName])
      redirect action: 'show', id: group.id
    }
    else {
      render view: 'edit', model: [group: group, entity: entityHelperService.loggedIn]
    }
  }

  def create = {
    Entity groupActivityTemplate = Entity.get(params.id)

    // find all templates linked to this group
    def links = Link.findAllByTargetAndType(groupActivityTemplate, metaDataService.ltGroupMember)
    List templates = links.collect {it.source}

    def calculatedDuration = 0
    templates.each {
      calculatedDuration += it.profile.duration
    }

    return [entity: entityHelperService.loggedIn, template: groupActivityTemplate, calculatedDuration: calculatedDuration]
  }

  def save = {
    Entity groupActivityTemplate = Entity.get(params.template)
    EntityType etGroupActivity = metaDataService.etGroupActivity

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupActivity) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
        ent.profile.educationalObjective = ""
        ent.profile.educationalObjectiveText = ""
      }

      // create link to creator
      new Link(source: entityHelperService.loggedIn, target: entity, type: metaDataService.ltCreator).save()

      // find all templates of this linked to the groupActivityTemplate
      def links = Link.findAllByTargetAndType(groupActivityTemplate, metaDataService.ltGroupMember)
      List templates = links.collect {it.source}

      // and link them to the new groupActivity
      templates.each {
        new Link(source: it as Entity, target: entity, type: metaDataService.ltGroupMember).save()
      }

      // link template to instance
      new Link(source: groupActivityTemplate, target: entity, type: metaDataService.ltTemplate).save()

      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (EntityException ee) {
      render(view: "create", model: [group: ee.entity, entity: entityHelperService.loggedIn, template: groupActivityTemplate])
      return
    }

  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'educators', model: [educators: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    render template: 'educators', model: [educators: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addSubstitute = {
    def linking = functionService.linkEntities(params.substitute, params.id, metaDataService.ltGroupMemberSubstitute)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'substitutes', model: [substitutes: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeSubstitute = {
    def breaking = functionService.breakEntities(params.substitute, params.id, metaDataService.ltGroupMemberSubstitute)
    render template: 'substitutes', model: [substitutes: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addParent = {
    def linking = functionService.linkEntities(params.parent, params.id, metaDataService.ltGroupMemberParent)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'parents', model: [parents: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeParent = {
    def breaking = functionService.breakEntities(params.parent, params.id, metaDataService.ltGroupMemberParent)
    render template: 'parents', model: [parents: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'partners', model: [partners: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    render template: 'partners', model: [partners: linking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addFacility = {
    def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'facilities', model: [facilities: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    render template: 'facilities', model: [facilities: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addClientGroup = {
    // get client group
    Entity clientgroup = Entity.get(params.clientgroup)
    // get all clients linked to this group
    List links = Link.findAllByTargetAndType(clientgroup, metaDataService.ltGroupMemberClient)
    List clients = links.collect {it.source}

    // link them to the activity group
    clients.each {
      def linking = functionService.linkEntities(it.id as String, params.id, metaDataService.ltGroupMemberClient)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    }

    Entity activitygroup = Entity.get(params.id)

    List clients2 = Link.findAllByTargetAndType(activitygroup, metaDataService.ltGroupMemberClient).collect {it.source}

    render template: 'clients', model: [clients: clients2, group: activitygroup, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template: 'clients', model: [clients: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def updateparents = {
    Entity group = Entity.get(params.id)
    def allParents = functionService.findParents(group)
    render template: 'parentselect', model: [allParents: allParents, group: group]
  }
}
