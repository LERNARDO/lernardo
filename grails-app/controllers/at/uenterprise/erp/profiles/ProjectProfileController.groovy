package at.uenterprise.erp.profiles

import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.Entity
import at.openfactory.ep.Link

import java.text.SimpleDateFormat
import at.openfactory.ep.EntityType
import at.openfactory.ep.Profile
import at.openfactory.ep.EntityException
import at.uenterprise.erp.Live
import at.openfactory.ep.Asset
import at.uenterprise.erp.Evaluation
import at.openfactory.ep.LinkHelperService
import at.uenterprise.erp.Label

class ProjectProfileController {

  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService
  LinkHelperService linkHelperService

  def beforeInterceptor = [
          action:{
            params.startDate = params.startDate ? Date.parse("dd. MM. yy", params.startDate) : null
            params.endDate = params.endDate ? Date.parse("dd. MM. yy", params.endDate) : null},
            only:['save','update']
  ]

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

    EntityType etProject = metaDataService.etProject
    def projects = Entity.createCriteria().list {
      eq("type", etProject)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalProjects = Entity.countByType(etProject)

    Entity currentEntity = entityHelperService.loggedIn

    // get themes
    List themes = []
    if (currentEntity.type == metaDataService.etEducator) {
      // find all facilities the current entity is linked to as educator or lead educator
      List facilities = []
      facilities.addAll(functionService.findAllByLink(entityHelperService.loggedIn, null, metaDataService.ltWorking))
      facilities.addAll(functionService.findAllByLink(entityHelperService.loggedIn, null, metaDataService.ltLeadEducator))

      // find all themes that are linked to those facilities

      facilities.each { facility ->
        themes.addAll(functionService.findAllByLink(null, facility, metaDataService.ltThemeOfFacility))
      }
    }
    else
      themes = Entity.findAllByType(metaDataService.etTheme)

    return [projects: projects,
            totalProjects: totalProjects,
            themes: themes,
            allLabels: Label.findAllByType('template')]
  }

  def show = {
    Entity project = Entity.get(params.id)
    Entity entity = params.entity ? project : entityHelperService.loggedIn

    if (!project) {
      //flash.message = "projectProfile not found with id ${params.id}"
      flash.message = message(code: "project.idNotFound", args: [params.id])
      redirect(action: list)
    }
    else {
      // find projectTemplate of this project
      Entity template = functionService.findByLink(null, project, metaDataService.ltProjectTemplate)

      // find all units linked to the template
      List units = []
      if (template)
        units = functionService.findAllByLink(null, template, metaDataService.ltProjectUnitTemplate)

      def allFacilities = Entity.findAllByType(metaDataService.etFacility)
      // find all facilities linked to this project
      List facilities = functionService.findAllByLink(project, null, metaDataService.ltGroupMemberFacility)

      //def allClients = Entity.findAllByType(metaDataService.etClient)
      List allClientgroups = Entity.findAllByType(metaDataService.etGroupClient)
      // find all clients linked to this project
      List clients = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberClient)

      // get all educators
      def allEducators = Entity.findAllByType(metaDataService.etEducator)

      // get all parents
      def families = []
      clients.each { Entity client ->
        // get all families
        families.addAll(functionService.findAllByLink(client, null, metaDataService.ltGroupFamily))
      }
      def allParents = []
      families.each { Entity family ->
        // get all parents
        def temp = functionService.findAllByLink(null, family, metaDataService.ltGroupMemberParent)
        temp.each {
          if (!allParents.contains(it))
            allParents << it
        }
      }
      /*def allParents = Entity.findAllByType(metaDataService.etParent)*/

      // get all partners
      def allPartners = Entity.findAllByType(metaDataService.etPartner)

      // find all projectdays linked to this project
      List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)
      projectDays.sort {it.profile.date}

      // find all projectUnits linked to this project
      List projectUnits = functionService.findAllByLink(null, project, metaDataService.ltProjectUnit)

      List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

      // calculate realDuration
      int calculatedDuration = calculateDuration(projectUnits)

      // find all themes which are at the project time
      List allThemes = Entity.findAllByType(metaDataService.etTheme).findAll {it.profile.startDate <= project.profile.startDate && it.profile.endDate >= project.profile.endDate}

      List themes = functionService.findAllByLink(project, null, metaDataService.ltGroupMember)

      Entity projectDay = params.one ? projectDays.find {it.id == params.int('one')} : (projectDays[0] ?: null)

      List requiredResources = []
      requiredResources.addAll(template.profile.resources)
      // find all project units linked to the project day
      List pUnits = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

      // find all groups linked to all units
      List groups = []
      pUnits.each { Entity pUnit ->
        groups.addAll(functionService.findAllByLink(null, pUnit, metaDataService.ltProjectUnit))
      }

