package lernardo

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import standard.MetaDataService
import at.openfactory.ep.Profile
import at.openfactory.ep.Link
import java.text.SimpleDateFormat
import standard.FunctionService
import at.openfactory.ep.EntityException

class ProjectProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService

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

    def c = Entity.createCriteria()
    def projects = c.list {
      eq("type", metaDataService.etProject)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [projectList: projects,
            projectTotal: Entity.countByType(metaDataService.etProject)]
  }

  def show = {
    Entity project = Entity.get(params.id)
    Entity entity = params.entity ? project : entityHelperService.loggedIn

    if (!project) {
      flash.message = "projectProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      // find projectTemplate of this project
      Entity template = functionService.findByLink(null, project, metaDataService.ltProjectTemplate)

      // find all units linked to the template
      List units = functionService.findAllByLink(null, template, metaDataService.ltProjectUnitTemplate)

      def allFacilities = Entity.findAllByType(metaDataService.etFacility)
      // find all facilities linked to this project
      List facilities = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberFacility)

      //def allClients = Entity.findAllByType(metaDataService.etClient)
      List allClientgroups = Entity.findAllByType(metaDataService.etGroupClient)
      // find all clients linked to this project
      List clients = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberClient)

      // get all resources
      def allResources = Entity.findAllByType(metaDataService.etResource)

      // get all educators
      def allEducators = Entity.findAllByType(metaDataService.etEducator)

      // get all parents
      def allParents = Entity.findAllByType(metaDataService.etParent)

      // get all partners
      def allPartners = Entity.findAllByType(metaDataService.etPartner)

      // find all projectdays linked to this project
      List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

      // find all projectUnits linked to this project
      List projectUnits = functionService.findAllByLink(null, project, metaDataService.ltProjectUnit)

      List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

      // calculate realDuration
      Integer calculatedDuration = calculateDuration(projectUnits)

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
              allResources: allResources,
              allEducators: allEducators,
              units: units,
              allParents: allParents,
              allPartners: allPartners,
              active: projectDays[0].id,
              day: projectDays[0]]
    }
  }

  def del = {
    Entity project = Entity.get(params.id)
    if (project) {
      // delete all links
      Link.findAllBySourceOrTarget(project, project).each {it.delete()}
      Event.findAllByEntity(project).each {it.delete()}

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
      flash.message = "projectProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity project = Entity.get(params.id)

    if (!project) {
      flash.message = "projectProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      [project: project]
    }
  }

  def update = {
    Entity project = Entity.get(params.id)

    project.profile.properties = params

    if (!project.hasErrors() && project.save()) {
      flash.message = message(code: "project.updated", args: [project.profile.fullName])
      redirect action: 'show', id: project.id
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

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE")

    while (tcalendarStart <= tcalendarEnd) {
       Date currentDate = tcalendarStart.getTime();

       if ((params.monday && (tdf.format(currentDate) == 'Montag' || tdf.format(currentDate) == 'Monday')) ||
           (params.tuesday && (tdf.format(currentDate) == 'Dienstag' || tdf.format(currentDate) == 'Tuesday')) ||
           (params.wednesday && (tdf.format(currentDate) == 'Mittwoch' || tdf.format(currentDate) == 'Wednesday')) ||
           (params.thursday && (tdf.format(currentDate) == 'Donnerstag' || tdf.format(currentDate) == 'Thursday')) ||
           (params.friday && (tdf.format(currentDate) == 'Freitag' || tdf.format(currentDate) == 'Friday')) ||
           (params.saturday && (tdf.format(currentDate) == 'Samstag' || tdf.format(currentDate) == 'Saturday')) ||
           (params.sunday && (tdf.format(currentDate) == 'Sonntag' || tdf.format(currentDate) == 'Sunday'))) {
            checkdays++
         }
      tcalendarStart.add(Calendar.DATE, 1)
    }
    if (checkdays == 0) {
      flash.message = 'Es gibt keine Tage in dem gewählten Zeitraum!'
      render(view: "create", model: [template: Entity.get(params.id)])
      return
    }

    EntityType etProject = metaDataService.etProject

    try {
      Entity entity = entityHelperService.createEntity("project", etProject) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }
      flash.message = message(code: "project.created", args: [entity.profile.fullName])

      // create link to template
      new Link(source: projectTemplate, target: entity, type: metaDataService.ltProjectTemplate).save()

      // create project days
      Date periodStart = params.startDate
      Date periodEnd = params.endDate

      Calendar calendarStart = new GregorianCalendar();
      calendarStart.setTime(periodStart);

      Calendar calendarEnd = new GregorianCalendar();
      calendarEnd.setTime(periodEnd);

      SimpleDateFormat df = new SimpleDateFormat("EEEE")

      // loop through the date range and compare the dates day with the params
      while (calendarStart <= calendarEnd) {
        Date currentDate = calendarStart.getTime();

        if ((params.monday && (df.format(currentDate) == 'Montag' || df.format(currentDate) == 'Monday')) ||
                (params.tuesday && (df.format(currentDate) == 'Dienstag' || df.format(currentDate) == 'Tuesday')) ||
                (params.wednesday && (df.format(currentDate) == 'Mittwoch' || df.format(currentDate) == 'Wednesday')) ||
                (params.thursday && (df.format(currentDate) == 'Donnerstag' || df.format(currentDate) == 'Thursday')) ||
                (params.friday && (df.format(currentDate) == 'Freitag' || df.format(currentDate) == 'Friday')) ||
                (params.saturday && (df.format(currentDate) == 'Samstag' || df.format(currentDate) == 'Saturday')) ||
                (params.sunday && (df.format(currentDate) == 'Sonntag' || df.format(currentDate) == 'Sunday'))) {

          if (df.format(currentDate) == 'Montag' || df.format(currentDate) == 'Monday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('mondayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('mondayStartMinute'))
          }
          else if (df.format(currentDate) == 'Dienstag' || df.format(currentDate) == 'Tuesday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('tuesdayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('tuesdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Mittwoch' || df.format(currentDate) == 'Wednesday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('wednesdayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('wednesdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Donnerstag' || df.format(currentDate) == 'Thursday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('thursdayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('thursdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Freitag' || df.format(currentDate) == 'Friday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('fridayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('fridayStartMinute'))
          }
          else if (df.format(currentDate) == 'Samstag' || df.format(currentDate) == 'Saturday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('saturdayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('saturdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Sonntag' || df.format(currentDate) == 'Sunday') {
            calendarStart.set(Calendar.HOUR_OF_DAY, params.int('sundayStartHour'))
            calendarStart.set(Calendar.MINUTE, params.int('sundayStartMinute'))
          }

          // create project day
          EntityType etProjectDay = metaDataService.etProjectDay
          Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
            ent.profile = profileHelperService.createProfileFor(ent) as Profile
            ent.profile.date = calendarStart.getTime();
            ent.profile.fullName = params.fullName
          }

          new Link(source: projectDay, target: entity, type: metaDataService.ltProjectMember).save()

        }

        // increment calendar
        calendarStart.add(Calendar.DATE, 1)
      }

      redirect action: 'show', id: entity.id

    } catch (EntityException ee) {

      render(view: "create", model: [project: ee.entity])
      return
    }

  }

  def addUnit = {
    Entity projectDay = Entity.get(params.id)
    Entity projectUnitTemplate = Entity.get(params.unit)

    // set the correct time for the new unit
        // find all units linked to this projectDay
        List units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

        // find all groups linked to all units
        List groups = []
        units.each {
          groups.addAll(functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnit))
        }

        // calculate total duration of all these groups
        Integer duration = 0
        groups.each {
          duration += it.profile.realDuration
        }

        // finally update unit time
        Calendar calendar = new GregorianCalendar()

    // find all activity template groups linked to the project unit template
    groups = functionService.findAllByLink(null, projectUnitTemplate, metaDataService.ltProjectUnitMember)

    // and link each group to the project unit
    Integer duration2 = 0
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

    // link the new unit to the project day
    new Link(source: projectUnit, target: projectDay, type: metaDataService.ltProjectDayUnit).save()

    // and link each group to the project unit
    groups.each {
      new Link(source: it as Entity, target: projectUnit, type: metaDataService.ltProjectUnit).save()
    }

    // return values for the template
        // find all units linked to this projectDay
        units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

        // get all parents
        def allParents = Entity.findAllByType(metaDataService.etParent)

        // get all partners
        def allPartners = Entity.findAllByType(metaDataService.etPartner)

    render template: 'units', model: [units: units, projectDay: projectDay, entity: entityHelperService.loggedIn, allParents: allParents, allPartners: allPartners]

  }

  def removeUnit = {
    Entity projectDay = Entity.get(params.id)

    // delete link
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.unit))
      eq('target', projectDay)
      eq('type', metaDataService.ltProjectDayUnit)
    }
    link.delete()

    // find all activities linking to this unit
    def links = Link.findAllByTargetAndType(Entity.get(params.unit), metaDataService.ltProjectUnit)
    //List activities = links.collect {it.source}

    // delete all links to the unit
    links.each {
      it.delete()
    }

    // delete projectUnit
    Entity.get(params.unit).delete()

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
    Integer calculatedDuration = calculateDuration(projectUnits)

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
    Integer calculatedDuration = calculateDuration(projectUnits)

    render template: 'projectUnits', model: [projectUnits: projectUnits, project: project, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
  }

  Integer calculateDuration(List projectUnits) {
    // find all groupActivityTemplates linked to all projectUnits of this project
    List groupActivityTemplates = []

    projectUnits.each {
      def links = Link.findAllByTargetAndType(it as Entity, metaDataService.ltProjectUnitMember)
      if (links.size > 0)
        groupActivityTemplates << links.collect { bla -> bla.source}
    }

    def calculatedDuration = 0
    groupActivityTemplates.each {
      calculatedDuration += it.profile.realDuration
    }

    return calculatedDuration
  }

