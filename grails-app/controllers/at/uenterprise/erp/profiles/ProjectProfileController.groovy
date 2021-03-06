package at.uenterprise.erp.profiles

import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Link

import java.text.SimpleDateFormat
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.base.EntityException
import at.uenterprise.erp.Live
import at.uenterprise.erp.base.Asset
import at.uenterprise.erp.Evaluation
import at.uenterprise.erp.base.LinkHelperService
import at.uenterprise.erp.Label
import at.uenterprise.erp.EVENT_TYPE
import at.uenterprise.erp.LinkDataService
import at.uenterprise.erp.EntityDataService

class ProjectProfileController {

  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService
  LinkHelperService linkHelperService
  LinkDataService linkDataService
  EntityDataService entityDataService

  def beforeInterceptor = [
          action:{
            params.mondayStart = params.date('mondayStart', 'HH:mm')
            params.tuesdayStart = params.date('tuesdayStart', 'HH:mm')
            params.wednesdayStart = params.date('wednesdayStart', 'HH:mm')
            params.thursdayStart = params.date('thursdayStart', 'HH:mm')
            params.fridayStart = params.date('fridayStart', 'HH:mm')
            params.saturdayStart = params.date('saturdayStart', 'HH:mm')
            params.sundayStart = params.date('sundayStart', 'HH:mm')

            params.mondayEnd = params.date('mondayEnd', 'HH:mm')
            params.tuesdayEnd = params.date('tuesdayEnd', 'HH:mm')
            params.wednesdayEnd = params.date('wednesdayEnd', 'HH:mm')
            params.thursdayEnd = params.date('thursdayEnd', 'HH:mm')
            params.fridayEnd = params.date('fridayEnd', 'HH:mm')
            params.saturdayEnd = params.date('saturdayEnd', 'HH:mm')
            params.sundayEnd = params.date('sundayEnd', 'HH:mm')

            params.startDate = params.date('startDate', 'dd. MM. yy')
            params.endDate = params.date('endDate', 'dd. MM. yy')},
            only:['save','update']
  ]

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
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking))
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator))

      // find all themes that are linked to those facilities

      facilities.each { Entity facility ->
        themes.addAll(functionService.findAllByLink(null, facility, metaDataService.ltThemeOfFacility))
      }
    }
    else
      themes = Entity.findAllByType(metaDataService.etTheme)

    return [projects: projects,
            totalProjects: totalProjects,
            themes: themes,
            allLabels: functionService.getLabels()]
  }

  def show = {
    Entity project = Entity.get(params.id)

    if (!project) {
      flash.message = message(code: "object.notFound", args: [message(code: "project")])
      redirect(action: list)
    }
    else {
      // find projectTemplate of this project
      Entity template = functionService.findByLink(null, project, metaDataService.ltProjectTemplate)
      List facilities = functionService.findAllByLink(project, null, metaDataService.ltGroupMemberFacility)

      [project: project, template: template, allLabels: functionService.getLabels(), facilities: facilities, one: params.one ?: null]
    }
  }

    def management = {
        Entity project = Entity.get(params.id)

        List responsibles = functionService.findAllByLink(null, project, metaDataService.ltResponsible)

        // find all themes which are at the project time
        List allThemes = Entity.findAllByType(metaDataService.etTheme).findAll {it.profile.startDate <= project.profile.startDate && it.profile.endDate >= project.profile.endDate}

        List themes = functionService.findAllByLink(project, null, metaDataService.ltGroupMember)

        def allFacilities = entityDataService.getAllFacilities()
        // find all facilities linked to this project
        List facilities = functionService.findAllByLink(project, null, metaDataService.ltGroupMemberFacility)

        List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

        // find all clients linked to any project day
        List clients = []

        projectDays.each { Entity pd ->
            List pdclients = functionService.findAllByLink(null, pd, metaDataService.ltGroupMemberClient)
            pdclients?.each { pdclient ->
                if (!clients.contains(pdclient))
                    clients.add(pdclient)
            }
        }
        clients.sort {it.profile.firstName}

        // find all educators linked to any project day
        List educators = []

        projectDays.each { Entity pd ->
            List pdeducators = functionService.findAllByLink(null, pd, metaDataService.ltProjectDayEducator)
            pdeducators?.each { pdeducator ->
                if (!educators.contains(pdeducator))
                    educators.add(pdeducator)
            }
        }

        render template: "management", model: [project: project, responsibles: responsibles,
                allThemes: allThemes,
                themes: themes,
                allFacilities: allFacilities,
                facilities: facilities,
                clients: clients,
                educators: educators]
    }

    def projectdays = {
        Entity project = Entity.get(params.id)

        // get number of project days
        def projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember).size()

        render template: "projectdays", model: [projectDays: projectDays, project: project, day: params.day]
    }

  def delete = {
    Entity project = Entity.get(params.id)
    if (project) {

      // find all project days of project
      List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

      // find all project units of all project days
      List projectUnits = []
      projectDays?.each { Entity projectDay ->
        projectUnits.addAll(functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit))
      }

      // delete all links to project units and units themselves
      projectUnits?.each { Entity projectUnit ->
        Link.findAllBySourceOrTarget(projectUnit, projectUnit).each {it.delete()}
        projectUnit.delete()
      }

      // delete all links to project days and project days themselves
      projectDays?.each { Entity projectDay ->
        Link.findAllBySourceOrTarget(projectDay, projectDay).each {it.delete()}
        projectDay.delete()
      }

      functionService.deleteReferences(project)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "project"), project.profile])
        project.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "project"), project.profile])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "project")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity project = Entity.get(params.id)
    Entity entity = params.entity ? project : entityHelperService.loggedIn

    if (!project) {
      flash.message = message(code: "object.notFound", args: [message(code: "project")])
      redirect action: 'list'
    }
    else {
      [project: project, entity: entity]
    }
  }

  def update = {
    Entity project = Entity.get(params.id)

    //project.profile.properties = params
    // FIXME: manually defining properties to be updated, above code won't work for some weird reason
    project.profile.fullName = params.fullName
    project.profile.description = params.description
    project.profile.educationalObjectiveText = params.educationalObjectiveText
    project.profile.status = params.status

    if (project.profile.save() && project.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "project"), project.profile])
      redirect action: 'show', id: project.id
    }
    else {
      println project.errors
      render view: 'edit', model: [project: project]
    }
  }

  def shift = {
    Entity project = Entity.get(params.id)

    if (!project) {
      flash.message = message(code: "object.notFound", args: [message(code: "project")])
      redirect action: 'list'
    }
    else {
      [project: project]
    }
  }

  def shiftNow = {
    Entity project = Entity.get(params.id)

    Calendar calendar = new GregorianCalendar()

    calendar.setTime(project.profile.startDate)
    calendar.add(Calendar.DATE, params.int('weeks') * 7)
    project.profile.startDate = calendar.getTime()

    calendar.setTime(project.profile.endDate)
    calendar.add(Calendar.DATE, params.int('weeks') * 7)
    project.profile.endDate = calendar.getTime()

    project.save()

    // get project days
    def projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

    projectDays?.each { Entity projectDay ->
      calendar.setTime(projectDay.profile.date)
      calendar.add(Calendar.DATE, params.int('weeks') * 7)
      projectDay.profile.date = calendar.getTime()
      projectDay.save()
    }

    flash.message = message(code: "object.updated", args: [message(code: "project"), project.profile])
    redirect action: 'show', id: project.id
  }

  def create = {
      Entity project = Entity.get(params.id)

      int days = 0
      if (project) {
          days = Link.countByTargetAndType(project, metaDataService.ltProjectMember)
      }
      return [template: project, days: days]
  }

  def save = {ProjectCommand pc ->
    Entity currentEntity = entityHelperService.loggedIn

    if (pc.hasErrors()) {
      render view: 'create', model: [pc: pc]
      return
    }

    EntityType etProject = metaDataService.etProject

    // --- create a totally new project ---
    if (!params.template) {
        // first check if the number of project days between the chosen begin and end date is > 0
        int checkdays = 0

        Date tperiodStart = params.startDate
        Date tperiodEnd = params.endDate
        tperiodEnd.setHours(23)
        tperiodEnd.setMinutes(59)

        Calendar tcalendarStart = new GregorianCalendar()
        tcalendarStart.setTime(tperiodStart)

        Calendar tcalendarEnd = new GregorianCalendar()
        tcalendarEnd.setTime(tperiodEnd)

        SimpleDateFormat tdf = new SimpleDateFormat("EEEE", new Locale("en"))

        while (tcalendarStart <= tcalendarEnd) {
           Date currentDate = tcalendarStart.getTime()

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
          pc.errors.rejectValue('weekdays', 'project.noDays')
          render view: "create", model: [pc: pc]
          return
        }

        // if there is more than 1 project day create project
        try {
          Entity entity = entityHelperService.createEntity("project", etProject) {Entity ent ->
            ent.profile = profileHelperService.createProfileFor(ent) as Profile
            ent.profile.properties = params
          }

          // save creator
          new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

          // create project days
          Date periodStart = params.startDate
          Date periodEnd = params.endDate

          periodEnd.setHours(23)
          periodEnd.setMinutes(59)

          Calendar calendarStart = new GregorianCalendar()
          calendarStart.setTime(periodStart)

          Calendar calendarEnd = new GregorianCalendar()
          calendarEnd.setTime(periodEnd)

          SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

          Date projectDayBegin
          Date projectDayEnd

          // loop through the date range and compare the dates day with the params
          while (calendarStart <= calendarEnd) {
            Date currentDate = calendarStart.getTime()

            if ((params.monday && (df.format(currentDate) == 'Monday')) ||
                    (params.tuesday && (df.format(currentDate) == 'Tuesday')) ||
                    (params.wednesday && (df.format(currentDate) == 'Wednesday')) ||
                    (params.thursday && (df.format(currentDate) == 'Thursday')) ||
                    (params.friday && (df.format(currentDate) == 'Friday')) ||
                    (params.saturday && (df.format(currentDate) == 'Saturday')) ||
                    (params.sunday && (df.format(currentDate) == 'Sunday'))) {

              if (df.format(currentDate) == 'Monday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.mondayStart.getHours())
                calendarStart.set(Calendar.MINUTE, params.mondayStart.getMinutes())
                projectDayBegin = calendarStart.getTime()
                calendarStart.set(Calendar.HOUR_OF_DAY, params.mondayEnd.getHours())
                calendarStart.set(Calendar.MINUTE, params.mondayEnd.getMinutes())
                projectDayEnd = calendarStart.getTime()
              }
              else if (df.format(currentDate) == 'Tuesday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.tuesdayStart.getHours())
                calendarStart.set(Calendar.MINUTE, params.tuesdayStart.getMinutes())
                projectDayBegin = calendarStart.getTime()
                calendarStart.set(Calendar.HOUR_OF_DAY, params.tuesdayEnd.getHours())
                calendarStart.set(Calendar.MINUTE, params.tuesdayEnd.getMinutes())
                projectDayEnd = calendarStart.getTime()
              }
              else if (df.format(currentDate) == 'Wednesday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.wednesdayStart.getHours())
                calendarStart.set(Calendar.MINUTE, params.wednesdayStart.getMinutes())
                projectDayBegin = calendarStart.getTime()
                calendarStart.set(Calendar.HOUR_OF_DAY, params.wednesdayEnd.getHours())
                calendarStart.set(Calendar.MINUTE, params.wednesdayEnd.getMinutes())
                projectDayEnd = calendarStart.getTime()
              }
              else if (df.format(currentDate) == 'Thursday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.thursdayStart.getHours())
                calendarStart.set(Calendar.MINUTE, params.thursdayStart.getMinutes())
                projectDayBegin = calendarStart.getTime()
                calendarStart.set(Calendar.HOUR_OF_DAY, params.thursdayEnd.getHours())
                calendarStart.set(Calendar.MINUTE, params.thursdayEnd.getMinutes())
                projectDayEnd = calendarStart.getTime()
              }
              else if (df.format(currentDate) == 'Friday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.fridayStart.getHours())
                calendarStart.set(Calendar.MINUTE, params.fridayStart.getMinutes())
                projectDayBegin = calendarStart.getTime()
                calendarStart.set(Calendar.HOUR_OF_DAY, params.fridayEnd.getHours())
                calendarStart.set(Calendar.MINUTE, params.fridayEnd.getMinutes())
                projectDayEnd = calendarStart.getTime()
              }
              else if (df.format(currentDate) == 'Saturday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.saturdayStart.getHours())
                calendarStart.set(Calendar.MINUTE, params.saturdayStart.getMinutes())
                projectDayBegin = calendarStart.getTime()
                calendarStart.set(Calendar.HOUR_OF_DAY, params.saturdayEnd.getHours())
                calendarStart.set(Calendar.MINUTE, params.saturdayEnd.getMinutes())
                projectDayEnd = calendarStart.getTime()
              }
              else if (df.format(currentDate) == 'Sunday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.sundayStart.getHours())
                calendarStart.set(Calendar.MINUTE, params.sundayStart.getMinutes())
                projectDayBegin = calendarStart.getTime()
                calendarStart.set(Calendar.HOUR_OF_DAY, params.sundayEnd.getHours())
                calendarStart.set(Calendar.MINUTE, params.sundayEnd.getMinutes())
                projectDayEnd = calendarStart.getTime()
              }

              // create project day
              EntityType etProjectDay = metaDataService.etProjectDay
              Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.fullName = params.fullName
                ent.profile.date = functionService.convertToUTC(projectDayBegin)
                ent.profile.endDate = functionService.convertToUTC(projectDayEnd)
              }

              // link project day to project
              new Link(source: projectDay, target: entity, type: metaDataService.ltProjectMember).save()

              // create 3 project units
              EntityType etProjectUnit = metaDataService.etProjectUnit
              for (i in 1..3) {
                  def name = message(code: 'introduction')
                  if (i == 2)
                      name = message(code: 'execution')
                  if (i == 3)
                      name = message(code: 'completion')
                    // create a new project unit

                    Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
                        ent.profile = profileHelperService.createProfileFor(ent) as Profile
                        ent.profile.fullName = name
                        ent.profile.date = projectDay.profile.date
                        ent.profile.duration = 0
                    }

                    // save creator
                    new Link(source: currentEntity, target: projectUnit, type: metaDataService.ltCreator).save()

                    projectDay.profile.addToUnits(projectUnit.id.toString())

                    // link the new unit to the project day
                    new Link(source: projectUnit, target: projectDay, type: metaDataService.ltProjectDayUnit).save()
              }

            }

            // increment calendar
            calendarStart.add(Calendar.DATE, 1)
          }

          flash.message = message(code: "object.created", args: [message(code: "project"), entity.profile])

          new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name + 'Profile', action: 'show', id: currentEntity.id) + '">' + currentEntity.profile + '</a> hat das Projekt <a href="' + createLink(controller: 'projectProfile', action: 'show', id: entity.id) + '">' + entity.profile + '</a> geplant.').save()
          redirect action: 'show', id: entity.id

        } catch (EntityException ee) {
          render view: "create", model: [project: ee.entity]
        }
    }
    else {
        // repeat project

        Entity template = Entity.get(params.template)

        // get project days of template
        List pds = functionService.findAllByLink(null, template, metaDataService.ltProjectMember)
        pds = pds.sort {it.profile.date}

        EntityType etProjectUnit = metaDataService.etProjectUnit

        try {
            Entity entity = entityHelperService.createEntity("project", etProject) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.properties = params
                ent.profile.endDate = params.endDate ?: new Date()
            }

            // save creator
            new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

            // create project days
            Date periodStart = params.startDate

            Calendar calendarStart = new GregorianCalendar()
            calendarStart.setTime(periodStart)

            SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

            Date projectDayBegin
            Date projectDayEnd

            int daysPlanned = 0

            // loop through the date range and compare the dates day with the params
            while (daysPlanned < params.int('days')) {
                Date currentDate = calendarStart.getTime()

                if ((params.monday && (df.format(currentDate) == 'Monday')) ||
                        (params.tuesday && (df.format(currentDate) == 'Tuesday')) ||
                        (params.wednesday && (df.format(currentDate) == 'Wednesday')) ||
                        (params.thursday && (df.format(currentDate) == 'Thursday')) ||
                        (params.friday && (df.format(currentDate) == 'Friday')) ||
                        (params.saturday && (df.format(currentDate) == 'Saturday')) ||
                        (params.sunday && (df.format(currentDate) == 'Sunday'))) {

                    if (df.format(currentDate) == 'Monday') {
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.mondayStart.getHours())
                        calendarStart.set(Calendar.MINUTE, params.mondayStart.getMinutes())
                        projectDayBegin = calendarStart.getTime()
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.mondayEnd.getHours())
                        calendarStart.set(Calendar.MINUTE, params.mondayEnd.getMinutes())
                        projectDayEnd = calendarStart.getTime()
                    }
                    else if (df.format(currentDate) == 'Tuesday') {
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.tuesdayStart.getHours())
                        calendarStart.set(Calendar.MINUTE, params.tuesdayStart.getMinutes())
                        projectDayBegin = calendarStart.getTime()
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.tuesdayEnd.getHours())
                        calendarStart.set(Calendar.MINUTE, params.tuesdayEnd.getMinutes())
                        projectDayEnd = calendarStart.getTime()
                    }
                    else if (df.format(currentDate) == 'Wednesday') {
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.wednesdayStart.getHours())
                        calendarStart.set(Calendar.MINUTE, params.wednesdayStart.getMinutes())
                        projectDayBegin = calendarStart.getTime()
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.wednesdayEnd.getHours())
                        calendarStart.set(Calendar.MINUTE, params.wednesdayEnd.getMinutes())
                        projectDayEnd = calendarStart.getTime()
                    }
                    else if (df.format(currentDate) == 'Thursday') {
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.thursdayStart.getHours())
                        calendarStart.set(Calendar.MINUTE, params.thursdayStart.getMinutes())
                        projectDayBegin = calendarStart.getTime()
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.thursdayEnd.getHours())
                        calendarStart.set(Calendar.MINUTE, params.thursdayEnd.getMinutes())
                        projectDayEnd = calendarStart.getTime()
                    }
                    else if (df.format(currentDate) == 'Friday') {
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.fridayStart.getHours())
                        calendarStart.set(Calendar.MINUTE, params.fridayStart.getMinutes())
                        projectDayBegin = calendarStart.getTime()
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.fridayEnd.getHours())
                        calendarStart.set(Calendar.MINUTE, params.fridayEnd.getMinutes())
                        projectDayEnd = calendarStart.getTime()
                    }
                    else if (df.format(currentDate) == 'Saturday') {
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.saturdayStart.getHours())
                        calendarStart.set(Calendar.MINUTE, params.saturdayStart.getMinutes())
                        projectDayBegin = calendarStart.getTime()
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.saturdayEnd.getHours())
                        calendarStart.set(Calendar.MINUTE, params.saturdayEnd.getMinutes())
                        projectDayEnd = calendarStart.getTime()
                    }
                    else if (df.format(currentDate) == 'Sunday') {
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.sundayStart.getHours())
                        calendarStart.set(Calendar.MINUTE, params.sundayStart.getMinutes())
                        projectDayBegin = calendarStart.getTime()
                        calendarStart.set(Calendar.HOUR_OF_DAY, params.sundayEnd.getHours())
                        calendarStart.set(Calendar.MINUTE, params.sundayEnd.getMinutes())
                        projectDayEnd = calendarStart.getTime()
                    }

                    // create project day
                    EntityType etProjectDay = metaDataService.etProjectDay
                    Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
                        ent.profile = profileHelperService.createProfileFor(ent) as Profile
                        ent.profile.fullName = params.fullName
                        ent.profile.date = functionService.convertToUTC(projectDayBegin)
                        ent.profile.endDate = functionService.convertToUTC(projectDayEnd)
                    }

                    // link project day to project
                    new Link(source: projectDay, target: entity, type: metaDataService.ltProjectMember).save()

                    // find all project units of the n-th day of the template and duplicate them
                    List projectUnits = []
                    pds[daysPlanned].profile.units.each { String pu ->
                        projectUnits.add(Entity.get(pu.toInteger()))
                    }

                    projectUnits?.each { Entity pu ->

                        List activityTemplates = []

                        List ats = functionService.findAllByLink(null, pu, metaDataService.ltGroupMember)
                        if (ats.size() > 0)
                            activityTemplates.addAll(ats)

                        int duration = activityTemplates*.profile.duration.sum(0)

                        // create unit
                        Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
                            ent.profile = profileHelperService.createProfileFor(ent) as Profile
                            ent.profile.fullName = pu.profile.fullName
                            ent.profile.date = pu.profile.date
                            ent.profile.duration = duration
                        }

                        projectDay.profile.addToUnits(projectUnit.id.toString())

                        // link the new unit to the project day
                        new Link(source: projectUnit, target: projectDay, type: metaDataService.ltProjectDayUnit).save()

                        activityTemplates?.each { Entity at ->
                            // check if the activityTemplate isn't already linked to the projectUnit
                            def link = Link.createCriteria().get {
                                eq('source', at)
                                eq('target', projectUnit)
                                eq('type', metaDataService.ltGroupMember)
                            }
                            if (!link)
                            // link activityTemplate to projectUnit
                                new Link(source: at, target: projectUnit, type: metaDataService.ltGroupMember).save()
                        }
                    }

                    daysPlanned++

                }

                // increment calendar
                calendarStart.add(Calendar.DATE, 1)
            }
            entity.profile.endDate = calendarStart.getTime()
            entity.profile.save()

            flash.message = message(code: "object.created", args: [message(code: "project"), entity.profile])

            new Live(content: '<a href="' + createLink(controller: currentEntity.type.supertype.name + 'Profile', action: 'show', id: currentEntity.id) + '">' + currentEntity.profile + '</a> hat das Projekt <a href="' + createLink(controller: 'projectProfile', action: 'show', id: entity.id) + '">' + entity.profile + '</a> geplant.').save()
            redirect action: 'show', id: entity.id

        } catch (EntityException ee) {
            render view: "create", model: [project: ee.entity]
        }
    }

  }

  def addUnit = {
    Entity projectDay = Entity.get(params.id)
    //Entity projectUnitTemplate = Entity.get(params.unit)

    Entity currentEntity = entityHelperService.loggedIn

    Date time = params.date('time', 'HH:mm')
    time = functionService.convertToUTC(time)

    def project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

    Calendar calendar = new GregorianCalendar()
    calendar.setTime(projectDay.profile.date)
    calendar.set(Calendar.HOUR_OF_DAY, time.getHours())
    calendar.set(Calendar.MINUTE, time.getMinutes())

    if (calendar.getTime().getTime() >= projectDay.profile.date.getTime()) {

        // create a new project unit
        EntityType etProjectUnit = metaDataService.etProjectUnit
        Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.fullName = params.unit

          calendar.setTime(projectDay.profile.date)
          //calendar.add(Calendar.MINUTE, duration)
          calendar.set(Calendar.HOUR_OF_DAY, time.getHours())
          calendar.set(Calendar.MINUTE, time.getMinutes())
          ent.profile.date = calendar.getTime()
          ent.profile.duration = params.int('duration')
        }

        // save creator
        new Link(source: currentEntity, target: projectUnit, type: metaDataService.ltCreator).save()

        projectDay.profile.addToUnits(projectUnit.id.toString())

        // link the new unit to the project day
        new Link(source: projectUnit, target: projectDay, type: metaDataService.ltProjectDayUnit).save()

    }
      else
        render '<p class="red">' + message(code: 'projectUnit.notInRange') + '</p>'

    // return values for the template
        // find all units linked to this projectDay
        List units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

        // get all parents
        def allParents = Entity.findAllByType(metaDataService.etParent)

        // get all partners
        def allPartners = Entity.findAllByType(metaDataService.etPartner)

    render template: 'units', model: [units: units, project: project, projectDay: projectDay, allParents: allParents, allPartners: allPartners]

  }

  def removeUnit = {
    Entity projectDay = Entity.get(params.id)
    Entity projectUnit = Entity.get(params.unit)

    def project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

    // delete link
    def link = Link.createCriteria().get {
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
    //List units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

    //render template: 'units', model: [units: units, projectDay: projectDay, project: project]
     redirect action: "show", id: project.id, params: [one: projectDay.id]
  }

  def removeClient = {
      Entity project = Entity.get(params.id)
      Entity client = Entity.get(params.client)

      // find all project days of the project
      List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

      // remove client if found in any project day
      projectDays?.each { Entity pd ->
          def link = Link.createCriteria().get {
              eq('source', client)
              eq('target', pd)
              eq('type', metaDataService.ltGroupMemberClient)
          }
          link?.delete()
      }

      List clients = []
      projectDays?.each { Entity pd ->
          List pdclients = functionService.findAllByLink(null, pd, metaDataService.ltGroupMemberClient)
          pdclients?.each { pdclient ->
              if (!clients.contains(pdclient))
                  clients.add(pdclient)
          }

      }

      clients.sort {it.profile.firstName}
    render template: "clients", model: [clients: clients, project: project]
  }

    def removeClientDay = {
        Entity day = Entity.get(params.day)
        def breaking = functionService.breakEntities(params.client, params.day, metaDataService.ltGroupMemberClient)
        render template: 'clientsday', model: [clients: breaking.sources, project: breaking.target, day: day]
    }

  def addFacility = {
    def linking = functionService.linkEntities(params.id, params.facility, metaDataService.ltGroupMemberFacility)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.target.profile]))}
    render template: 'facilities', model: [facilities: linking.targets, project: linking.source]
  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.id, params.facility, metaDataService.ltGroupMemberFacility)

    // find all project days of project
    Entity project = Entity.get(params.id)
    List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

    // delete for every project day the planned resources
    projectDays.each { Entity pd ->
      Link.findAllByTargetAndType(pd, metaDataService.ltResourcePlanned).each {it.delete()}
    }

    render template: 'facilities', model: [facilities: breaking.targets, project: breaking.source]
  }

  def updateFacilityButton = {
    Entity project = Entity.get(params.id)

    List facilities = functionService.findAllByLink(null, project, metaDataService.ltGroupMemberFacility)
    render template: 'facilitybutton', model: [facilities: facilities]
  }

  def addResource = {
    def linking = functionService.linkEntities(params.resource, params.id, metaDataService.ltProjectDayResource)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
    render template: 'resources', model: [resources: linking.sources, projectDay: linking.target]
  }

  def removeResource = {
    def breaking = functionService.breakEntities(params.resource, params.id, metaDataService.ltProjectDayResource)
    render template: 'resources', model: [resources: breaking.sources, projectDay: breaking.target]
  }

  def addEducator = {
      def entity = Entity.get(params.educator)
      Entity project = Entity.get(params.id)

      List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

      projectDays.each { Entity pd ->
          def linking = functionService.linkEntities(params.educator, pd.id.toString(), metaDataService.ltProjectDayEducator)
          if (linking.duplicate)
              render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
      }

      List educators = []

      projectDays.each { Entity pd ->
          List pdeducators = functionService.findAllByLink(null, pd, metaDataService.ltProjectDayEducator)
          pdeducators?.each { pdeducator ->
              if (!educators.contains(pdeducator))
                  educators.add(pdeducator)
          }
      }

      render template: 'educators', model: [educators: educators, project: project]
  }

    def addEducatorDay = {
        def linking = functionService.linkEntities(params.educator, params.day, metaDataService.ltProjectDayEducator)
        if (linking.duplicate)
            render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
        def project = functionService.findByLink(linking.target, null, metaDataService.ltProjectMember)
        render template: 'educatorsday', model: [educators: linking.sources, project: project, day: linking.target]
    }

  def removeEducator = {
      Entity project = Entity.get(params.id)
      Entity educator = Entity.get(params.educator)

      // find all project days of the project
      List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

      // remove client if found in any project day
      projectDays?.each { Entity pd ->
          def link = Link.createCriteria().get {
              eq('source', educator)
              eq('target', pd)
              eq('type', metaDataService.ltProjectDayEducator)
          }
          link?.delete()
      }

      List educators = []
      projectDays?.each { Entity pd ->
          List pdeducators = functionService.findAllByLink(null, pd, metaDataService.ltProjectDayEducator)
          pdeducators?.each { pdeducator ->
              if (!educators.contains(pdeducator))
                  educators.add(pdeducator)
          }

      }
      render template: "educators", model: [educators: educators, project: project]
  }

    def removeEducatorDay = {
        Entity day = Entity.get(params.day)
        def breaking = functionService.breakEntities(params.client, params.day, metaDataService.ltProjectDayEducator)
        render template: 'educatorsday', model: [educators: breaking.sources, project: breaking.target, day: day]
    }

  def addSubstitute = {
    def linking = functionService.linkEntities(params.substitute, params.id, metaDataService.ltProjectDaySubstitute)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
    def project = functionService.findByLink(linking.target, null, metaDataService.ltProjectMember)
    render template: 'substitutes', model: [substitutes: linking.sources, project: project, projectDay: linking.target]
  }

  def removeSubstitute = {
    def breaking = functionService.breakEntities(params.substitute, params.id, metaDataService.ltProjectDaySubstitute)
    def project = functionService.findByLink(breaking.target, null, metaDataService.ltProjectMember)
    render template: 'substitutes', model: [substitutes: breaking.sources, project: project, projectDay: breaking.target]
  }

  def addParent = {
    def linking = functionService.linkEntities(params.parent, params.id, metaDataService.ltProjectUnitParent)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
    Entity projectDay = functionService.findByLink(linking.target, null, metaDataService.ltProjectDayUnit)
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    render template: 'parents', model: [parents: linking.sources, project: project, unit: linking.target, i: params.i]
  }

  def removeParent = {
    def breaking = functionService.breakEntities(params.parent, params.id, metaDataService.ltProjectUnitParent)
    Entity projectDay = functionService.findByLink(breaking.target, null, metaDataService.ltProjectDayUnit)
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    render template: 'parents', model: [parents: breaking.sources, project: project, unit: breaking.target, i: params.i]
  }

  def addPartner = {
    def linking = functionService.linkEntities(params.partner, params.id, metaDataService.ltProjectUnitPartner)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
    Entity projectDay = functionService.findByLink(linking.target, null, metaDataService.ltProjectDayUnit)
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    render template: 'partners', model: [partners: linking.sources, project: project, unit: linking.target, i: params.i]
  }

  def removePartner = {
    def breaking = functionService.breakEntities(params.partner, params.id, metaDataService.ltProjectUnitPartner)
    Entity projectDay = functionService.findByLink(breaking.target, null, metaDataService.ltProjectDayUnit)
    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
    render template: 'partners', model: [partners: breaking.sources, project: project, unit: breaking.target, i: params.i]
  }

  def addTheme = {
    def linking = functionService.linkEntities(params.id, params.theme, metaDataService.ltGroupMember)
    if (linking.duplicate)
        render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
    render template: 'themes', model: [themes: linking.targets, project: linking.source]
  }

  def removeTheme = {
    def breaking = functionService.breakEntities(params.id, params.theme, metaDataService.ltGroupMember)
    render template: 'themes', model: [themes: breaking.targets, project: breaking.source]
  }

  def setprojectday = {
    Entity project = Entity.get(params.project)

    // find all project days linked to this project
    List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)
    projectDays.sort {it.profile.date}

    Entity projectDay = params.id ? Entity.get(params.id) : projectDays[0]

    // find projectTemplate of this project
    //Entity template = functionService.findByLink(null, project, metaDataService.ltProjectTemplate)

    // find all units linked to the template
    //List units = functionService.findAllByLink(null, template, metaDataService.ltProjectUnitTemplate)

    // get all parents
    def allParents = Entity.findAllByType(metaDataService.etParent)

    // get all educators
    def allEducators = entityDataService.getAllEducators()

    // get all educators
    def allPartners = Entity.findAllByType(metaDataService.etPartner)

    // get all plannable resources
    List facilities = functionService.findAllByLink(project, null, metaDataService.ltGroupMemberFacility)

    List ownRequiredResources = []
      project.profile.resources.each {
          ownRequiredResources.add(it)
      }

    List requiredResources = []

    // find all project units linked to the project day
    List pUnits = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

    // find all activities linked to all units
    pUnits.each { Entity pUnit ->
      List activities = functionService.findAllByLink(null, pUnit, metaDataService.ltGroupMember)
      activities?.each { Entity activity ->
        activity.profile.resources.each {
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
      Entity colony = linkDataService.getColony(facility)
      plannableResources.addAll(functionService.findAllByLink(null, colony, metaDataService.ltResource))
    }

    List resources = functionService.findAllByLink(null, projectDay, metaDataService.ltResourcePlanned)

    render template: 'projectdaynav', model: [day: projectDay,
                                              resources: resources,
                                              allEducators: allEducators,
                                              allParents: allParents,
                                              allPartners: allPartners,
                                              projectDays: projectDays,
                                              active: projectDay.id,
                                              project: project,
                                              plannableResources: plannableResources,
                                              requiredResources: requiredResources,
                                              ownRequiredResources: ownRequiredResources]
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
      render template: 'educatorresults', model: [results: entityDataService.getAllEducators(), projectDay: params.id]
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
      render template: 'educatorresults', model: [results: results, group: params.id]
    }
  }

    /*
    * retrieves all educators matching the search parameter
    */
    def remoteEducatorsDay = {
        if (!params.value) {
            render ""
            return
        }
        else if (params.value == "*") {
            render template: 'educatorresultsday', model: [results: entityDataService.getAllEducators(), group: params.id, projectDay: params.id]
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
            Entity projectDay = Entity.get(params.projectDay)
            render template: 'educatorresultsday', model: [results: results, group: params.id, projectDay: projectDay]
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
      render template: 'substituteresults', model: [results: entityDataService.getAllEducators(), projectDay: params.id]
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
      render template: 'substituteresults', model: [results: results, projectDay: params.id]
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

    // filter clients by facility: only take those clients which are linked to the facility the project is linked to
    // if the project isn't linked to a facility yet, don't filter

    // get facility
    Entity project = Entity.get(params.id)
    List facilities = functionService.findAllByLink(project, null, metaDataService.ltGroupMemberFacility)

    List finalResults = []
    if (facilities) {
      // find all clients linked to the facilities
      List clients = []
      facilities.each { Entity facility ->
        clients.addAll(functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient))
      }

      // check clients but don't check clientgroups
      results?.each { Entity client ->
        if (client.type.supertype.name == "client") {
          if (clients.contains(client))
            finalResults.add(client)
        }
        else
          finalResults.add(client)
      }
    }
    else
      finalResults = results

    if (finalResults.size() == 0) {
      render {span(class: 'italic', message(code: 'noResultsFound'))}
      return
    }
    else {
      render template: 'clientresults', model: [results: finalResults, group: params.id]
    }
  }

    /*
    * retrieves all clients and client groups matching the search parameter
    */
    def remoteClientsDay = {
        if (!params.value) {
            render ""
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

        // filter clients by facility: only take those clients which are linked to the facility the project is linked to
        // if the project isn't linked to a facility yet, don't filter

        // get facility
        Entity project = Entity.get(params.id)
        List facilities = functionService.findAllByLink(project, null, metaDataService.ltGroupMemberFacility)

        List finalResults = []
        if (facilities) {
            // find all clients linked to the facilities
            List clients = []
            facilities.each { Entity facility ->
                clients.addAll(functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient))
            }

            // check clients but don't check clientgroups
            results?.each { Entity client ->
                if (client.type.supertype.name == "client") {
                    if (clients.contains(client))
                        finalResults.add(client)
                }
                else
                    finalResults.add(client)
            }
        }
        else
            finalResults = results

        if (finalResults.size() == 0) {
            render {span(class: 'italic', message(code: 'noResultsFound'))}
            return
        }
        else {
            Entity projectDay = Entity.get(params.projectDay)
            render template: 'clientresultsday', model: [results: finalResults, group: params.id, projectDay: projectDay]
        }
    }

  // adds a client or clients of a client group
  def addClient = {
    def entity = Entity.get(params.client)
      Entity project = Entity.get(params.id)

      List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)



    // if the entity is a client add it
    if (entity.type.id == metaDataService.etClient.id) {
        projectDays.each { Entity pd ->
            def linking = functionService.linkEntities(params.client, pd.id.toString(), metaDataService.ltGroupMemberClient)
            if (linking.duplicate)
                render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
        }
    }
    // if the entity is a client group get all clients and add them
    else if (entity.type.id == metaDataService.etGroupClient.id) {
      // find all clients of the group
      List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)

      clients.each { Entity client ->
          projectDays.each { Entity pd ->
            def linking = functionService.linkEntities(client.id.toString(), pd.id.toString(), metaDataService.ltGroupMemberClient)
            if (linking.duplicate)
                render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
          }
      }

    }

      List clients = []
      projectDays.each { Entity pd ->
          List pdclients = functionService.findAllByLink(null, pd, metaDataService.ltGroupMemberClient)
          pdclients?.each { pdclient ->
              if (!clients.contains(pdclient))
                  clients.add(pdclient)
          }

      }
      clients.sort {it.profile.firstName}

      render template: 'clients', model: [clients: clients, project: project]

  }

    // adds a client or clients of a client group
    def addClientDay = {
        def entity = Entity.get(params.client)
        Entity day = Entity.get(params.day)

        // if the entity is a client add it
        if (entity.type.id == metaDataService.etClient.id) {
            def linking = functionService.linkEntities(params.client, params.day, metaDataService.ltGroupMemberClient)
            if (linking.duplicate)
                render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
            render template: 'clientsday', model: [clients: linking.sources, project: linking.target, day: day]
        }
        // if the entity is a client group get all clients and add them
        else if (entity.type.id == metaDataService.etGroupClient.id) {
            // find all clients of the group
            List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)

            clients.each { Entity client ->
                def linking = functionService.linkEntities(client.id.toString(), params.day, metaDataService.ltGroupMemberClient)
                if (linking.duplicate)
                    render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
            }

            Entity project = Entity.get(params.id)
            List clients2 = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)
            render template: 'clientsday', model: [clients: clients2, project: project, day: day]
        }

    }

  def listevaluations = {
    Entity project = Entity.get(params.id)

    // find all project days of the project
    List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)

    // find all evaluations linked to the project days
    List evaluations = []
    projectDays.each { Entity pd ->
      evaluations.addAll(Evaluation.findAllByLinkedTo(pd))
    }

    render template: "listevaluations", model: [evaluations: evaluations, entity: project]
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

    render template: 'units', model: [projectDay: projectDay, units: units, project: project, allParents: allParents, allPartners: allPartners]
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

    render template: 'units', model: [projectDay: projectDay, units: units, project: project, allParents: allParents, allPartners: allPartners]
  }

  def searchbydate = {
    Date beginDate = params.date('beginDate', 'dd. MM. yy')
    Date endDate = params.date('endDate', 'dd. MM. yy')
    
    if (!beginDate || !endDate)
      render {span(class: 'red italic', message(code: 'date.insert.fromto'))}
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
        render {span(class: 'italic', message(code: 'searchMe.empty'))}
        return
      }
      else {
        render template: 'searchresults', model: [projects: projects]
      }
    }
  }

  def searchbyname = {
    if (!params.name) {
      render {span(class: 'italic', message(code: 'searchMe.empty'))}
      return
    }

    def users = Entity.createCriteria().list {
      eq("type", metaDataService.etProject)
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
      render template: 'searchresults', model: [projects: users]
    }
  }

  def searchbytheme = {
    Entity theme = Entity.get(params.theme)

    if (theme) {
      // find all projects that are linked to this theme
      List projects = functionService.findAllByLink(null, theme, metaDataService.ltGroupMember)
      if (projects.size() == 0) {
        render {span(class: 'italic', message(code: 'searchMe.empty'))}
        return
      }
      else {
        render template: 'searchresults', model: [projects: projects]
      }
    }
    else
      render {span(class: 'italic', message(code: 'searchMe.empty'))}
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
      render {span(class: 'italic', message(code: 'searchMe.empty'))}
      return
    }
    else {
        render template: 'searchresults', model: [projects: result]
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

    // get all project units of the project day and calculate their duration sum
    List units = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)
    int duration = 0
    units.each {
      duration += it.profile.duration
    }

    calendar.add(Calendar.MINUTE, duration)

    // make sure no resource is planned if the duration is 0 (which means no project unit has been set yet)
    if (duration > 0) {
      Link existing = functionService.findExactLink(resource, projectDay, metaDataService.ltResourcePlanned)

      if (!existing) {
        Link link = linkHelperService.createLink(resource, projectDay, metaDataService.ltResourcePlanned) {link, dad ->
          dad.beginDate = (projectDay.profile.date.getTime() / 1000).toInteger()
          dad.endDate = (calendar.getTime().getTime() / 1000).toInteger()
          dad.amount = params.amount
        }
      }
      else {
        existing.das.amount++
      }
    }
    else {
      render '<span class="italic">Es müssen erst Projekteinheiten geplant werden bevor Ressourcen geplant werden können!</span><br/>'
    }

    List resources = functionService.findAllByLink(null, projectDay, metaDataService.ltResourcePlanned)
    render template: 'resources', model: [resources: resources, projectDay: projectDay]
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
    render template: 'resources', model: [resources: resources, projectDay: projectDay]
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
      Entity colony = linkDataService.getColony(facility)
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
      colonyResources.each {
        if (!plannableResources.contains(it))
          plannableResources.add(it)
      }
      //plannableResources.addAll(colonyResources)
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
    //plannableResources.addAll(everywhereResources)

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
    render template: 'labels', model: [project: entity]
  }

  /*
   * removes a label from a group
   */
  def removeLabel = {
    Entity group = Entity.get(params.id)
    group.profile.removeFromLabels(Label.get(params.label))
    Label.get(params.label).delete()
    render template: 'labels', model: [project: group]
  }
  
  def moveProjectDay = {
    Entity projectDay = Entity.get(params.id)

    Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

    List projectDays = functionService.findAllByLink(null, project, metaDataService.ltProjectMember)
    projectDays.sort {it.profile.date}

    Date date = functionService.convertToUTC(params.date('date', 'dd. MM. yy'))
      date.setHours(projectDay.profile.date.getHours())
      date.setMinutes(projectDay.profile.date.getMinutes())

    // calculate difference in minutes of hours and minutes of old and new date
    //int difference = (date.getHours() * 60 + date.getMinutes()) - (projectDay.profile.date.getHours() * 60 + projectDay.profile.date.getMinutes())

    // check if the new date doesn't conflict with the date of another project day
    def conflictingDate = false
    projectDays.each { Entity pd ->
      if (pd.id != projectDay.id) {
        if (pd.profile.date.getDate() == date.getDate() && pd.profile.date.getMonth() == date.getMonth() && pd.profile.date.getYear() == date.getYear())
          conflictingDate = true
      }
    }

    // check if the new date is within the project begin and end date
    def outOfRange = false
    if (date < project.profile.startDate || date > project.profile.endDate) {
      outOfRange = true
    }

    if (!conflictingDate && !outOfRange) {
      projectDay.profile.date = date
      projectDay.profile.save()

      /*
      // update date of all linked project units
      List projectDayUnits = []
        projectDay.profile.units.each {
        projectDayUnits.add(Entity.get(it))
      }
      projectDayUnits.each { Entity pdu ->
        Calendar calendar = new GregorianCalendar()
        calendar.setTime(pdu.profile.date)
        calendar.add(Calendar.MINUTE, difference)
        pdu.profile.date = calendar.getTime()
        pdu.profile.save()
      }

      // create an event
      Entity currentEntity = entityHelperService.loggedIn
      functionService.createEvent(EVENT_TYPE.PROJECT_DAY_MOVED, currentEntity.id.toInteger(), projectDay.id.toInteger())

      // inform all participants by PM about the changed project day
      List informedEntities = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayEducator)
      informedEntities.addAll(functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDaySubstitute))
      
      informedEntities?.each { Entity ie ->
        String subject = "Projekttag verschoben, Projekt " + project.profile.decodeHTML()
        String content = '<p>Hallo ' + ie.profile + '!</p>Ich habe einen ' + link(controller: 'projectDayProfile', action: 'show', id: projectDay.id, params: [one: projectDay.id]) {'Projekttag'} + ' vom Projekt ' + project.profile.decodeHTML() + ' verschoben.'
        functionService.createMessage(currentEntity, [ie], ie, subject, content).save()
      }
      */

    }

    Entity template = functionService.findByLink(null, project, metaDataService.ltProjectTemplate)

    List units = functionService.findAllByLink(null, template, metaDataService.ltProjectUnitTemplate)
    
    def allParents = Entity.findAllByType(metaDataService.etParent)
    def allEducators = entityDataService.getAllEducators()
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
      groups.each { Entity group ->
        List temps = functionService.findAllByLink(null, group, metaDataService.ltGroupMember)
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
      Entity colony = linkDataService.getColony(facility)
      plannableResources.addAll(functionService.findAllByLink(null, colony, metaDataService.ltResource))
    }

    List resources = functionService.findAllByLink(null, projectDay, metaDataService.ltResourcePlanned)
    
    render template: 'projectdaynav', model: [day: projectDay,
                                             resources: resources,
                                             allEducators: allEducators,
                                             allParents: allParents,
                                             units: units,
                                             projectDays: projectDays,
                                             active: projectDay.id,
                                             project: project,
                                             plannableResources: plannableResources,
                                             requiredResources: requiredResources,
                                             outOfRange: outOfRange,
                                             conflictingDate: conflictingDate]
  }

  def deleteProjectDay = {
    Entity projectDay = Entity.get(params.id)
    Entity project = Entity.get(params.project)
   
    // find all project units
    List projectUnits = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)
    
    projectUnits?.each { Entity pu ->
      // remove links to creator and group activity templates
      Link.findAllByTargetAndType(pu, metaDataService.ltCreator).each {it.delete()}
      Link.findAllByTargetAndType(pu, metaDataService.ltProjectUnit).each {it.delete()}
    }
    
    // delete all links to the project day
    Link.findAllBySourceOrTarget(projectDay, projectDay).each {it.delete()}

    // delete project units
    projectUnits?.each { Entity pu ->
      it.delete()
    }
    
    // delete project day
    projectDay.delete()

    redirect action: "show", id: project.id
  }

  def refreshplannedresources = {
    Entity group = Entity.get(params.id)

    List resources = functionService.findAllByLink(null, group, metaDataService.ltResourcePlanned)

    render template: 'resources', model: [resources: resources, projectDay: group]
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
        def results = Entity.createCriteria().list {
            eq('type', metaDataService.etProject)
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
        if (params.labels) {
            List tempResults = []
            List labels = params.list('labels')
            results.each { Entity template ->
                template.profile.labels.each { Label label ->
                    if (labels.contains(label.name)) {
                        if (!tempResults.contains(template))
                            tempResults.add(template)
                    }
                }
            }
            results = tempResults
        }

        // 4. filter by theme
        if (params.theme != "") {
            List tempResults = []
            Entity theme = Entity.get(params.theme)
            List projects = functionService.findAllByLink(null, theme, metaDataService.ltGroupMember)

            projects.each { Entity project ->
                if (results.contains(project))
                    tempResults.add(project)
            }

            results = tempResults
        }

        int totalResults = results.size()
        int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
        results = results.subList(params.offset, upperBound)

        render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'project', params: params]
    }

    /*
    * retrieves all entities matching the search parameter
    */
    def remoteResponsible = {
        if (!params.value) {
            render ""
            return
        }
        else if (params.value.size() < 2) {
            render {span(class: 'gray', message(code: 'minChars'))}
            return
        }

        def results = Entity.createCriteria().listDistinct {
            user {
                eq('enabled', true)
            }
            eq('type', metaDataService.etEducator)
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
            render template: 'responsibleresults', model: [results: results, projectID: params.id]
        }
    }

    def addResponsible = {
        def linking = functionService.linkEntities(params.entity, params.id, metaDataService.ltResponsible)
        if (linking.duplicate)
            render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
        render template: 'responsible', model: [responsibles: linking.sources, project: linking.target]

    }

    def removeResponsible = {
        def breaking = functionService.breakEntities(params.responsible, params.id, metaDataService.ltResponsible)
        render template: 'responsible', model: [responsibles: breaking.sources, project: breaking.target]
    }

    def updateClientsSize = {
        Entity day = Entity.get(params.id)
        List clients = functionService.findAllByLink(null, day, metaDataService.ltGroupMemberClient)
        render "(${clients.size()})"
    }

    def complete = {
        Entity project = Entity.get(params.id)
        [project: project]
    }

    def completeNow = {
        Entity project = Entity.get(params.id)
        project.profile.completed = true
        project.profile.properties = params

        project.save()

        redirect action: "show", id: project.id
    }

    def createpdf = {
        Entity project = Entity.get(params.id)
        Entity currentEntity = entityHelperService.loggedIn

        Entity template = functionService.findByLink(null, project, metaDataService.ltTemplate) // find template

        renderPdf template: 'createpdf', model: [pageformat: params.pageformat,
                entity: currentEntity,
                project: project,
                template: template],
                filename: message(code: 'project') + '_' + project.profile + '.pdf'
    }

    def editUnitDate = {
        def unit = Entity.get(params.id)
        render template: "editunitdate", model: [unit: unit, i: params.i]
    }

    def updateUnitDate = {
        def unit = Entity.get(params.id)

        Date time = params.date('time', 'HH:mm')
        time = functionService.convertToUTC(time)

        Calendar calendar = new GregorianCalendar()
        calendar.setTime(unit.profile.date)
        calendar.set(Calendar.HOUR_OF_DAY, time.getHours())
        calendar.set(Calendar.MINUTE, time.getMinutes())
        unit.profile.date = calendar.getTime()
        unit.profile.save()

        render template: "showunitdate", model: [unit: unit, i: params.i]
    }

    def editUnitName = {
        def unit = Entity.get(params.id)
        render template: "editunitname", model: [unit: unit, i: params.i]
    }

    def updateUnitName = {
        def unit = Entity.get(params.id)

        unit.profile.fullName = params.fullName
        unit.profile.save()

        render template: "showunitname", model: [unit: unit, i: params.i]
    }

    def editUnitDuration = {
        def unit = Entity.get(params.id)
        render template: "editunitduration", model: [unit: unit, i: params.i]
    }

    def updateUnitDuration = {
        def unit = Entity.get(params.id)

        unit.profile.duration = params.int('duration')
        unit.profile.save()

        render template: "showunitduration", model: [unit: unit, i: params.i]
    }

    /*
    * retrieves all activity templates matching the search parameter
    */
    def remoteActivityTemplate = {
        if (!params.value) {
            render ""
            return
        }
        else if (params.value == "*") {
            def results = Entity.createCriteria().list {
                eq("type", metaDataService.etTemplate)
                profile {
                    eq("status", "done")
                }
            }
            render template: 'activitytemplateresults', model: [results: results, projectUnit: params.id, i: params.i, project: params.project]
            return
        }

        def results = Entity.createCriteria().list {
            eq('type', metaDataService.etTemplate)
            profile {
                eq('status', "done")
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
            render template: 'activitytemplateresults', model: [results: results, projectUnitID: params.id, i: params.i, project: params.project]
        }
    }

    def addActivityTemplate = {
        Entity activityTemplate = Entity.get(params.activityTemplate)
        Entity projectUnit = Entity.get(params.id)
        Entity project = Entity.get(params.project)

        // check if the activityTemplate isn't already linked to the projectUnit
        def link = Link.createCriteria().get {
            eq('source', activityTemplate)
            eq('target', projectUnit)
            eq('type', metaDataService.ltGroupMember)
        }
        if (!link)
        // link activityTemplate to projectUnit
            new Link(source: activityTemplate, target: projectUnit, type: metaDataService.ltGroupMember).save()

        // find all activityTemplates linked to the unit
        List activityTemplates = functionService.findAllByLink(null, projectUnit, metaDataService.ltGroupMember)

        render template: 'activityTemplates', model: [activityTemplates: activityTemplates,
                unit: projectUnit,
                i: params.i,
                project: project]
    }

    def removeActivityTemplate = {
        Entity activityTemplate = Entity.get(params.activityTemplate)
        Entity projectUnit = Entity.get(params.id)
        Entity project = Entity.get(params.project)

        // delete link
        def link = Link.createCriteria().get {
            eq('source', activityTemplate)
            eq('target', projectUnit)
            eq('type', metaDataService.ltGroupMember)
        }
        link.delete()

        // find all activityTemplates linked to the unit
        List activityTemplates = functionService.findAllByLink(null, projectUnit, metaDataService.ltGroupMember)

        render template: 'activityTemplates', model: [activityTemplates: activityTemplates, unit: projectUnit, i: params.i, project: project]
    }

    def remoteActivityTemplateByLabel = {
        List labels = params.list('labels')

        List results = []

        List activityTemplates = Entity.createCriteria().list {
            eq("type", metaDataService.etTemplate)
            profile {
                eq("status", "done")
            }
        }

        labels.each { String label ->
            activityTemplates.each { Entity at ->
                if (at.profile.labels.find {it.name == label})
                    results.add(at)
            }
        }

        if (results.size() == 0) {
            render {span(class: 'italic', message(code: 'noResultsFound'))}
            return
        }
        else {
            render template: 'activitytemplateresults', model: [results: results, projectUnitID: params.id, i: params.i, project: params.project]
        }
    }

    def change_begin () {
        def projectDay = Entity.get(params.id)

        render template: 'edit_begin', model: [projectDay: projectDay]
    }

    def update_begin() {
        def projectDay = Entity.get(params.id)
        params.date = params.date('date', 'HH:mm')

        Calendar calendar = new GregorianCalendar()
        calendar.setTime(projectDay.profile.date)
        calendar.set(Calendar.HOUR, params.date.getHours())
        calendar.set(Calendar.MINUTE, params.date.getMinutes())
        params.date = calendar.getTime()

        projectDay.profile.date = functionService.convertToUTC(params.date)
        projectDay.profile.save()

        render template: 'show_begin', model: [projectDay: projectDay]
    }

    def change_end () {
        def projectDay = Entity.get(params.id)

        render template: 'edit_end', model: [projectDay: projectDay]
    }

    def update_end() {
        def projectDay = Entity.get(params.id)
        params.date = params.date('date', 'HH:mm')

        Calendar calendar = new GregorianCalendar()
        calendar.setTime(projectDay.profile.date)
        calendar.set(Calendar.HOUR, params.date.getHours())
        calendar.set(Calendar.MINUTE, params.date.getMinutes())
        params.date = calendar.getTime()

        projectDay.profile.endDate = functionService.convertToUTC(params.date)

        if (projectDay.profile.endDate < projectDay.profile.date)
            render template: 'edit_end', model: [projectDay: projectDay]
        else {
            projectDay.profile.save()
            render template: 'show_end', model: [projectDay: projectDay]
        }
    }

}

class ProjectCommand {
  String fullName
  Date startDate
  Date endDate

  Date mondayStart
  Date tuesdayStart
  Date wednesdayStart
  Date thursdayStart
  Date fridayStart
  Date saturdayStart
  Date sundayStart

    Date mondayEnd
    Date tuesdayEnd
    Date wednesdayEnd
    Date thursdayEnd
    Date fridayEnd
    Date saturdayEnd
    Date sundayEnd

  Boolean monday
  Boolean tuesday
  Boolean wednesday
  Boolean thursday
  Boolean friday
  Boolean saturday
  Boolean sunday

  Boolean weekdays

  static constraints = {
    fullName  blank: false

    startDate nullable: false
    endDate   nullable: false, validator: {val, obj ->
                                             return val > obj.startDate
                                          }
    //weekdays  validator: {val, obj ->
    //                        return !(!obj.monday && !obj.tuesday && !obj.wednesday && !obj.thursday && !obj.friday && !obj.saturday && !obj.sunday)
    //                     }
  }

}