      // for every group activity template add its resources
      groups.each {
        requiredResources.addAll(it.profile.resources)
      }
      // for every group activity template find its activity templates and add resources as well
      groups.each {
        List temps = functionService.findAllByLink(null, it, metaDataService.ltGroupMember)
        temps.each { temp ->
          temp.profile.resources.each {
            if (!requiredResources.contains(it))
              requiredResources.add(it)
          }
        }
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

      List resources = functionService.findAllByLink(null, projectDay, metaDataService.ltResourcePlanned)

      [project: project,
              entity: entity,
              projectUnits: projectUnits,
              allGroupActivityTemplates: allGroupActivityTemplates,
              calculatedDuration: calculatedDuration,
              clients: clients,
              /*allClients: allClients,*/
              allClientGroups: allClientgroups,
              projectDays: projectDays,
              template: template,
              allFacilities: allFacilities,
              facilities: facilities,
              allEducators: allEducators,
              units: units,
              allParents: allParents,
              allPartners: allPartners,
              active: params.one ?: projectDays[0]?.id,
              day: projectDay,
              allThemes: allThemes,
              themes: themes,
              resources: resources,
              plannableResources: plannableResources,
              requiredResources: requiredResources,
              allLabels: Label.findAllByType('template')]
    }
  }

  def delete = {
    Entity project = Entity.get(params.id)
    if (project) {
      // find all project days of project
      List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

      // find all project units of all project days
      List projectUnits = []
      projectDays.each { Entity projectDay ->
        projectUnits.addAll(functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit))
      }

      // delete all links to project units and units themselves
      projectUnits.each { Entity projectUnit ->
        Link.findAllBySourceOrTarget(projectUnit, projectUnit).each {it.delete()}
        projectUnit.delete()
      }

      // delete all links to project days and project days themselves
      projectDays.each { Entity projectDay ->
        Link.findAllBySourceOrTarget(projectDay, projectDay).each {it.delete()}
        projectDay.delete()
      }

      // delete all links to project itself
      Link.findAllBySourceOrTarget(project, project).each {it.delete()}

      try {
        flash.message = message(code: "project.deleted", args: [project.profile.fullName])
        project.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "project.notDeleted", args: [project.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      //flash.message = "projectProfile not found with id ${params.id}"
      flash.message = message(code: "project.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity project = Entity.get(params.id)
    Entity entity = params.entity ? project : entityHelperService.loggedIn

    if (!project) {
      //flash.message = "projectProfile not found with id ${params.id}"
      flash.message = message(code: "project.idNotFound", args: [params.id])
      redirect action: 'list'
    }
    else {
      [project: project, entity: entity]
    }
  }

  def update = {
    Entity project = Entity.get(params.id)

    //project.profile.fullName = params.fullName
    //project.profile.description = params.description

    // update project days based on the new begin and end date
    def currentPDs = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)
    //log.info "current project days: " + currentPDs.size()

    Date tperiodStart = params.startDate
    Date tperiodEnd = params.endDate
    params.endDate.setHours(23);
    params.endDate.setMinutes(59);

    Calendar tcalendarStart = new GregorianCalendar();
    tcalendarStart.setTime(tperiodStart);

    Calendar tcalendarEnd = new GregorianCalendar();
    tcalendarEnd.setTime(tperiodEnd);

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE", new Locale("en"))

    // 1. check if every current project day is within the new date range of the project, if not delete those which aren't
    //log.info "removing days outside the new date range"
    List toDelete = []
    currentPDs.each { pd ->
      if (pd.profile.date < tcalendarStart.getTime() || pd.profile.date > tcalendarEnd.getTime()) {
        //log.info "found a projectday that is outside the new daterange"
        toDelete.add(pd)
      }
    }
    toDelete.each { pd ->
      Link.findBySourceAndType(pd, metaDataService.ltProjectMember)?.delete()
      Link.findAllBySourceOrTarget(pd, pd).each {it.delete()}
      pd.delete()
    }

    // get a new list of project days
    currentPDs = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)
    //log.info "current project days: " + currentPDs.size()

    // 2. create new project days if any
    //log.info "creating new project days"
    // loop through the date range and compare the dates day with the params
    while (tcalendarStart <= tcalendarEnd) {
      Date currentDate = tcalendarStart.getTime();

      // check if no project day exists on the current date
      boolean dayExists = false
      currentPDs.each {
        if (it.profile.date.date == currentDate.date && it.profile.date.month == currentDate.month) {
          //log.info it.profile.date.date
          //log.info it.profile.date.month
          //log.info "skipping day"
          dayExists = true
        }
      }

      if (!dayExists) {
        //log.info params.wednesday
        //log.info tdf.format(currentDate)
        if ((params.monday && (tdf.format(currentDate) == 'Monday')) ||
                (params.tuesday && (tdf.format(currentDate) == 'Tuesday')) ||
                (params.wednesday && (tdf.format(currentDate) == 'Wednesday')) ||
                (params.thursday && (tdf.format(currentDate) == 'Thursday')) ||
                (params.friday && (tdf.format(currentDate) == 'Friday')) ||
                (params.saturday && (tdf.format(currentDate) == 'Saturday')) ||
                (params.sunday && (tdf.format(currentDate) == 'Sunday'))) {
          //log.info "found matching day"

          if (tdf.format(currentDate) == 'Monday') {
            tcalendarStart.set(Calendar.HOUR_OF_DAY, params.int('mondayStartHour'))
            tcalendarStart.set(Calendar.MINUTE, params.int('mondayStartMinute'))
          }
          else if (tdf.format(currentDate) == 'Tuesday') {
            tcalendarStart.set(Calendar.HOUR_OF_DAY, params.int('tuesdayStartHour'))
            tcalendarStart.set(Calendar.MINUTE, params.int('tuesdayStartMinute'))
          }
          else if (tdf.format(currentDate) == 'Wednesday') {
            tcalendarStart.set(Calendar.HOUR_OF_DAY, params.int('wednesdayStartHour'))
            tcalendarStart.set(Calendar.MINUTE, params.int('wednesdayStartMinute'))
          }
          else if (tdf.format(currentDate) == 'Thursday') {
            tcalendarStart.set(Calendar.HOUR_OF_DAY, params.int('thursdayStartHour'))
            tcalendarStart.set(Calendar.MINUTE, params.int('thursdayStartMinute'))
          }
          else if (tdf.format(currentDate) == 'Friday') {
            tcalendarStart.set(Calendar.HOUR_OF_DAY, params.int('fridayStartHour'))
            tcalendarStart.set(Calendar.MINUTE, params.int('fridayStartMinute'))
          }
          else if (tdf.format(currentDate) == 'Saturday') {
            tcalendarStart.set(Calendar.HOUR_OF_DAY, params.int('saturdayStartHour'))
            tcalendarStart.set(Calendar.MINUTE, params.int('saturdayStartMinute'))
          }
          else if (tdf.format(currentDate) == 'Sunday') {
            tcalendarStart.set(Calendar.HOUR_OF_DAY, params.int('sundayStartHour'))
            tcalendarStart.set(Calendar.MINUTE, params.int('sundayStartMinute'))
          }

          // create project day
          EntityType etProjectDay = metaDataService.etProjectDay
          Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
            ent.profile = profileHelperService.createProfileFor(ent) as Profile
            ent.profile.date = tcalendarStart.getTime();
            ent.profile.fullName = params.fullName
            ent.profile.date = functionService.convertToUTC(ent.profile.date)
          }

          new Link(source: projectDay, target: project, type: metaDataService.ltProjectMember).save()

        }
      }

      // increment calendar
      tcalendarStart.add(Calendar.DATE, 1)
    }

    //currentPDs = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)
    //log.info "current project days: " + currentPDs.size()

    project.profile.properties = params

    if (project.profile.save() && project.save()) {
      flash.message = message(code: "project.updated", args: [project.profile.fullName])
      redirect action: 'show', id: project.id, params: [entity: project.id]
    }
    else {
      render view: 'edit', model: [project: project]
    }
  }

  def create = {
    Entity projectTemplate = Entity.get(params.id)
    return [template: projectTemplate]
  }

  def save = {ProjectCommand pc->
    Entity currentEntity = entityHelperService.loggedIn

    Entity projectTemplate = Entity.get(params.id)

    if (pc.hasErrors()) {
      render view:'create', model:[pc:pc, template: projectTemplate]
      return
    }

    // first check the number of project days is > 0
    int checkdays = 0

    Date tperiodStart = params.startDate
    Date tperiodEnd = params.endDate
    params.endDate.setHours(23);
    params.endDate.setMinutes(59);

    Calendar tcalendarStart = new GregorianCalendar();
    tcalendarStart.setTime(tperiodStart);

    Calendar tcalendarEnd = new GregorianCalendar();
    tcalendarEnd.setTime(tperiodEnd);

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE", new Locale("en"))

    while (tcalendarStart <= tcalendarEnd) {
       Date currentDate = tcalendarStart.getTime();

       if ((params.monday && (tdf.format(currentDate) == 'Monday')) ||
           (params.tuesday && (tdf.format(currentDate) == 'Tuesday')) ||
           (params.wednesday && (tdf.format(currentDate) == 'Wednesday')) ||
           (params.thursday && (tdf.format(currentDate) == 'Thursday')) ||
           (params.friday && (tdf.format(currentDate) == 'Friday')) ||
           (params.saturday && (tdf.format(currentDate) == 'Saturday')) ||
           (params.sunday && (tdf.format(currentDate) == 'Sunday'))) {
            checkdays++
         }
      tcalendarStart.add(Calendar.DATE, 1)
    }
    if (checkdays == 0) {
      flash.message = message(code: "project.noDays")
      render(view: "create", model: [template: Entity.get(params.id)])
      return
    }

    EntityType etProject = metaDataService.etProject

    try {
      Entity entity = entityHelperService.createEntity("project", etProject) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
        //ent.profile.startDate = functionService.convertToUTC(ent.profile.startDate)
        //ent.profile.endDate = functionService.convertToUTC(ent.profile.endDate)
      }
      // inherit profile picture: go through each asset of the template, find the asset of type "profile" and assign it to the new entity
      projectTemplate.assets.each { Asset asset ->
        if (asset.type == "profile") {
          new Asset(entity: entity, storage: asset.storage, type: "profile").save()
        }
      }

      flash.message = message(code: "project.created", args: [entity.profile.fullName])

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      // create link to template
      new Link(source: projectTemplate, target: entity, type: metaDataService.ltProjectTemplate).save()

      // create project days
      Date periodStart = params.startDate
      Date periodEnd = params.endDate

      Calendar calendarStart = new GregorianCalendar();
      calendarStart.setTime(periodStart);

      Calendar calendarEnd = new GregorianCalendar();
      calendarEnd.setTime(periodEnd);

      SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

      // loop through the date range and compare the dates day with the params
      while (calendarStart <= calendarEnd) {
        Date currentDate = calendarStart.getTime();

        if ((params.monday && (df.format(currentDate) == 'Monday')) ||
                (params.tuesday && (df.format(currentDate) == 'Tuesday')) ||
                (params.wednesday && (df.format(currentDate) == 'Wednesday')) ||
                (params.thursday && (df.format(currentDate) == 'Thursday')) ||
                (params.friday && (df.format(currentDate) == 'Friday')) ||
                (params.saturday && (df.format(currentDate) == 'Saturday')) ||
                (params.sunday && (df.format(currentDate) == 'Sunday'))) {

          if (df.format(currentDate) == 'Monday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('mondayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('mondayStartMinute'))
          }
          else if (df.format(currentDate) == 'Tuesday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('tuesdayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('tuesdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Wednesday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('wednesdayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('wednesdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Thursday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('thursdayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('thursdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Friday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('fridayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('fridayStartMinute'))
          }
          else if (df.format(currentDate) == 'Saturday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('saturdayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('saturdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Sunday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('sundayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('sundayStartMinute'))
          }

          // create project day
          EntityType etProjectDay = metaDataService.etProjectDay
          Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
            ent.profile = profileHelperService.createProfileFor(ent) as Profile
            ent.profile.date = calendarStart.getTime();
            ent.profile.fullName = params.fullName
            ent.profile.date = functionService.convertToUTC(ent.profile.date)
          }

          // link project day to project
          new Link(source: projectDay, target: entity, type: metaDataService.ltProjectMember).save()

        }

        // increment calendar
        calendarStart.add(Calendar.DATE, 1)
      }

      new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat das Projekt <a href="' + createLink(controller: 'projectProfile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> geplant.').save()
      redirect action: 'show', id: entity.id, params: [entity: entity.id]

    } catch (EntityException ee) {
      render(view: "create", model: [project: ee.entity])
    }

  }

  def addUnit = {
    Entity projectDay = Entity.get(params.id)
    Entity projectUnitTemplate = Entity.get(params.unit)

    Entity currentEntity = entityHelperService.loggedIn

    def project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

    // set the correct time for the new unit
        // find all units linked to this projectDay
        List units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

        // find all groups linked to all units
        List groups = []
        units.each { Entity unit ->
          groups.addAll(functionService.findAllByLink(null, unit, metaDataService.ltProjectUnit))
        }

        // calculate total duration of all these groups
        int duration = 0
        groups.each {
          duration += it.profile.realDuration
        }

        // finally update unit time
        Calendar calendar = new GregorianCalendar()

    // find all activity template groups linked to the project unit template
    groups = functionService.findAllByLink(null, projectUnitTemplate, metaDataService.ltProjectUnitMember)

    // and link each group to the project unit
    int duration2 = 0
    groups.each {
      // set duration of unit
      duration2 += it.profile.realDuration
    }

    // create a new unit and copy the properties from the unit template
    EntityType etProjectUnit = metaDataService.etProjectUnit
    Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
      ent.profile = profileHelperService.createProfileFor(ent) as Profile
      ent.profile.fullName = projectUnitTemplate.profile.fullName

      calendar.setTime(projectDay.profile.date)
      calendar.add(Calendar.MINUTE, duration)
      ent.profile.date = calendar.getTime()
      ent.profile.duration = duration2
    }

    // save creator
    new Link(source: currentEntity, target: projectUnit, type: metaDataService.ltCreator).save()

    projectDay.profile.addToUnits(projectUnit.id.toString())

    // link the new unit to the project day
    new Link(source: projectUnit, target: projectDay, type: metaDataService.ltProjectDayUnit).save()

    // and link each group to the project unit
    groups.each { Entity group ->
      new Link(source: group, target: projectUnit, type: metaDataService.ltProjectUnit).save()
    }

    // return values for the template
        // find all units linked to this projectDay
        units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

        // get all parents
        def allParents = Entity.findAllByType(metaDataService.etParent)

        // get all partners
        def allPartners = Entity.findAllByType(metaDataService.etPartner)

    render template: 'units', model: [units: units, project: project, projectDay: projectDay, entity: currentEntity, allParents: allParents, allPartners: allPartners]

  }

  def removeUnit = {
    Entity projectDay = Entity.get(params.id)
    Entity projectUnit = Entity.get(params.unit)

    // delete link
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', projectUnit)
      eq('target', projectDay)
      eq('type', metaDataService.ltProjectDayUnit)
    }
    link.delete()

    // find all activities linking to this unit and delete them
    Link.findAllByTargetAndType(projectUnit, metaDataService.ltProjectUnit).each {it.delete()}
    //List activities = links.collect {it.source}

    // delete link to creator
    Link.findByTargetAndType(projectUnit, metaDataService.ltCreator)?.delete()

    projectDay.profile.removeFromUnits(params.unit)

    // delete projectUnit
    projectUnit.delete()

    // find all project units of this project
    List units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

    render template: 'units', model: [units: units, projectDay: projectDay, entity: entityHelperService.loggedIn]
  }

  def addGroupActivityTemplate = {
    Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
    Entity projectUnit = Entity.get(params.projectUnit)
    Entity project = Entity.get(params.id)

    // check if the groupActivityTemplate isn't already linked to the projectUnit
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', groupActivityTemplate)
      eq('target', projectUnit)
      eq('type', metaDataService.ltProjectUnitMember)
    }
    if (!link)
    // link groupActivityTemplate to projectUnit
      new Link(source: groupActivityTemplate, target: projectUnit, type: metaDataService.ltProjectUnitMember).save()

    // find all project units of this project
    List projectUnits = functionService.findAllByLink(null, project, metaDataService.ltProjectUnit)

    // calculate realDuration
    int calculatedDuration = calculateDuration(projectUnits)

    render template: 'projectUnits', model: [projectUnits: projectUnits, project: project, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
  }

  def removeGroupActivityTemplate = {
    Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
    Entity projectUnit = Entity.get(params.projectUnit)
    Entity project = Entity.get(params.id)

    // delete link
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', groupActivityTemplate)
      eq('target', projectUnit)
      eq('type', metaDataService.ltProjectUnitMember)
    }
    link.delete()

    // find all projectunits of this project
    List projectUnits = functionService.findAllByLink(null, project, metaDataService.ltProjectUnit)

    // calculate realDuration
    int calculatedDuration = calculateDuration(projectUnits)

    render template: 'projectUnits', model: [projectUnits: projectUnits, project: project, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
  }

  int calculateDuration(List projectUnits) {
    // find all groupActivityTemplates linked to all projectUnits of this project
    List groupActivityTemplates = []

    projectUnits.each { Entity pu ->
      def links = functionService.findAllByLink(null, pu, metaDataService.ltProjectUnitMember)
      if (links.size() > 0)
        groupActivityTemplates.addAll(links)
    }

    def calculatedDuration = 0
    groupActivityTemplates.each {
      calculatedDuration += it.profile.realDuration
    }

    return calculatedDuration
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template: 'clients', model: [clients: breaking.results, project: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addFacility = {
    def linking = functionService.linkEntities(params.id, params.facility, metaDataService.ltGroupMemberFacility)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.target.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    render template: 'facilities', model: [facilities: linking.results2, project: linking.source, entity: entityHelperService.loggedIn]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.id, params.facility, metaDataService.ltGroupMemberFacility)
    render template: 'facilities', model: [facilities: breaking.results2, project: breaking.source, entity: entityHelperService.loggedIn]
  }

  def updateFacilityButton = {
    Entity project = Entity.get(params.id)

    List facilities = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberFacility)
    render template: 'facilitybutton', model: [facilities: facilities]
  }

  def addResource = {
    def linking = functionService.linkEntities(params.resource, params.id, metaDataService.ltProjectDayResource)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    render template: 'resources', model: [resources: linking.results, projectDay: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeResource = {
    def breaking = functionService.breakEntities(params.resource, params.id, metaDataService.ltProjectDayResource)
    render template: 'resources', model: [resources: breaking.results, projectDay: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltProjectDayEducator)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    def project = functionService.findByLink(linking.target, null, metaDataService.ltProjectMember)
    render template: 'educators', model: [educators: linking.results, project: project, projectDay: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltProjectDayEducator)
    def project = functionService.findByLink(breaking.target, null, metaDataService.ltProjectMember)
    render template: 'educators', model: [educators: breaking.results, project: project, projectDay: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addSubstitute = {
    def linking = functionService.linkEntities(params.substitute, params.id, metaDataService.ltProjectDaySubstitute)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    def project = functionService.findByLink(linking.target, null, metaDataService.ltProjectMember)
    render template: 'substitutes', model: [substitutes: linking.results, project: project, projectDay: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeSubstitute = {
    def breaking = functionService.breakEntities(params.substitute, params.id, metaDataService.ltProjectDaySubstitute)
    def project = functionService.findByLink(breaking.target, null, metaDataService.ltProjectMember)
    render template: 'substitutes', model: [substitutes: breaking.results, project: project, projectDay: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addParent = {
    def linking = functionService.linkEntities(params.parent, params.id, metaDataService.ltProjectUnitParent)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    Entity projectDay = functionService.findByLink(linking.target, null, metaDataService.ltProjectDayUnit)
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    render template: 'parents', model: [parents: linking.results, project: project, unit: linking.target, entity: entityHelperService.loggedIn, i: params.i]
  }

  def removeParent = {
    def breaking = functionService.breakEntities(params.parent, params.id, metaDataService.ltProjectUnitParent)
    Entity projectDay = functionService.findByLink(breaking.target, null, metaDataService.ltProjectDayUnit)
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    render template: 'parents', model: [parents: breaking.results, project: project, unit: breaking.target, entity: entityHelperService.loggedIn, i: params.i]
  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltProjectUnitPartner)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    Entity projectDay = functionService.findByLink(linking.target, null, metaDataService.ltProjectDayUnit)
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    render template: 'partners', model: [partners: linking.results, project: project, unit: linking.target, entity: entityHelperService.loggedIn, i: params.i]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltProjectUnitPartner)
    Entity projectDay = functionService.findByLink(breaking.target, null, metaDataService.ltProjectDayUnit)
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    render template: 'partners', model: [partners: breaking.results, project: project, unit: breaking.target, entity: entityHelperService.loggedIn, i: params.i]
  }

  def addTheme = {
    def linking = functionService.linkEntities(params.id, params.theme, metaDataService.ltGroupMember)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.target.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
    render template: 'themes', model: [themes: linking.results2, project: linking.source, entity: entityHelperService.loggedIn]
  }

  def removeTheme = {
    def breaking = functionService.breakEntities(params.id, params.theme, metaDataService.ltGroupMember)
    render template: 'themes', model: [themes: breaking.results2, project: breaking.source, entity: entityHelperService.loggedIn]
  }

  // this action takes a project and creates all activities
  def execute = {
    //render "<span class='red'>Bitte warten.. Aktivitäten werden instanziert!</span><br/>"
    Entity project = Entity.get(params.id)

    // make sure the project has clients and a facility
    /*def links = Link.findAllByTargetAndType(project,metaDataService.ltGroupMemberFacility)
    def links2 = Link.findAllByTargetAndType(project,metaDataService.ltGroupMemberClient)
    if (!links || links2) {
      redirect action: 'show', id: project.id
      return
    }*/

    // make sure each unit in each project day has activity template groups added, otherwise there
    // would be nothing to instantiate

    // 1. find all projectDays belonging to the project
    List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)
    log.info "Projekttage: " + projectDays.size()

    // 2. loop through each projectDay and find all projectUnits

    List projectUnits = []
    boolean exit = false
    projectDays.each { Entity projectDay ->
      def projectDayUnits = functionService.findAllByLink(null, it, metaDataService.ltProjectDayUnit)
      if (projectDayUnits.size() == 0) {
        render '<p class="red">Projekt konnte nicht instanziert werden, es fehlen Projekteinheiten am ' + projectDay.profile.date.format('dd. MM. yyyy') + '!</p>'
        exit = true
      }
      else {
        projectDayUnits.each {
          projectUnits << it
        }
      }
      if (exit)
        return
    }
    if (exit)
        return
    //log.info "Projekteinheiten: " + projectUnits.size()

    // now we know that every projectDay has projectUnits and templates so we continue

    // delete all current project activities that have not started yet
    List activities = functionService.findAllByLink(null, project, metaDataService.ltActProject)

    log.info "Found " + activities.size() + " existing activities"

    if (activities) {
      //render "<p>Es wurden folgende " + activities.size() + " vorhande Aktivitäten aktualisiert:</p>"
      render "<p>"+message(code: "project.activity.updated", args: [activities.size()])+"</p>"
      activities.each { Entity activity ->
        if (new Date() < activity.profile.date) {
          Link.findAllBySourceOrTarget(activity, activity).each {it.delete()}
          activity.delete()
        }
      }
    }
    else {
      //render "<p>Es wurden folgende Aktivitäten geplant:</p>"
      render "<p>"+message(code: "project.activity.scheduled")+"</p>"
    }

    // then do the big loop
    log.info "Starting big loop"

    SimpleDateFormat df = new SimpleDateFormat("dd. MM. yyyy 'um' hh:mm", new Locale("en"))

    projectDays.each { Entity pd ->
      projectUnits = functionService.findAllByLink(null, pd, metaDataService.ltProjectDayUnit)

      log.info "Projekteinheiten: " + projectUnits.size()

      // 3. loop through each projectUnit and find all activity template groups
      projectUnits.each { Entity pu ->
        List groups = functionService.findAllByLink(null, pu, metaDataService.ltProjectUnit)

        Date currentDate = pd.profile.date
        Calendar calendar = new GregorianCalendar()
        calendar.setTime(currentDate)

        // 4. find all activity templates of each group
        groups.each { Entity pg ->
          List templates = functionService.findAllByLink(null, pg, metaDataService.ltGroupMember)

          // 5. instantiate all activities from the list of templates
          templates.each {
            EntityType etActivity = metaDataService.etActivity
            Entity activity = entityHelperService.createEntity("activity", etActivity) {Entity ent ->
              ent.profile = profileHelperService.createProfileFor(ent) as Profile
              ent.profile.type = "Projekt"
              ent.profile.date = calendar.getTime()
              ent.profile.fullName = it.profile.fullName
              ent.profile.duration = it.profile.duration
            }

            // link this project activity to the project
            new Link(source: activity, target: project, type: metaDataService.ltActProject).save()

            // link facility to activity
            Entity facility = functionService.findByLink(null, project, metaDataService.ltGroupMemberFacility)
            if (facility) {
              new Link(source: facility, target: activity, type: metaDataService.ltActFacility).save()
              log.info "Facility linked to activity"
            }

            // link clients to activity
            List clients = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberClient)
            if (clients) {
              clients.each { Entity client ->
                new Link(source: client, target: activity, type: metaDataService.ltActClient).save()
                log.info "Client linked to activity"
              }
            }

            // link resources to activity
            List resources = functionService.findAllByLink(null, pd, metaDataService.ltProjectDayResource)
            if (resources) {
              resources.each { Entity res ->
                new Link(source: res, target: activity, type: metaDataService.ltResource).save()
                log.info "Resource linked to activity"
              }
            }

            // link educators to activity
            List educators = functionService.findAllByLink(null, pd, metaDataService.ltProjectDayEducator)
            if (educators) {
              educators.each { Entity edu ->
                new Link(source: edu, target: activity, type: metaDataService.ltActEducator).save()
                log.info "Educator linked to activity"
              }
            }

            // link partners to activity
            List partners = functionService.findAllByLink(null, pu, metaDataService.ltProjectUnitPartner)
            if (partners) {
              partners.each { Entity par ->
                new Link(source: par, target: activity, type: metaDataService.ltActPartner).save()
                log.info "Partner linked to activity"
              }
            }

            // link parents to activity
            List parents = functionService.findAllByLink(null, pu, metaDataService.ltProjectUnitParent)
            if (parents) {
              parents.each { Entity par ->
                new Link(source: par, target: activity, type: metaDataService.ltActParent).save()
                log.info "Parent linked to activity"
              }
            }

            log.info "Activity instantiated!"

            render '<img src="' + resource(dir:'images/icons', file: 'icon_tick.png') + '"/> Aktivität <a href="' + createLink(controller:'activity', action: 'show', id: activity.id) + '">' + activity.profile.fullName + '</a> am ' + df.format(calendar.getTime()) + '.<br/>'
            // get new time for next activity
            calendar.add(Calendar.MINUTE, activity.profile.duration)
          }

        }
      }
    }

    //render "<br/><span class='green'>Projekt wurde geplant!</span>"
    render "<br/><span class='green'>"+message(code: "project.scheduled")+"</span>"


  }

  def updateprojectday = {
    Entity project = Entity.get(params.project)
    Entity projectDay = Entity.get(params.id)

    // find all project days linked to this project
    List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)
    projectDays.sort {it.profile.date}

    // find projectTemplate of this project
    Entity template = functionService.findByLink(null, project, metaDataService.ltProjectTemplate)

    // find all units linked to the template
    List units = functionService.findAllByLink(null, template, metaDataService.ltProjectUnitTemplate)

    // get all parents
    def allParents = Entity.findAllByType(metaDataService.etParent)

    // get all educators
    def allEducators = Entity.findAllByType(metaDataService.etEducator)

    // get all plannable resources
    List facilities = functionService.findAllByLink(project, null, metaDataService.ltGroupMemberFacility)

    List requiredResources = []
      requiredResources.addAll(template.profile.resources)
      // find all project units linked to the project day
      List pUnits = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

      // find all groups linked to all units
      List groups = []
      pUnits.each { Entity pUnit ->
        groups.addAll(functionService.findAllByLink(null, pUnit, metaDataService.ltProjectUnit))
      }

      // for every group activity template add its resources
      groups.each {
        requiredResources.addAll(it.profile.resources)
      }
      // for every group activity template find its activity templates and add resources as well
      groups.each {
        List temps = functionService.findAllByLink(null, it, metaDataService.ltGroupMember)
        temps.each { temp ->
          temp.profile.resources.each {
            if (!requiredResources.contains(it))
              requiredResources.add(it)
          }
        }
      }

    List plannableResources = []
    facilities.each { Entity facility ->
      // add resources linked to the facility to plannable resources
      plannableResources.addAll(functionService.findAllByLink(null, facility, metaDataService.ltResource))
      // find colony the facility is linked to and add its resources as well
      Entity colony = functionService.findByLink(facility, null, metaDataService.ltGroupMemberFacility)
      plannableResources.addAll(functionService.findAllByLink(null, colony, metaDataService.ltResource))
    }

    List resources = functionService.findAllByLink(null, projectDay, metaDataService.ltResourcePlanned)

    render template:'projectdaynav', model:[day: projectDay,
                                         entity: entityHelperService.loggedIn,
                                         resources: resources,
                                         allEducators: allEducators,
                                         allParents: allParents,
                                         units: units,
                                         projectDays: projectDays,
                                         active: projectDay.id,
                                         project: project,
                                         plannableResources: plannableResources,
                                         requiredResources: requiredResources]
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
      render(template: 'educatorresults', model: [results: Entity.findAllByType(metaDataService.etEducator), projectDay: params.id])
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
      render(template: 'educatorresults', model: [results: results, projectDay: params.id])
    }
  }

  /*
   * retrieves all substitute educators matching the search parameter
   */
  def remoteSubstitutes = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value == "*") {
      render(template: 'substituteresults', model: [results: Entity.findAllByType(metaDataService.etEducator), projectDay: params.id])
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
      render(template: 'substituteresults', model: [results: results, projectDay: params.id])
    }
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
        //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
        render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
      render template: 'clients', model: [clients: linking.results, project: linking.target, entity: entityHelperService.loggedIn]
    }
    // if the entity is a client group get all clients and add them
    else if (entity.type.id == metaDataService.etGroupClient.id) {
      // find all clients of the group
      List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)

      clients.each {
        def linking = functionService.linkEntities(it.id, params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
          render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
      }

      Entity project = Entity.get(params.id)
      List clients2 = functionService.findAllByLink(null, activitygroup, metaDataService.ltGroupMemberClient)
      render template: 'clients', model: [clients: clients2, project: project, entity: entityHelperService.loggedIn]
    }

  }

  def listevaluations = {
    Entity project = Entity.get(params.id)

    // find all project days of the project
    List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

    // find all project units of all project days
    List projectUnits = []
    projectDays.each { Entity pd ->
      projectUnits.addAll(functionService.findAllByLink(null, pd, metaDataService.ltProjectDayUnit))
    }

    // find all evaluations linked to the project units
    List evaluations = []
    projectUnits.each { Entity pu ->
      evaluations.addAll(Evaluation.findAllByLinkedTo(pu))
    }

    return [evaluations: evaluations, entity: project]
  }

   def moveUp = {
    Entity projectDay = Entity.get(params.projectDay)
    if (projectDay.profile.units.indexOf(params.id) > 0) {
      int i = projectDay.profile.units.indexOf(params.id)

      // get both units
      Entity unit = Entity.get(projectDay.profile.units[i])
      Entity unit2 = Entity.get(projectDay.profile.units[i-1])

      unit.profile.date = unit2.profile.date

      Calendar calendar = new GregorianCalendar()
      calendar.setTime(unit2.profile.date)
      calendar.add(Calendar.MINUTE, unit.profile.duration)
      unit2.profile.date = calendar.getTime()

      use(Collections){ projectDay.profile.units.swap(i, i - 1) }
    }
    List units = []
    projectDay.profile.units.each {
      units.add(Entity.get(it.toInteger()))
    }

    // find project
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

     // find all clients linked to this project
    List clients = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberClient)

    // get all parents
    def families = []
    clients.each { Entity client ->
      // get all families
      families.addAll(functionService.findAllByLink(client, null, metaDataService.ltGroupFamily))
    }
    def allParents = []
    families.each { Entity family ->
      // get all parents
      def temp = functionService.findAllByLink(null, family, metaDataService.ltGroupMemberParent)
      temp.each {
        if (!allParents.contains(it))
          allParents << it
      }
    }

    // get all partners
    def allPartners = Entity.findAllByType(metaDataService.etPartner)

    render template: 'units', model: [projectDay: projectDay, units: units, entity: entityHelperService.loggedIn, project: project, allParents: allParents, allPartners: allPartners]
  }

  def moveDown = {
    Entity projectDay = Entity.get(params.projectDay)
    if (projectDay.profile.units.indexOf(params.id) < projectDay.profile.units.size() - 1) {
      int i = projectDay.profile.units.indexOf(params.id)

      // get both units
      Entity unit = Entity.get(projectDay.profile.units[i+1])
      Entity unit2 = Entity.get(projectDay.profile.units[i])

      unit.profile.date = unit2.profile.date

      Calendar calendar = new GregorianCalendar()
      calendar.setTime(unit2.profile.date)
      calendar.add(Calendar.MINUTE, unit.profile.duration)
      unit2.profile.date = calendar.getTime()

      use(Collections){ projectDay.profile.units.swap(i, i + 1) }
    }
    List units = []
    projectDay.profile.units.each {
      units.add(Entity.get(it.toInteger()))
    }

    // find project
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

     // find all clients linked to this project
    List clients = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberClient)

    // get all parents
    def families = []
    clients.each { Entity client ->
      // get all families
      families.addAll(functionService.findAllByLink(client, null, metaDataService.ltGroupFamily))
    }
    def allParents = []
    families.each { Entity family ->
      // get all parents
      def temp = functionService.findAllByLink(null, family, metaDataService.ltGroupMemberParent)
      temp.each {
        if (!allParents.contains(it))
          allParents << it
      }
    }

    // get all partners
    def allPartners = Entity.findAllByType(metaDataService.etPartner)

    render template: 'units', model: [projectDay: projectDay, units: units, entity: entityHelperService.loggedIn, project: project, allParents: allParents, allPartners: allPartners]
  }

  def searchbydate = {
    def beginDate = null
    def endDate = null
    if (params.beginDate)
      beginDate = Date.parse("dd. MM. yy", params.beginDate)
    if (params.endDate)
        endDate = Date.parse("dd. MM. yy", params.endDate)
    if (!beginDate || !endDate)
      //render '<span class="red italic">Bitte Von und Bis Datum eingeben</span>'
      render '<span class="red italic">' + message(code: "date.insert.fromto") +  '</span>'
    else {
      List projects = Entity.createCriteria().list {
        eq("type", metaDataService.etProject)
        profile {
          ge("startDate", beginDate)
          le("endDate", endDate)
        }
      maxResults(15)
      }

      if (projects.size() == 0) {
        render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
        return
      }
      else {
        render(template: '/overview/searchresults', model: [searchList: projects])
      }
    }
  }

  def searchbytheme = {
    Entity theme = Entity.get(params.theme)

    if (theme) {
      // find all projects that are linked to this theme
      List projects = functionService.findAllByLink(null, theme, metaDataService.ltGroupMember)
      if (projects.size() == 0) {
        render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
        return
      }
      else {
        render(template: '/overview/searchresults', model: [searchList: projects])
      }
    }
    else
      render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
  }

  def searchbylabel = {
    List projects = Entity.findAllByType(metaDataService.etProject)
    List result = []
    List labels = params.list('labels')
    projects.each { Entity project ->
      project.profile.labels.each { Label label ->
        if (labels.contains(label.name)) {
          if (!result.contains(project))
            result.add(project)
        }
      }
    }

    if (result.size() == 0) {
      render '<span class="italic">' + message(code: "searchMe.empty") +  '</span>'
      return
    }
    else {
        render(template: '/overview/searchresults', model: [searchList: result])
    }
  }

  def planresource = {
    Entity projectDay = Entity.get(params.id)
    Entity resource = Entity.get(params.resource)
    render template: 'planresource', model: [projectDay: projectDay, resource: resource, i: params.i, resourceFree: params.int('resourceFree')]
  }

  def planresourcenow = {
    Entity projectDay = Entity.get(params.id)
    Entity resource = Entity.get(params.resource)

    Calendar calendar = new GregorianCalendar()
    calendar.setTime(projectDay.profile.date)

    // get all project units of a project day and calculate their duration sum
    List units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)
    int duration = 0
    units.each {
      duration += it.profile.duration
    }

    calendar.add(Calendar.MINUTE, duration)

    // make sure no resource is planned if the duration is 0 (which means no project unit has been set yet)
    if (duration > 0) {
      Link link = linkHelperService.createLink(resource, projectDay, metaDataService.ltResourcePlanned) {link, dad ->
        dad.beginDate = projectDay.profile.date.getTime() / 1000
        dad.endDate = calendar.getTime().getTime() / 1000
        dad.amount = params.amount
      }
    }
    else {
      render '<span class="italic gray">Es müssen erst Projekteinheiten geplant werden bevor Ressourcen geplant werden können!</span><br/>'
    }

    List resources = functionService.findAllByLink(null, projectDay, metaDataService.ltResourcePlanned)
    render template: 'resources', model: [resources: resources, entity: entityHelperService.loggedIn, projectDay: projectDay]
  }

  def unplanresource = {
    Entity projectDay = Entity.get(params.id)
    Entity resource = Entity.get(params.resource)

    def link = Link.createCriteria().get {
      eq('source', resource)
      eq('target', projectDay)
      eq('type', metaDataService.ltResourcePlanned)
    }
    if (link) {
      link.delete()
    }

    List resources = functionService.findAllByLink(null, projectDay, metaDataService.ltResourcePlanned)
    render template: 'resources', model: [resources: resources, entity: entityHelperService.loggedIn, projectDay: projectDay]
  }

  def refreshplannableresources = {
    Entity projectDay = Entity.get(params.id)
    // get project of projectDay
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    List facilities = functionService.findAllByLink(project, null, metaDataService.ltGroupMemberFacility)

    List plannableResources = []
    facilities.each { Entity facility ->
      // add resources linked to the facility to plannable resources
      plannableResources.addAll(functionService.findAllByLink(null, facility, metaDataService.ltResource))
      // find colony the facility is linked to and add its resources as well
      Entity colony = functionService.findByLink(facility, null, metaDataService.ltGroupMemberFacility)
      plannableResources.addAll(functionService.findAllByLink(null, colony, metaDataService.ltResource))
    }

    render template: 'plannableresources', model: [plannableResources: plannableResources, projectDay: projectDay]
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
    render template: 'labels', model: [project: entity, entity: entityHelperService.loggedIn]
  }

  /*
   * removes a label from a group
   */
  def removeLabel = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [project: group, entity: entityHelperService.loggedIn]
  }

}

class ProjectCommand {
  String fullName
  Date startDate
  Date endDate
  Boolean monday
  Boolean tuesday
  Boolean wednesday
  Boolean thursday
  Boolean friday
  Boolean saturday
  Boolean sunday
  Boolean weekdays

  String mondayStartHour
  String tuesdayStartHour
  String wednesdayStartHour
  String thursdayStartHour
  String fridayStartHour
  String saturdayStartHour
  String sundayStartHour

  String mondayStartMinute
  String tuesdayStartMinute
  String wednesdayStartMinute
  String thursdayStartMinute
  String fridayStartMinute
  String saturdayStartMinute
  String sundayStartMinute

  static constraints = {
    fullName(blank: false)
    startDate(nullable: false)
    endDate(nullable: false, validator: {ed, pc ->
      return ed > pc.startDate
    })
    weekdays(validator: {wd, pc ->
      return !(!pc.monday && !pc.tuesday && !pc.wednesday && !pc.thursday && !pc.friday && !pc.saturday && !pc.sunday)})
  }

}