package at.uenterprise.erp

import org.joda.time.DateTime
import grails.converters.JSON

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.Link

class CalendarController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService

  def index = {
    redirect action: 'show'
  }

  /*
   * redirects to the appropriate show view of the calendar entry that was clicked on
   */
  def destination = {
    Entity entity = Entity.get(params.id)
    if (entity.type.supertype.name == 'appointment') {
      if (entity.profile.isPrivate) {
        Entity currentEntity = entityHelperService.loggedIn

        // check if the appointment belongs to the current entity, if yes show it else do nothing
        def c = Link.createCriteria()
        def result = c.get {
          eq("source", entity)
          eq("target", currentEntity)
          eq("type", metaDataService.ltAppointment)
        }
        if (result)
          redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: params.id
        else
          redirect action: 'show'
      }
      else
        redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: params.id
    }
    else if (entity.type.supertype.name == 'projectUnit') {
        // find projectDay of projectUnit
        Entity projectDay = functionService.findByLink(entity, null, metaDataService.ltProjectDayUnit)

        // find project of projectDay
        Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

        redirect controller: 'projectProfile', action: 'show', id: project.id, params: [one: projectDay.id]
    }
    else
      redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: params.id
  }

  def updatecalendar = {
    Entity currentEntity = entityHelperService.loggedIn

    if (params.showThemes)
        currentEntity.profile.calendar.showThemes = !currentEntity.profile.calendar.showThemes

    if (params.id) {
        if (currentEntity.profile.calendar.calendareds.contains(params.id))
            currentEntity.profile.calendar.removeFromCalendareds(params.id)
        else
            currentEntity.profile.calendar.addToCalendareds(params.id)
    }

    List visibleEducators = currentEntity.profile.calendar.calendareds

    render template:"calendar", model: [visibleEducators: visibleEducators]
  }

  /*
   * shows the calendar
   */
  def show = {
    Entity currentEntity = entityHelperService.loggedIn

    List visibleEducators = currentEntity.profile.calendar.calendareds

    List educators = []

    if (currentEntity.type.name == metaDataService.etEducator) {
      // find facility the educator is working for
      def facility = functionService.findByLink(currentEntity, null, metaDataService.ltWorking)

      if (facility) {
        // find all educators working in that facility
        educators = functionService.findAllByLink(null, facility, metaDataService.ltWorking) // false IntelliJ warning
      }
    }
    else
      educators = Entity.findAllByType(metaDataService.etEducator)

    return ['visibleEducators': visibleEducators,
            'educators': educators]
  }

  /*
   * retrieves the entries to display in the calendar like activities or themes
   */
  def events = {
    def start = new Date()
    start.setTime(params.long('start') * 1000)

    def end = new Date()
    end.setTime(params.long('end') * 1000)

    Entity currentEntity = entityHelperService.loggedIn

    List educators = []

    if (currentEntity.type.name == metaDataService.etEducator) {
      // find facility the educator is working for
      def facility = functionService.findByLink(entity, null, metaDataService.ltWorking)

      if (facility) {
        // find all educators working in that facility
        educators = functionService.findAllByLink(null, facility, metaDataService.ltWorking) // false IntelliJ warning
      }
    }
    else
      educators = Entity.findAllByType(metaDataService.etEducator)

    List educatornumbers = educators.collect{it.id.toString()}

    if (params.visibleEducators)
      params.visibleEducators = params.list('visibleEducators')

    // get events

    def eventList = []

    if (currentEntity.type.id != metaDataService.etEducator.id) {
      // get all own appointments
      List ownappointments = functionService.findAllByLink(null, currentEntity, metaDataService.ltAppointment)

      ownappointments?.findAll{(it.profile.beginDate >= start && it.profile.beginDate <= end) || (it.profile.endDate >= start && it.profile.endDate <= end)}?.each {
        def title = "Termin: ${it.profile.fullName}"
        def description = "<b>${message(code: 'description')}:</b> ${it.profile.description}"
        eventList << [id: it.id, title: title, start: functionService.convertFromUTC(it.profile.beginDate), end: functionService.convertFromUTC(it.profile.endDate), allDay: it.profile.allDay, className: 'own-appointments', description: description]
      }
    }

    // get all themes
    if (currentEntity.profile.calendar.showThemes) {
        List themeList = Entity.findAllByType(metaDataService.etTheme)

        //themeList?.findAll{(it.profile.startDate >= start && it.profile.startDate <= end) || (it.profile.endDate >= start && it.profile.endDate <= end)}?.each {
        themeList?.each {
          def dateEnd = new DateTime(functionService.convertFromUTC(it.profile.endDate))
          dateEnd = dateEnd.plusHours(12) // workaround for theme duration displayed correctly in calendar
          def description = "<b>${message(code: 'description')}:</b> ${it.profile.description}"
          eventList << [id: it.id, title: "Thema: ${it.profile.fullName}", start: functionService.convertFromUTC(it.profile.startDate), end: dateEnd.toDate(), className: 'educator-1', description: description]
        }
    }

    if (params.visibleEducators) {
      params.visibleEducators.each { ed ->
        Entity educator = Entity.get(ed)
        def className = "educator" + educatornumbers.indexOf(ed)

        // get all appointments
        List appointments = functionService.findAllByLink(null, educator, metaDataService.ltAppointment)

        appointments?.findAll{(it.profile.beginDate >= start && it.profile.beginDate <= end) || (it.profile.endDate >= start && it.profile.endDate <= end)}?.each { Entity appointment ->
          def title = appointment.profile.isPrivate && educator.id != currentEntity.id ? "Termin: Nicht verfügbar" : "Termin: ${appointment.profile.fullName}"
          def description = appointment.profile.isPrivate && educator.id != currentEntity.id ? "<b>${message(code: 'description')}:</b> ${message(code: 'notAvailable')}" : "<b>${message(code: 'description')}:</b> ${appointment.profile.description}"
          eventList << [id: appointment.id, title: title, start: functionService.convertFromUTC(it.profile.beginDate), end: functionService.convertFromUTC(it.profile.endDate), allDay: appointment.profile.allDay, className: className, description: description]
        }

        // get all group activities the educator is part of
        List temp = Entity.findAllByType(metaDataService.etGroupActivity)

        List activityList = []
        temp.each { group ->
          def c = Link.createCriteria()
          def result = c.get {
            eq("source", educator)
            eq("target", group)
            eq("type", metaDataService.ltGroupMemberEducator)
          }
          if (result)
            activityList.add(group)
        }

        activityList.findAll{it.profile.date >= start && it.profile.date <= end}?.each {
          def dateStart = new DateTime(functionService.convertFromUTC(it.profile.date))
          def dateEnd = dateStart.plusMinutes("$it.profile.realDuration".toInteger())
          eventList << [id: it.id, title: "Aktivitätsblock: ${it.profile.fullName}", start: dateStart.toDate(), end: dateEnd.toDate(), allDay: false, className: className, description: "<b>Pädagogisches Ziel:</b> " + it.profile.educationalObjectiveText]
        }

        // get all themeroom activities the educator is part of
        def c = Entity.createCriteria()
        temp = c.list {
          eq("type", metaDataService.etActivity)
          profile {
            eq("type", "Themenraum")
          }
        }

        List themeRoomList = []
        temp.each { activity ->
          def d = Link.createCriteria()
          def result = d.get {
            eq("source", educator)
            eq("target", activity)
            eq("type", metaDataService.ltActEducator)
          }
          if (result)
            themeRoomList.add(activity)
        }

        themeRoomList.findAll{it.profile.date >= start && it.profile.date <= end}?.each {
          def dateStart = new DateTime(functionService.convertFromUTC(it.profile.date))
          def dateEnd = dateStart.plusMinutes("$it.profile.duration".toInteger())
          def description = "<b>${message(code: 'duration')}:</b> ${it.profile.duration} min"
          eventList << [id: it.id, title: "Themenraumaktivität: ${it.profile.fullName}", start: dateStart.toDate(), end: dateEnd.toDate(), allDay: false, className: className, description: description]

        }

        // get all project units the educator is part of

        // 1. find all project days the educator is linked to
        List projectDays = functionService.findAllByLink(educator, null, metaDataService.ltProjectDayEducator)

        List unitsDone = []
        if (projectDays) {
          projectDays.findAll{it.profile.date >= start && it.profile.date <= end}?.each { Entity projectDay ->
            // 2. for each project day find the project it belongs to
            Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

            // 3. for each project day get the project unit it is linked to
            List projectUnits = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

            if (projectUnits && project) {
              projectUnits.each { projectUnit ->
                // make sure a unit is only displayed once
                if (!unitsDone.contains(projectUnit)) {
                  unitsDone.add(projectUnit)

                  def dateStart = new DateTime(functionService.convertFromUTC(projectUnit.profile.date))
                  def dateEnd = dateStart.plusMinutes("$projectUnit.profile.duration".toInteger())
                  def description = "<b>${message(code: 'cal.projectUnit')}:</b> ${projectUnit.profile.fullName}"

                  eventList << [id: projectUnit.id, title: "${message(code: 'project')}: ${project.profile.fullName}", start:dateStart.toDate(), end:dateEnd.toDate(), allDay: false, className: className, description: description, one: projectDay.id]
                }
              }
            }
          }
        }

        /*List projectUnits = Entity.findAllByType(metaDataService.etProjectUnit)

        projectUnits.each {
          def dtStart = new DateTime (it.profile.date)
          //dtStart = dtStart.plusHours(1)
          def dtEnd = dtStart.plusMinutes("$it.profile.duration".toInteger())

          // get project day of project unit
          Entity projectDay = functionService.findByLink(it as Entity, null, metaDataService.ltProjectDayUnit)

          // get project of project day
          Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

          eventList << [id: it.id, title: " Projekteinheit: (${project.profile.fullName}) ${it.profile.fullName}", start:dtStart.toDate(), end:dtEnd.toDate(), allDay: false, className: className]
        }*/
      }
    }

    def json = eventList as JSON
    render json
  }
}
