package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Profile
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.EntityException
import at.uenterprise.erp.Event
import at.uenterprise.erp.Live
import at.openfactory.ep.Asset

class GroupActivityProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService

  def beforeInterceptor = [
          action:{
            params.date = params.date ? Date.parse("dd. MM. yy hh:mm", params.date) : null},
            only:['save','update']
  ]

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: "list", params: params
  }

  def list = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def groupactivities = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etGroupActivity)
      profile {
        order(params.sort, params.order)
      }
    }

    return [groups: groupactivities]
  }

  def show = {
    Entity group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      // flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    List allClientgroups = Entity.findAllByType(metaDataService.etGroupClient)
    List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberClient) // find all clients linked to this group

    List allFacilities = Entity.findAllByType(metaDataService.etFacility)
    List facilities = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberFacility) // find all facilities linked to this group

    List allPartners = Entity.findAllByType(metaDataService.etPartner)
    List partners = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberPartner) // find all partners linked to this group

    def allParents = functionService.findParents(group)
    List parents = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberParent) // find all parents linked to this group

    def allEducators = functionService.findEducators(group)
    List educators = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberEducator) // find all educators linked to this group

    def allSubstitutes = Entity.findAllByType(metaDataService.etEducator)
    List substitutes = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberSubstitute) // find all educators linked to this group

    List groupTemplates = functionService.findAllByLink(null, group, metaDataService.ltGroupMember) // find all grouptemplates linked to this group

    Entity template = functionService.findByLink(null, group, metaDataService.ltTemplate) // find template

    def calculatedDuration = 0
    groupTemplates.each {
      calculatedDuration += it.profile.duration
    }

    // find all themes which are at the project time
    List allThemes = Entity.findAllByType(metaDataService.etTheme).findAll {it.profile.startDate <= group.profile.date && it.profile.endDate >= group.profile.date}

    List themes = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberActivityGroup)

    return [group: group,
            entity: entity,
            templates: groupTemplates,
            calculatedDuration: calculatedDuration,
            allEducators: allEducators,
            educators: educators,
            allSubstitutes: allSubstitutes,
            substitutes: substitutes,
            allParents: allParents,
            parents: parents,
            allPartners: allPartners,
            partners: partners,
            allFacilities: allFacilities,
            facilities: facilities,
            allClientGroups: allClientgroups,
            clients: clients,
            template: template,
            allThemes: allThemes,
            themes: themes]

  }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {

      // delete all links to and from this group first
      Link.findAllBySourceOrTarget(group, group).each {it.delete()}
      Event.findAllByEntity(group).each {it.delete()}

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
      //flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      // flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect action: 'list'
    }
    else {
      [group: group, entity: entity]
    }
  }

  def update = {
    Entity group = Entity.get(params.id)

    group.profile.properties = params
    group.profile.date = functionService.convertToUTC(group.profile.date)

    if (group.profile.save() && group.save()) {
      flash.message = message(code: "group.updated", args: [group.profile.fullName])
      redirect action: 'show', id: group.id
    }
    else {
      render view: 'edit', model: [group: group]
    }
  }

  def create = {
    Entity groupActivityTemplate = Entity.get(params.id)

    // find all templates linked to this group
    List templates = functionService.findAllByLink(null, groupActivityTemplate, metaDataService.ltGroupMember)

    def calculatedDuration = 0
    templates.each {
      calculatedDuration += it.profile.duration
    }

    return [template: groupActivityTemplate, calculatedDuration: calculatedDuration, workAroundName: groupActivityTemplate.profile.fullName]
  }

  def save = {
    Entity groupActivityTemplate = Entity.get(params.template)
    EntityType etGroupActivity = metaDataService.etGroupActivity

    Entity currentEntity = entityHelperService.loggedIn

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupActivity) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
        ent.profile.educationalObjective = ""
        ent.profile.date = functionService.convertToUTC(ent.profile.date)
      }
      // inherit profile picture: go through each asset of the template, find the asset of type "profile" and assign it to the new entity
      groupActivityTemplate.assets.each { Asset asset ->
        if (asset.type == "profile") {
          new Asset(entity: entity, storage: asset.storage, type: "profile").save()
        }
      }

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      // find all templates linked to the groupActivityTemplate
      List templates = functionService.findAllByLink(null, groupActivityTemplate, metaDataService.ltGroupMember)

      // and link them to the new groupActivity
      templates.each {
        new Link(source: it as Entity, target: entity, type: metaDataService.ltGroupMember).save()
      }

      // link template to instance
      new Link(source: groupActivityTemplate, target: entity, type: metaDataService.ltTemplate).save()

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat den Aktivitätsblock <a href="' + createLink(controller: 'groupActivityProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> geplant.').save()
      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (EntityException ee) {

      // find all templates linked to the groupActivityTemplate
      List templates = functionService.findAllByLink(null, groupActivityTemplate, metaDataService.ltGroupMember)

      def calculatedDuration = 0
      templates.each {
        calculatedDuration += it.profile.duration
      }

      render(view: "create", model: [group: ee.entity, workAroundName: ee.entity.profile.fullName, template: groupActivityTemplate, calculatedDuration: calculatedDuration])
    }

  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    if (linking.duplicate)
