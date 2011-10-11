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

import at.uenterprise.erp.Live
import at.openfactory.ep.Asset
import at.uenterprise.erp.Evaluation
import at.openfactory.ep.LinkHelperService
import at.uenterprise.erp.Label
import at.uenterprise.erp.Event

class GroupActivityProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService
  LinkHelperService linkHelperService

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
    /*params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etGroupActivity = metaDataService.etGroupActivity
    def groupActivities = Entity.createCriteria().list {
      eq("type", etGroupActivity)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalGroupActivities = Entity.countByType(etGroupActivity)*/

    Entity currentEntity = entityHelperService.loggedIn

    // get themes
    List themes = []
    if (currentEntity.type == metaDataService.etEducator) {
      // find all facilities the current entity is linked to as educator or lead educator
      List facilities = []
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking))
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator))

      // find all themes that are linked to those facilities

      facilities.each { facility ->
        themes.addAll(functionService.findAllByLink(null, facility, metaDataService.ltThemeOfFacility))
      }
    }
    else
      themes = Entity.findAllByType(metaDataService.etTheme)

    params.sort = 'name'
    params.order = 'asc'

    return [/*groups: groupActivities,
            totalGroupActivities: totalGroupActivities,*/
            themes: themes,
            allLabels: Label.findAllByType('template', params)]
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

    Entity currentEntity = entityHelperService.loggedIn

    List allClientgroups = Entity.findAllByType(metaDataService.etGroupClient)
    List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberClient) // find all clients linked to this group

    // find all facilities the current entity is linked to
    List allFacilities
    if (currentEntity.type.id == metaDataService.etEducator.id) {
      log.info "current entity is educator"
      allFacilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking)
      log.info allFacilities
      allFacilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator))
    }
    else
      allFacilities = Entity.findAllByType(metaDataService.etFacility)

    List facilities = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberFacility) // find all facilities linked to this group

    List allPartners = Entity.findAllByType(metaDataService.etPartner)
    List partners = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberPartner) // find all partners linked to this group

    def allParents = functionService.findParents(group)
    List parents = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberParent) // find all parents linked to this group

    List educators = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberEducator) // find all educators linked to this group

    List substitutes = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberSubstitute) // find all educators linked to this group

    Entity template = functionService.findByLink(null, group, metaDataService.ltTemplate) // find template

    List templatesOfGroup = functionService.findAllByLink(null, group, metaDataService.ltGroupMember) // find all templates linked to this group
    List templates = []
    template.profile.templates.each {
      Entity temp = Entity.get(it.toInteger())
      if (templatesOfGroup.contains(temp))
        templates.add(temp)
    }

    def calculatedDuration = 0
    templates.each {
      calculatedDuration += it.profile.duration
    }

    // find all themes which are at the project time
    List allThemes = Entity.findAllByType(metaDataService.etTheme).findAll {it.profile.startDate <= group.profile.date && it.profile.endDate >= group.profile.date}

    List themes = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberActivityGroup)

    List requiredResources = []
    requiredResources.addAll(template.profile.resources)
    templates.each {
      requiredResources.addAll(it.profile.resources)
    }

    List plannableResources = []
    facilities.each { Entity facility ->
      // add resources linked to the facility to plannable resources
      plannableResources.addAll(functionService.findAllByLink(null, facility, metaDataService.ltResource))
      // find colony the facility is linked to and add its resources as well
      Entity colony = functionService.findByLink(facility, null, metaDataService.ltGroupMemberFacility)
      plannableResources.addAll(functionService.findAllByLink(null, colony, metaDataService.ltResource))

      // find all other facilities linked to the colony and add their resources if marked as available in colony
      List colonyResources = []
      List otherFacilities = functionService.findAllByLink(null, colony, metaDataService.ltGroupMemberFacility)
      otherFacilities.each { Entity of ->
        List tempResources = functionService.findAllByLink(null, of, metaDataService.ltResource)
        tempResources.each { Entity tr ->
          if (tr.profile.classification == "colony") {
            if (!colonyResources.contains(tr)) {
              colonyResources.add(tr)
            }
          }
        }
      }
      plannableResources.addAll(colonyResources)
    }

    // add all resources that are available everywhere
    List everywhereResources = Entity.createCriteria().list {
      eq("type", metaDataService.etResource)
      profile {
        eq("classification", "everywhere")
      }
    }
    plannableResources.addAll(everywhereResources)

    List resources = functionService.findAllByLink(null, group, metaDataService.ltResourcePlanned)

    params.sort = params.sort ?: 'name'
    params.order = params.order ?: 'asc'

    return [group: group,
            entity: entity,
            templates: templates,
            calculatedDuration: calculatedDuration,
            educators: educators,
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
            themes: themes,
            requiredResources: requiredResources,
            plannableResources: plannableResources,
            resources: resources,
            allLabels: Label.findAllByType('template', params)]

  }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {

      // delete all links to and from this group first
      Event.findAllByWhoOrWhat(group.id.toInteger(), group.id.toInteger()).each {it.delete()}
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
      redirect action: 'show', id: group.id, params: [entity: group.id]
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
      templates.each { Entity template ->
        new Link(source: template, target: entity, type: metaDataService.ltGroupMember).save()
      }

      // link template to instance
      new Link(source: groupActivityTemplate, target: entity, type: metaDataService.ltTemplate).save()

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat den Aktivitätsblock <a href="' + createLink(controller: 'groupActivityProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> geplant.').save()
      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
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
      eq('source', Entity.get(params.id))
      eq('type', metaDataService.ltGroupMemberFacility)
    }
    if (!result) {
      def linking = functionService.linkEntities(params.id, params.facility, metaDataService.ltGroupMemberFacility)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.target.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
      render template: 'facilities', model: [facilities: linking.results2, group: linking.source, entity: entityHelperService.loggedIn]
    }
    else {
      List facilities = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberFacility)
      render '<span class="red italic">' +message(code: "alreadyAssignedToFacility")+'</span>'
      render template: 'facilities', model: [facilities: facilities, group: group, entity: entityHelperService.loggedIn]
    }

  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.id, params.facility, metaDataService.ltGroupMemberFacility)
    render template: 'facilities', model: [facilities: breaking.results2, group: breaking.source, entity: entityHelperService.loggedIn]

    // delete all planned resources
    // TODO: when a facility is removed the elements in the GSP that show the plannable resources and the currently
    // planned resources need to be updated as well
    //Entity group = Entity.get(params.id)
    //Link.findAllByTargetAndType(group, metaDataService.ltResourcePlanned).each {it.delete()}
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

  def addTheme = {
    def linking = functionService.linkEntities(params.id, params.theme, metaDataService.ltGroupMemberActivityGroup)
    if (linking.duplicate)
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
        render '<span class="red italic">"' + linking.source.profile.fullName + '" ' + message(code: "alreadyAssignedTo") + '</span>'
      render template: 'clients', model: [clients: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
    }
    // if the entity is a client group get all clients and add them
    else if (entity.type.id == metaDataService.etGroupClient.id) {
      // find all clients of the group
      List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)

      clients.each { Entity client ->
        def linking = functionService.linkEntities(client.id.toString(), params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
          render '<div class="red italic">"' + linking.source.profile.fullName + '" ' + message(code: "alreadyAssignedTo") + '</div>'
      }

      Entity activitygroup = Entity.get(params.id)
      List clients2 = functionService.findAllByLink(null, activitygroup, metaDataService.ltGroupMemberClient)
      render template: 'clients', model: [clients: clients2, group: activitygroup, entity: entityHelperService.loggedIn]
    }

  }

  def listevaluations = {
    Entity groupActivity = Entity.get(params.id)
    List evaluations = Evaluation.findAllByLinkedTo(groupActivity)
    return [evaluations: evaluations, entity: groupActivity]
  }

  def createpdf = {
    println params
    Entity group = Entity.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn

    List activities = functionService.findAllByLink(null, group, metaDataService.ltGroupMember)
    List themes = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberActivityGroup) // find all activities linked to this group
    List facilities = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberFacility) // find all facilities linked to this group
    List educators = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberEducator) // find all educators linked to this group
    List substitutes = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberSubstitute) // find all educators linked to this group
    List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberClient) // find all clients linked to this group
    List parents = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberParent) // find all parents linked to this group
    List partners = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberPartner) // find all partners linked to this group
    Entity template = functionService.findByLink(null, group, metaDataService.ltTemplate) // find template

    renderPdf template: 'createpdf', model: [entity: currentEntity,
                                             group: group,
                                             activities: activities,
                                             themes: themes,
                                             facilities: facilities,
                                             educators: educators,
                                             substitutes: substitutes,
                                             clients: clients,
                                             parents: parents,
                                             partners: partners,
                                             template: template,
                                             withTemplates: params.printtemplates == "" ? 'true' : 'false'], filename: message(code: 'groupActivity') + '_' + group.profile.fullName
  }

  def searchbydate = {
    def beginDate = null
    def endDate = null
    if (params.beginDate)
      beginDate = Date.parse("dd. MM. yy", params.beginDate)
    if (params.endDate)
        endDate = Date.parse("dd. MM. yy", params.endDate)
    if (!beginDate || !endDate)
      render '<span class="red italic">Bitte Von und Bis Datum eingeben</span>'
    else {
      List groupActivities = Entity.createCriteria().list {
        eq("type", metaDataService.etGroupActivity)
        profile {
          ge("date", beginDate)
          le("date", endDate)
        }
      maxResults(15)
      }

      if (groupActivities.size() == 0) {
        render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
        return
      }
      else {
        render template: 'searchresults', model: [groups: groupActivities]
      }
    }
  }

  def searchbytheme = {
    Entity theme = Entity.get(params.theme)

    if (theme) {
      // find all group activities that are linked to this theme
      List groupActivities = functionService.findAllByLink(null, theme, metaDataService.ltGroupMemberActivityGroup)
      if (groupActivities.size() == 0) {
        render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
        return
      }
      else {
        render(template: 'searchresults', model: [groups: groupActivities])
      }
    }
    else
      render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
  }

  def searchbyname = {
    if (!params.name) {
      render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
      return
    }

    def c = Entity.createCriteria()
    def users = c.list {
      eq("type", metaDataService.etGroupActivity)
      or {
        ilike('name', "%" + params.name + "%")
        profile {
          ilike('fullName', "%" + params.name + "%")
        }
      }
      maxResults(30)
    }

    if (users.size() == 0) {
      render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
      return
    }
    else {
      render(template: 'searchresults', model: [groups: users])
    }
  }

  def searchbylabel = {
    List entities = Entity.findAllByType(metaDataService.etGroupActivity)
    List result = []
    List labels = params.list('labels')
    entities.each { Entity entity ->
      entity.profile.labels.each { Label label ->
        if (labels.contains(label.name)) {
          if (!result.contains(entity))
            result.add(entity)
        }
      }
    }

    if (result.size() == 0) {
      render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
      return
    }
    else {
        render(template: 'searchresults', model: [groups: result])
    }
  }


  def planresource = {
    Entity group = Entity.get(params.id)
    Entity resource = Entity.get(params.resource)
    render template: 'planresource', model: [group: group, resource: resource, i: params.i, resourceFree: params.int('resourceFree')]
  }

  def planresourcenow = {
    Entity group = Entity.get(params.id)
    Entity resource = Entity.get(params.resource)

    Calendar calendar = new GregorianCalendar()
    calendar.setTime(group.profile.date)
    calendar.add(Calendar.MINUTE, group.profile.realDuration)

    Link link = linkHelperService.createLink(resource, group, metaDataService.ltResourcePlanned) {link, dad ->
      dad.beginDate = group.profile.date.getTime() / 1000
      dad.endDate = calendar.getTime().getTime() / 1000
      dad.amount = params.amount
    }

    List resources = functionService.findAllByLink(null, group, metaDataService.ltResourcePlanned)
    render template: 'resources', model: [resources: resources, entity: entityHelperService.loggedIn, group: group]
  }

  def unplanresource = {
    Entity group = Entity.get(params.id)
    Entity resource = Entity.get(params.resource)

    def link = Link.createCriteria().get {
      eq('source', resource)
      eq('target', group)
      eq('type', metaDataService.ltResourcePlanned)
    }
    if (link) {
      link.delete()
    }

    List resources = functionService.findAllByLink(null, group, metaDataService.ltResourcePlanned)
    render template: 'resources', model: [resources: resources, entity: entityHelperService.loggedIn, group: group]
  }

  def refreshplannableresources = {
    Entity group = Entity.get(params.id)
    List facilities = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberFacility)

    List plannableResources = []
    facilities.each { Entity facility ->
      // add resources linked to the facility to plannable resources
      plannableResources.addAll(functionService.findAllByLink(null, facility, metaDataService.ltResource))
      // find colony the facility is linked to and add its resources as well
      Entity colony = functionService.findByLink(facility, null, metaDataService.ltGroupMemberFacility)
      plannableResources.addAll(functionService.findAllByLink(null, colony, metaDataService.ltResource))
    }

    render template: 'plannableresources', model: [plannableResources: plannableResources, group: group]
  }

  /*
   * adds a label to an entity by creating a new label instance and copying the properties from the given "label template"
   */
  def addLabel = {
    Entity entity = Entity.get(params.id)
    Label labelTemplate = Label.get(params.label)

    // make sure a label can only be added once
    Boolean canBeAdded = true
    entity.profile.labels.each {
        if (it.name == labelTemplate.name)
            canBeAdded = false
    }
    if (canBeAdded) {
        Label label = new Label()

        label.name = labelTemplate.name
        label.description = labelTemplate.description
        label.type = "instance"

        entity.profile.addToLabels(label)
    }
    render template: 'labels', model: [group: entity, entity: entityHelperService.loggedIn]
  }

  /*
   * removes a label from a group
   */
  def removeLabel = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [group: group, entity: entityHelperService.loggedIn]
  }

  /*
   * retrieves all educators matching the search parameter
   */
  def remoteEducators = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value == "*") {
      render(template: 'educatorresults', model: [results: Entity.findAllByType(metaDataService.etEducator), group: params.id])
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etEducator)
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
      def allowedEducators = functionService.findEducators(Entity.get(params.id))
      List finalResult = []
      allowedEducators.each { Entity ae ->
        if (results.contains(ae))
          finalResult.add(ae)
      }
      render(template: 'educatorresults', model: [results: finalResult, group: params.id])
    }
  }

  /*
   * retrieves all educators matching the search parameter
   */
  def remoteSubstitutes = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value == "*") {
      render(template: 'substituteresults', model: [results: Entity.findAllByType(metaDataService.etEducator), group: params.id])
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etEducator)
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
      render(template: 'substituteresults', model: [results: results, group: params.id])
    }
  }

}