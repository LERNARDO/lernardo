package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.base.EntityException

import at.uenterprise.erp.Live
import at.uenterprise.erp.base.Asset
import at.uenterprise.erp.Evaluation
import at.uenterprise.erp.base.LinkHelperService
import at.uenterprise.erp.Label
import java.text.SimpleDateFormat
import at.uenterprise.erp.LinkDataService
import at.uenterprise.erp.EntityDataService

class GroupActivityProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService
  LinkHelperService linkHelperService
  LinkDataService linkDataService
  EntityDataService entityDataService

  def beforeInterceptor = [
          action:{
            params.date = params.date('date', 'dd. MM. yy HH:mm')
            params.mondayStart = params.date('mondayStart', 'HH:mm')
            params.tuesdayStart = params.date('tuesdayStart', 'HH:mm')
            params.wednesdayStart = params.date('wednesdayStart', 'HH:mm')
            params.thursdayStart = params.date('thursdayStart', 'HH:mm')
            params.fridayStart = params.date('fridayStart', 'HH:mm')
            params.saturdayStart = params.date('saturdayStart', 'HH:mm')
            params.sundayStart = params.date('sundayStart', 'HH:mm')

            params.periodStart = params.date('periodStart', 'dd. MM. yy')
            params.periodEnd = params.date('periodEnd', 'dd. MM. yy')},
            only:['save','update']
  ]

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: "list", params: params
  }

  def list = {
    int totalGroupActivities = Entity.countByType(metaDataService.etGroupActivity)

    Entity currentEntity = entityHelperService.loggedIn

    // get themes
    List themes = []
    if (currentEntity.type == metaDataService.etEducator) {
      // find all facilities the current entity is linked to as educator or lead educator
      List facilities = []
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking))
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator))

      // find all themes that are linked to those facilities

      facilities.each { Entity facility ->
        themes.addAll(functionService.findAllByLink(null, facility, metaDataService.ltThemeOfFacility))
      }
    }
    else
      themes = Entity.findAllByType(metaDataService.etTheme)

    return [totalGroupActivities: totalGroupActivities,
            themes: themes,
            allLabels: functionService.getLabels()]
  }

  def show = {
    Entity group = Entity.get(params.id)

    if (!group) {
      flash.message = message(code: "object.notFound", args: [message(code: "groupActivity")])
      redirect(action: list)
      return
    }

      Entity template = functionService.findByLink(null, group, metaDataService.ltTemplate) // find template

    return [group: group, template: template, allLabels: functionService.getLabels()]
  }

    def management = {
        Entity group = Entity.get(params.id)

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
        template?.profile?.templates?.each {
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
        if (template?.profile?.resources)
            requiredResources.addAll(template?.profile?.resources)
        templates.each {
            requiredResources.addAll(it.profile.resources)
        }

        List resources = functionService.findAllByLink(null, group, metaDataService.ltResourcePlanned)

        render template: "management", model: [group: group,
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
                resources: resources]

    }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {
      functionService.deleteReferences(group)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "groupActivity"), group.profile.fullName])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "groupActivity"), group.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "groupActivity")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      flash.message = message(code: "object.notFound", args: [message(code: "groupActivity")])
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
      flash.message = message(code: "object.updated", args: [message(code: "groupActivity"), group.profile.fullName])
      redirect action: 'show', id: group.id
    }
    else {
      render view: 'edit', model: [group: group]
    }
  }

  def choose = {

  }

  def remoteTemplates = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().list {
      eq('type', metaDataService.etGroupActivityTemplate)
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render {span(class: 'italic', message(code: 'noResultsFound'))}
      return
    }
    else {
      render template: 'templateresults', model: [results: results]
    }
  }

  def addTemplate = {
    Entity template = Entity.get(params.id)

    def msg = message(code: "activityTemplate.selected")
    render ("<b>${msg}</b> ${template.profile.fullName}")
  }

  def create = {
    Entity groupActivityTemplate = Entity.get(params.id)
    if (!groupActivityTemplate)
      groupActivityTemplate = Entity.get(params.template)
    if (!groupActivityTemplate) {
      redirect action: "choose"
      return
    }

    // find all templates linked to this group
    List templates = functionService.findAllByLink(null, groupActivityTemplate, metaDataService.ltGroupMember)

    def calculatedDuration = 0
    templates.each {
      calculatedDuration += it.profile.duration
    }

    return [template: groupActivityTemplate, calculatedDuration: calculatedDuration, workAroundName: groupActivityTemplate.profile.fullName]
  }

  def save = {GroupActivityCommand ac ->
    Entity groupActivityTemplate = Entity.get(params.template)

    if (ac.hasErrors()) {
      render view: 'create', model: ['ac':ac, template: groupActivityTemplate]
      return
    }

    EntityType etGroupActivity = metaDataService.etGroupActivity
    Entity currentEntity = entityHelperService.loggedIn

    // single day
    if (params.date != null) {
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

        // loop through all labels of the original and create them in the copy
        groupActivityTemplate.profile.labels.each { Label la ->
          Label label = new Label()

          label.name = la.name
          label.description = la.description
          label.type = "instance"

          label.save(flush: true)

          entity.profile.addToLabels(label)
        }

        new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name + 'Profile', action: 'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat den Aktivitätsblock <a href="' + createLink(controller: 'groupActivityProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> geplant.').save()
        flash.message = message(code: "object.created", args: [message(code: "groupActivity"), entity.profile.fullName])
        redirect action: 'show', id: entity.id
      } catch (EntityException ee) {

        // find all templates linked to the groupActivityTemplate
        List templates = functionService.findAllByLink(null, groupActivityTemplate, metaDataService.ltGroupMember)

        def calculatedDuration = 0
        templates.each {
          calculatedDuration += it.profile.duration
        }

        render view: "create", model: [group: ee.entity, workAroundName: ee.entity.profile.fullName, template: groupActivityTemplate, calculatedDuration: calculatedDuration]
      }
    }
    // multiple days
    else {
      Date periodStart = params.periodStart
      Date periodEnd = params.periodEnd

      // subtract one minute of the period end for correct calculation
      periodEnd.setHours(23)
      periodEnd.setMinutes(59)

      SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

      Date currentDate = periodStart
      while (currentDate <= periodEnd) {

        if ((params.monday && df.format(currentDate) == 'Monday') ||
            (params.tuesday && df.format(currentDate) == 'Tuesday') ||
            (params.wednesday && df.format(currentDate) == 'Wednesday') ||
            (params.thursday && df.format(currentDate) == 'Thursday') ||
            (params.friday && df.format(currentDate) == 'Friday') ||
            (params.saturday && df.format(currentDate) == 'Saturday') ||
            (params.sunday && df.format(currentDate) == 'Sunday')) {

          Entity entity = entityHelperService.createEntity("group", etGroupActivity) {Entity ent ->
            ent.profile = profileHelperService.createProfileFor(ent) as Profile
            ent.profile.properties = params
            ent.profile.educationalObjective = ""
            ent.profile.date = currentDate
            if (df.format(currentDate) == 'Monday') {
              ent.profile.date.setHours(params.mondayStart.getHours())
              ent.profile.date.setMinutes(params.mondayStart.getMinutes())
            }
            else if (df.format(currentDate) == 'Tuesday') {
              ent.profile.date.setHours(params.tuesdayStart.getHours())
              ent.profile.date.setMinutes(params.tuesdayStart.getMinutes())
            }
            else if (df.format(currentDate) == 'Wednesday') {
              ent.profile.date.setHours(params.wednesdayStart.getHours())
              ent.profile.date.setMinutes(params.wednesdayStart.getMinutes())
            }
            else if (df.format(currentDate) == 'Thursday') {
              ent.profile.date.setHours(params.thursdayStart.getHours())
              ent.profile.date.setMinutes(params.thursdayStart.getMinutes())
            }
            else if (df.format(currentDate) == 'Friday') {
              ent.profile.date.setHours(params.fridayStart.getHours())
              ent.profile.date.setMinutes(params.fridayStart.getMinutes())
            }
            else if (df.format(currentDate) == 'Saturday') {
              ent.profile.date.setHours(params.saturdayStart.getHours())
              ent.profile.date.setMinutes(params.saturdayStart.getMinutes())
            }
            else if (df.format(currentDate) == 'Sunday') {
              ent.profile.date.setHours(params.sundayStart.getHours())
              ent.profile.date.setMinutes(params.sundayStart.getMinutes())
            }
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

          // loop through all labels of the original and create them in the copy
          groupActivityTemplate.profile.labels.each { Label la ->
            Label label = new Label()

            label.name = la.name
            label.description = la.description
            label.type = "instance"

            label.save(flush: true)

            entity.profile.addToLabels(label)
          }

          new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name + 'Profile', action: 'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat den Aktivitätsblock <a href="' + createLink(controller: 'groupActivityProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> geplant.').save()
        }

        currentDate += 1
      }
      redirect action: 'list'
    }

  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile.fullName]))}
    render template: 'educators', model: [educators: linking.sources, group: linking.target]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltGroupMemberEducator)
    render template: 'educators', model: [educators: breaking.sources, group: breaking.target]
  }

  def addSubstitute = {
    def linking = functionService.linkEntities(params.substitute, params.id, metaDataService.ltGroupMemberSubstitute)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile.fullName]))}
    render template: 'substitutes', model: [substitutes: linking.sources, group: linking.target]
  }

  def removeSubstitute = {
    def breaking = functionService.breakEntities(params.substitute, params.id, metaDataService.ltGroupMemberSubstitute)
    render template: 'substitutes', model: [substitutes: breaking.sources, group: breaking.target]
  }

  def addParent = {
    def linking = functionService.linkEntities(params.parent, params.id, metaDataService.ltGroupMemberParent)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile.fullName]))}
    render template: 'parents', model: [parents: linking.sources, group: linking.target]
  }

  def removeParent = {
    def breaking = functionService.breakEntities(params.parent, params.id, metaDataService.ltGroupMemberParent)
    render template: 'parents', model: [parents: breaking.sources, group: breaking.target]
  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile.fullName]))}
    render template: 'partners', model: [partners: linking.sources, group: linking.target]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltGroupMemberPartner)
    render template: 'partners', model: [partners: breaking.sources, group: breaking.target]
  }

  def addFacility = {
    Entity group = Entity.get(params.id)
    def result = Link.createCriteria().get {
      eq('source', Entity.get(params.id))
      eq('type', metaDataService.ltGroupMemberFacility)
    }
    if (!result) {
      def linking = functionService.linkEntities(params.id, params.facility, metaDataService.ltGroupMemberFacility)
      if (linking.duplicate)
          render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.target.profile.fullName]))}
      render template: 'facilities', model: [facilities: linking.targets, group: linking.source]
    }
    else {
      List facilities = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberFacility)
      render {span(class: 'italic red', message(code: 'alreadyAssignedToFacility'))}
      render template: 'facilities', model: [facilities: facilities, group: group]
    }

  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.id, params.facility, metaDataService.ltGroupMemberFacility)

    Entity group = Entity.get(params.id)
    Link.findAllByTargetAndType(group, metaDataService.ltResourcePlanned).each {it.delete()}

    render template: 'facilities', model: [facilities: breaking.targets, group: breaking.source]
  }

  def removeClient = {
    functionService.breakEntities(params.client, params.id, metaDataService.ltAbsent)
    functionService.breakEntities(params.client, params.id, metaDataService.ltIll)
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template: 'clients', model: [clients: breaking.sources, group: breaking.target]
  }

  def updateparents = {
    Entity group = Entity.get(params.id)
    def allParents = functionService.findParents(group)
    render template: 'parentselect', model: [allParents: allParents, group: group]
  }

  def addTheme = {
    def linking = functionService.linkEntities(params.id, params.theme, metaDataService.ltGroupMemberActivityGroup)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.target.profile.fullName]))}
    render template: 'themes', model: [themes: linking.targets, group: linking.source]
  }

  def removeTheme = {
    def breaking = functionService.breakEntities(params.id, params.theme, metaDataService.ltGroupMemberActivityGroup)
    render template: 'themes', model: [themes: breaking.targets, group: breaking.source]
  }

  /*
   * retrieves all clients and client groups matching the search parameter
   */
  def remoteClients = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().list {
      or {
        eq('type', metaDataService.etClient)
        eq('type', metaDataService.etGroupClient)
      }
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render {span(class: 'italic', message(code: 'noResultsFound'))}
      return
    }
    else {
      render template: 'clientresults', model: [results: results, group: params.id]
    }
  }

  // adds a client or clients of a client group
  def addClient = {
    def entity = Entity.get(params.client)

    // if the entity is a client add it
    if (entity.type.id == metaDataService.etClient.id) {
      def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
      if (linking.duplicate)
          render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile.fullName]))}
      render template: 'clients', model: [clients: linking.sources, group: linking.target]
    }
    // if the entity is a client group get all clients and add them
    else if (entity.type.id == metaDataService.etGroupClient.id) {
      // find all clients of the group
      List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)

      clients.each { Entity client ->
        def linking = functionService.linkEntities(client.id.toString(), params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
            render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile.fullName]))}
      }

      Entity activitygroup = Entity.get(params.id)
      List clients2 = functionService.findAllByLink(null, activitygroup, metaDataService.ltGroupMemberClient)
      render template: 'clients', model: [clients: clients2, group: activitygroup]
    }

  }

  def listevaluations = {
    Entity groupActivity = Entity.get(params.id)
    List evaluations = Evaluation.findAllByLinkedTo(groupActivity)
    return [evaluations: evaluations, entity: groupActivity]
  }

  def createpdf = {
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

    renderPdf template: 'createpdf', model: [pageformat: params.pageformat,
                                             entity: currentEntity,
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
                                             withTemplates: params.printtemplates == "" ? 'true' : 'false'],
                                             filename: message(code: 'groupActivity') + '_' + group.profile.fullName + '.pdf'
  }

  def searchbydate = {
    Date beginDate = params.date('beginDate', 'dd. MM. yy')
    Date endDate = params.date('endDate', 'dd. MM. yy')

    if (!beginDate || !endDate)
      render {span(class: 'italic red', message(code: 'date.insert.fromto'))}
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
        render {span(class: 'italic', message(code: 'searchMe.empty'))}
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
        render {span(class: 'italic', message(code: 'searchMe.empty'))}
        return
      }
      else {
        render template: 'searchresults', model: [groups: groupActivities]
      }
    }
    else
      render {span(class: 'italic', message(code: 'searchMe.empty'))}
  }

  def searchbyname = {
    if (!params.name) {
      render {span(class: 'italic', message(code: 'searchMe.empty'))}
      return
    }

    def users = Entity.createCriteria().list {
      eq("type", metaDataService.etGroupActivity)
      profile {
        ilike('fullName', "%" + params.name + "%")
        order('fullName','asc')
      }
      maxResults(30)
    }

    if (users.size() == 0) {
      render {span(class: 'italic', message(code: 'searchMe.empty'))}
      return
    }
    else {
      render template: 'searchresults', model: [groups: users]
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
      render {span(class: 'italic', message(code: 'searchMe.empty'))}
      return
    }
    else {
        render template: 'searchresults', model: [groups: result]
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

    Link existing = functionService.findExactLink(resource, group, metaDataService.ltResourcePlanned)

    if (!existing) {
      Link link = linkHelperService.createLink(resource, group, metaDataService.ltResourcePlanned) {link, dad ->
        dad.beginDate = group.profile.date.getTime() / 1000
        dad.endDate = calendar.getTime().getTime() / 1000
        dad.amount = params.amount
      }
    }
    else {
      existing.das.amount++
    }

    List resources = functionService.findAllByLink(null, group, metaDataService.ltResourcePlanned)
    render template: 'resources', model: [resources: resources, group: group]
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
    render template: 'resources', model: [resources: resources, group: group]
  }

  def refreshplannableresources = {
    Entity group = Entity.get(params.id)
    List facilities = functionService.findAllByLink(group, null, metaDataService.ltGroupMemberFacility)

    List plannableResources = []
    facilities.each { Entity facility ->
      // add resources linked to the facility to plannable resources
      plannableResources.addAll(functionService.findAllByLink(null, facility, metaDataService.ltResource))
      // find colony the facility is linked to and add its resources as well
      Entity colony = linkDataService.getColony(facility)
      plannableResources.addAll(functionService.findAllByLink(null, colony, metaDataService.ltResource))
    }

    // add all resources that are available everywhere
    List everywhereResources = Entity.createCriteria().list {
      eq("type", metaDataService.etResource)
      profile {
        eq("classification", "everywhere")
      }
    }
    everywhereResources?.each {
      if (!plannableResources.contains(it))
        plannableResources.add(it)
    }

    render template: 'plannableresources', model: [plannableResources: plannableResources, group: group]
  }

  def refreshplannedresources = {
    Entity group = Entity.get(params.id)

    List resources = functionService.findAllByLink(null, group, metaDataService.ltResourcePlanned)
    
    render template: 'resources', model: [resources: resources, group: group]
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
    render template: 'labels', model: [group: entity]
  }

  /*
   * removes a label from a group
   */
  def removeLabel = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [group: group]
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
      render template: 'educatorresults', model: [results: entityDataService.getAllEducators(), group: params.id]
      return
    }

    def results = Entity.createCriteria().listDistinct {
      eq('type', metaDataService.etEducator)
      user {
        eq("enabled", true)
      }
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render {span(class: 'italic', message(code: 'noResultsFound'))}
      return
    }
    else {
      def allowedEducators = functionService.findEducators(Entity.get(params.id))
      List finalResult = []
      allowedEducators.each { Entity ae ->
        if (results.contains(ae))
          finalResult.add(ae)
      }
      render template: 'educatorresults', model: [results: finalResult, group: params.id]
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
      render template: 'substituteresults', model: [results: entityDataService.getAllEducators(), group: params.id]
      return
    }

    def results = Entity.createCriteria().listDistinct {
      eq('type', metaDataService.etEducator)
      user {
        eq("enabled", true)
      }
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render {span(class: 'italic', message(code: 'noResultsFound'))}
      return
    }
    else {
      render template: 'substituteresults', model: [results: results, group: params.id]
    }
  }

  def updatecontent = {
    render template: params.type
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // swap age values if necessary
    if (params.int('ageTo') < params.int('ageFrom')) {
      def temp = params.ageTo
      params.ageTo = params.ageFrom
      params.ageFrom = temp
    }

    Date beginDate = params.date('beginDate', 'dd. MM. yy')
    Date endDate = params.date('endDate', 'dd. MM. yy')

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().list  {
      eq('type', metaDataService.etGroupActivity)
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        if (beginDate)
          ge("startDate", beginDate)
        if (endDate)
          le("endDate", endDate)
        if (params.ageFrom)
          le('ageFrom', params.ageFrom.toInteger())
        if (params.ageTo)
          ge('ageTo', params.ageTo.toInteger())
        order(params.sort, params.order)
      }
    }

    // 2. pass - filter by creator
    if (params.creator != "") {
      results = results.findAll { Entity entity ->
        Link.createCriteria().get {
          eq('source', Entity.get(params.int('creator')))
          eq('target', entity)
          eq('type', metaDataService.ltCreator)
        }
      }
    }

    // 3. filter by labels
    List thirdPass = []

    if (params.labels) {
      List labels = params.list('labels')
      results.each { Entity template ->
        template.profile.labels.each { Label label ->
          if (labels.contains(label.name)) {
            if (!thirdPass.contains(template))
              thirdPass.add(template)
          }
        }
      }
    }
    else
      thirdPass = results

    // 4. filter by theme
    List fourthPass = []

    if (params.theme != "") {
      Entity theme = Entity.get(params.theme)
      List projects = functionService.findAllByLink(null, theme, metaDataService.ltGroupMemberActivityGroup)

      projects.each { Entity project ->
        if (thirdPass.contains(project))
          fourthPass.add(project)
      }
    }
    else
      fourthPass = thirdPass

    results = fourthPass

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'groupActivity', params: params]
  }


}

class GroupActivityCommand {
  String fullName
  Date periodStart
  Date periodEnd

  /*Date mondayStart
  Date tuesdayStart
  Date wednesdayStart
  Date thursdayStart
  Date fridayStart
  Date saturdayStart
  Date sundayStart

  Boolean monday
  Boolean tuesday
  Boolean wednesday
  Boolean thursday
  Boolean friday
  Boolean saturday
  Boolean sunday
  Boolean weekdays*/

  static constraints = {
    fullName      blank: false
    periodStart   nullable: true
    periodEnd     nullable: true, validator: {val, obj ->
      return val >= obj.periodStart
    }
    /*
    // removed since 2.0.1 as this boolean check is suddenly broken, FIXME
    weekdays      validator: {val, obj ->
                    return !(!obj.monday && !obj.tuesday && !obj.wednesday && !obj.thursday && !obj.friday && !obj.saturday && !obj.sunday)
                  }*/
  }

}