//       render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'educators', model: [educators: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    render template: 'educators', model: [educators: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addSubstitute = {
    def linking = functionService.linkEntities(params.substitute, params.id, metaDataService.ltGroupMemberSubstitute)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'substitutes', model: [substitutes: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeSubstitute = {
    def breaking = functionService.breakEntities(params.substitute, params.id, metaDataService.ltGroupMemberSubstitute)
    render template: 'substitutes', model: [substitutes: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addParent = {
    def linking = functionService.linkEntities(params.parent, params.id, metaDataService.ltGroupMemberParent)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'parents', model: [parents: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeParent = {
    def breaking = functionService.breakEntities(params.parent, params.id, metaDataService.ltGroupMemberParent)
    render template: 'parents', model: [parents: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'partners', model: [partners: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    render template: 'partners', model: [partners: linking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addFacility = {
    Entity group = Entity.get(params.id)
    def c = Link.createCriteria()
    def result = c.get {
      eq('target', Entity.get(params.id))
      eq('type', metaDataService.ltGroupMemberFacility)
    }
    if (!result) {
      def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
      if (linking.duplicate)
        //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
        render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
      render template: 'facilities', model: [facilities: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
    }
    else {
      List facilities = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberFacility)
      // render '<span class="red italic">Es wurde bereits eine Einrichtung zugewiesen!</span>'
      render '<span class="red italic">' +message(code: "alreadyAssignedToFacility")+'</span>'
      render template: 'facilities', model: [facilities: facilities, group: group, entity: entityHelperService.loggedIn]
    }

  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    render template: 'facilities', model: [facilities: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    functionService.breakEntities(params.client, params.id, metaDataService.ltAbsent)
    functionService.breakEntities(params.client, params.id, metaDataService.ltIll)
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template: 'clients', model: [clients: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def updateparents = {
    Entity group = Entity.get(params.id)
    def allParents = functionService.findParents(group)
    render template: 'parentselect', model: [allParents: allParents, group: group]
  }

  def updateeducators = {
    Entity group = Entity.get(params.id)
    def allEducators = functionService.findEducators(group)
    render template: 'educatorselect', model: [allEducators: allEducators, group: group]
  }

  def addTheme = {
    def linking = functionService.linkEntities(params.id, params.theme, metaDataService.ltGroupMemberActivityGroup)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.target.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<span class="red italic">"' + linking.target.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'themes', model: [themes: linking.results2, group: linking.source, entity: entityHelperService.loggedIn]
  }

  def removeTheme = {
    def breaking = functionService.breakEntities(params.id, params.theme, metaDataService.ltGroupMemberActivityGroup)
    render template: 'themes', model: [themes: breaking.results2, group: breaking.source, entity: entityHelperService.loggedIn]
  }

  /*
   * retrieves all clients and client groups matching the search parameter
   */
  def remoteClients = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      or {
        eq('type', metaDataService.etClient)
        eq('type', metaDataService.etGroupClient)
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'clientresults', model: [results: results, group: params.id])
    }
  }

  // adds a client or clients of a client group
  def addClient = {
    def entity = Entity.get(params.client)

    // if the entity is a client add it
    if (entity.type.id == metaDataService.etClient.id) {
      def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render template: 'clients', model: [clients: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
    }
    // if the entity is a client group get all clients and add them
    else if (entity.type.id == metaDataService.etGroupClient.id) {
      // find all clients of the group
      List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)

      clients.each {
        def linking = functionService.linkEntities(it.id as String, params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
          render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
      }

      Entity activitygroup = Entity.get(params.id)
      List clients2 = functionService.findAllByLink(null, activitygroup, metaDataService.ltGroupMemberClient)
      render template: 'clients', model: [clients: clients2, group: activitygroup, entity: entityHelperService.loggedIn]
    }

  }

}