/*  def addClient = {
    def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'clients', model: [clients: linking.results, project: linking.target, entity: entityHelperService.loggedIn]
  }*/
  
  def addClientGroup = {
    // get client group
    Entity clientgroup = Entity.get(params.clientgroup)
    // get all clients linked to this group
    List clients = functionService.findAllByLink(null, clientgroup, metaDataService.ltGroupMemberClient)

    // link them to the activity group
    clients.each {
      def linking = functionService.linkEntities(it.id as String, params.id, metaDataService.ltGroupMemberClient)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    }

    Entity project = Entity.get(params.id)

    List clients2 = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberClient)

    render template: 'clients', model: [clients: clients2, project: project, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template: 'clients', model: [clients: breaking.results, project: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addFacility = {
    def linking = functionService.linkEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'facilities', model: [facilities: linking.results, project: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.facility, params.id, metaDataService.ltGroupMemberFacility)
    render template: 'facilities', model: [facilities: breaking.results, project: breaking.target, entity: entityHelperService.loggedIn]
  }

  def updateFacilityButton = {
    Entity project = Entity.get(params.id)

    List facilities = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberFacility)
    render template: 'facilitybutton', model: [facilities: facilities]
  }

  def addResource = {
    def linking = functionService.linkEntities(params.resource, params.id, metaDataService.ltProjectDayResource)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'resources', model: [resources: linking.results, projectDay: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeResource = {
    def breaking = functionService.breakEntities(params.resource, params.id, metaDataService.ltProjectDayResource)
    render template: 'resources', model: [resources: breaking.results, projectDay: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltProjectDayEducator)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'educators', model: [educators: linking.results, projectDay: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltProjectDayEducator)
    render template: 'educators', model: [educators: breaking.results, projectDay: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addSubstitute = {
    def linking = functionService.linkEntities(params.substitute, params.id, metaDataService.ltProjectDaySubstitute)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'substitutes', model: [substitutes: linking.results, projectDay: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeSubstitute = {
    def breaking = functionService.breakEntities(params.substitute, params.id, metaDataService.ltProjectDaySubstitute)
    render template: 'substitutes', model: [substitutes: breaking.results, projectDay: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addParent = {
    def linking = functionService.linkEntities(params.parent, params.id, metaDataService.ltProjectUnitParent)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'parents', model: [parents: linking.results, unit: linking.target, entity: entityHelperService.loggedIn, i: params.i]
  }

  def removeParent = {
    def breaking = functionService.breakEntities(params.parent, params.id, metaDataService.ltProjectUnitParent)
    render template: 'parents', model: [parents: breaking.results, unit: breaking.target, entity: entityHelperService.loggedIn, i: params.i]
  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltProjectUnitPartner)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'partners', model: [partners: linking.results, unit: linking.target, entity: entityHelperService.loggedIn, i: params.i]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltProjectUnitPartner)
    render template: 'partners', model: [partners: breaking.results, unit: breaking.target, entity: entityHelperService.loggedIn, i: params.i]
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
    projectDays.each {
      def links = Link.findAllByTargetAndType(it as Entity, metaDataService.ltProjectDayUnit)
      if (links.size() == 0) {
        render '<p class="red">Projekt konnte nicht instanziert werden, es fehlen Projekteinheiten am ' + it.profile.date.format('dd. MM. yyyy') + '!</p>'
        exit = true
      }
      else {
        links.each {
          projectUnits << it.source
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
      render "<p>Es wurden folgende " + activities.size() + " vorhande Aktivitäten aktualisiert:</p>"
      activities.each {
        if (new Date() < it.profile.date) {
          def links = Link.findAllBySourceOrTarget(it as Entity, it as Entity)
          links.each {it.delete()}
          it.delete()
        }
      }
    }
    else {
      render "<p>Es wurden folgende Aktivitäten geplant:</p>"
    }

    // then do the big loop
    log.info "Starting big loop"

    SimpleDateFormat df = new SimpleDateFormat("dd. MM. yyyy 'um' hh:mm")

    projectDays.each { pd ->
      projectUnits = functionService.findAllByLink(null, pd as Entity, metaDataService.ltProjectDayUnit)

      log.info "Projekteinheiten: " + projectUnits.size()

      // 3. loop through each projectUnit and find all activity template groups
      projectUnits.each { pu ->
        List groups = functionService.findAllByLink(null, pu as Entity, metaDataService.ltProjectUnit)

        Date currentDate = pd.profile.date
        Calendar calendar = new GregorianCalendar()
        calendar.setTime(currentDate)

        // 4. find all activity templates of each group
        groups.each { pg ->
          List templates = functionService.findAllByLink(null, pg as Entity, metaDataService.ltGroupMember)

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
            def link = Link.findByTargetAndType(project, metaDataService.ltGroupMemberFacility)
            if (link) {
              Entity facility = link.source
              new Link(source: facility, target: activity, type: metaDataService.ltActFacility).save()
              log.info "Facility linked to activity"
            }

            // link clients to activity
            List clients = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberClient)
            if (clients) {
              clients.each {
                new Link(source: it as Entity, target: activity, type: metaDataService.ltActClient).save()
                log.info "Client linked to activity"
              }
            }

            // link resources to activity
            List resources = functionService.findAllByLink(null, pd as Entity, metaDataService.ltProjectDayResource)
            if (resources) {
              resources.each {
                new Link(source: it as Entity, target: activity, type: metaDataService.ltResource).save()
                log.info "Resource linked to activity"
              }
            }

            // link educators to activity
            List educators = functionService.findAllByLink(null, pd as Entity, metaDataService.ltProjectDayEducator)
            if (educators) {
              educators.each {
                new Link(source: it as Entity, target: activity, type: metaDataService.ltActEducator).save()
                log.info "Educator linked to activity"
              }
            }

            // link partners to activity
            List partners = functionService.findAllByLink(null, pu as Entity, metaDataService.ltProjectUnitPartner)
            if (partners) {
              partners.each {
                new Link(source: it as Entity, target: activity, type: metaDataService.ltActPartner).save()
                log.info "Partner linked to activity"
              }
            }

            // link parents to activity
            List parents = functionService.findAllByLink(null, pu as Entity, metaDataService.ltProjectUnitParent)
            if (parents) {
              parents.each {
                new Link(source: it as Entity, target: activity, type: metaDataService.ltActParent).save()
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

    render "<br/><span class='green'>Projekt wurde geplant!</span>"

  }

  def updateprojectday = {
    Entity project = Entity.get(params.project)
    Entity projectDay = Entity.get(params.id)

    // find all project days linked to this project
    List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

    // find projectTemplate of this project
    Entity template = functionService.findByLink(null, project, metaDataService.ltProjectTemplate)

    // find all units linked to the template
    List units = functionService.findAllByLink(null, template, metaDataService.ltProjectUnitTemplate)

    // get all parents
    def allParents = Entity.findAllByType(metaDataService.etParent)

    // get all resources
    def allResources = Entity.findAllByType(metaDataService.etResource)

    // get all educators
    def allEducators = Entity.findAllByType(metaDataService.etEducator)

    render template:'projectdaynav', model:[day: projectDay,
                                         entity: entityHelperService.loggedIn,
                                         allResources: allResources,
                                         allEducators: allEducators,
                                         allParents: allParents,
                                         units: units,
                                         projectDays: projectDays,
                                         active: projectDay.id,
                                         project: project]
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
      render '<span class="italic">Keine Ergebnisse gefunden!</span>'
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
      render '<span class="italic">Keine Ergebnisse gefunden!</span>'
      return
    }
    else {
      render(template: 'substituteresults', model: [results: results, projectDay: params.id])
    }
  }

}

/*
* command object to handle validation of the project
*/
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


