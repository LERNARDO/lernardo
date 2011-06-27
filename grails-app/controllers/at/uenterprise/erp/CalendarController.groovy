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

  /*
   * shows the calendar
   */
  def show = {
    Entity currentEntity = entityHelperService.loggedIn

    //List visibleEducators = currentEntity?.profile?.calendar?.calendareds ?: []

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

    return ['educators': educators]
  }

  def getsources = {
  Entity currentEntity = entityHelperService.loggedIn

  def start = new Date()
  start.setTime(params.long('start') * 1000)

  def end = new Date()
  end.setTime(params.long('end') * 1000)

  //List visibleEducators = currentEntity?.profile?.calendar?.calendareds ?: []
  List eventList = []

   /* if (visibleEducators) {
      visibleEducators.each { ed ->

        Entity entity = Entity.get(ed.toInteger())
        println "ENTITY: " + entity

        List educators = Entity.findAllByType(metaDataService.etEducator)
        int index = educators.indexOf(ed.toInteger())
        def color = grailsApplication.config.colors[index]

        // get all appointments
        eventList.addAll(getAppointments(start, end, entity, currentEntity, color))

        // get all group activities the educator is part of
        eventList.addAll(getGroupActivities(start, end, entity, currentEntity, color))

        // get all themeroom activities the educator is part of
        eventList.addAll(getThemeRoomActivities(start, end, entity, currentEntity, color))

        // get all project units the educator is part of
        eventList.addAll(getProjectUnits(start, end, entity, currentEntity, color))

      }
    }*/

    def json = eventList as JSON
    render json
  }

  def addOrRemove = {
    //log.info params
    //log.info "toggling"

    def result

    Entity currentEntity = entityHelperService.loggedIn

    // find out whether to toggle the events of the given entity on or off
    List visibleEducators = currentEntity?.profile?.calendar?.calendareds ?: []

    if (visibleEducators.contains(params.id)) {
      currentEntity.profile.calendar.removeFromCalendareds(params.id)
      result = "false"
    }
    else {
      currentEntity.profile.calendar.addToCalendareds(params.id)
      result = "true"
    }

    render result
  }

  def toggleT = {
    def result

    Entity currentEntity = entityHelperService.loggedIn
    currentEntity.profile.calendar.showThemes = !currentEntity.profile.calendar.showThemes

    if (currentEntity.profile.calendar.showThemes)
      result = "true"
    else
      result = "false"

    render result
  }

  def toggleThemes = {
    def start = new Date()
    start.setTime(params.long('start') * 1000)

    def end = new Date()
    end.setTime(params.long('end') * 1000)

    Entity currentEntity = entityHelperService.loggedIn

    def eventList = []

    // get all themes
    eventList.addAll(getThemes(start, end, currentEntity, currentEntity, '#000000'))

    def json = eventList as JSON
    render json
  }

  def togglePerson = {
    //log.info "toggling person"

    def start = new Date()
    start.setTime(params.long('start') * 1000)
    //log.info start

    def end = new Date()
    end.setTime(params.long('end') * 1000)
    //log.info end

    Entity currentEntity = entityHelperService.loggedIn
    Entity entity = Entity.get(params.id)
    def eventList = []
    //log.info currentEntity
    //log.info entity

    List educators = Entity.findAllByType(metaDataService.etEducator)
    int index = educators.indexOf(entity)
    def color = grailsApplication.config.colors[index] ?: '#000000'
    //log.info color

    // get all appointments
    eventList.addAll(getAppointments(start, end, entity, currentEntity, color))
    //log.info eventList

    // get all group activities the educator is part of
    eventList.addAll(getGroupActivities(start, end, entity, currentEntity, color))
    //log.info eventList

    // get all themeroom activities the educator is part of
    eventList.addAll(getThemeRoomActivities(start, end, entity, currentEntity, color))
    //log.info eventList

    // get all project units the educator is part of
    eventList.addAll(getProjectUnits(start, end, entity, currentEntity, color))
    //log.info eventList

    def json = eventList as JSON
    render json
  }

  /*
   * retrieves the entries to display in the calendar
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
      def facility = functionService.findByLink(currentEntity, null, metaDataService.ltWorking)

      if (facility) {
        // find all educators working in that facility
        educators = functionService.findAllByLink(null, facility, metaDataService.ltWorking) // false IntelliJ warning
      }
    }
    else
      educators = Entity.findAllByType(metaDataService.etEducator)

    if (params.visibleEducators)
      params.visibleEducators = params.list('visibleEducators')

    // get events

    def eventList = []

    // get all own appointments
    if (currentEntity.type.id != metaDataService.etEducator.id) {
      eventList.addAll(getAppointments(start, end, currentEntity, currentEntity, '#0000ff'))
    }

    // get all themes
    if (currentEntity.profile.calendar.showThemes) {
        eventList.addAll(getThemes(start, end, currentEntity, currentEntity, '#000000'))
    }

    if (params.visibleEducators) {
      params.visibleEducators.each { ed ->
        Entity entity = Entity.get(ed)

        educators = Entity.findAllByType(metaDataService.etEducator)
        int index = educators.indexOf(entity)
        def color = grailsApplication.config.colors[index] ?: '#000000'

        // get all appointments
        eventList.addAll(getAppointments(start, end, entity, currentEntity, color))

        // get all group activities the educator is part of
        eventList.addAll(getGroupActivities(start, end, entity, currentEntity, color))

        // get all themeroom activities the educator is part of
        eventList.addAll(getThemeRoomActivities(start, end, entity, currentEntity, color))

        // get all project units the educator is part of
        eventList.addAll(getProjectUnits(start, end, entity, currentEntity, color))

      }
    }

    def json = eventList as JSON
    render json
  }

  List getAppointments(start, end, entity, currentEntity, color) {
    List list = []

    // get all appointments
    List appointments = functionService.findAllByLink(null, entity, metaDataService.ltAppointment)

    appointments?.findAll{(it.profile.beginDate >= start && it.profile.beginDate <= end) || (it.profile.endDate >= start && it.profile.endDate <= end)}?.each { Entity appointment ->
      def title = appointment.profile.isPrivate && entity.id != currentEntity.id ? "Termin: Nicht verfügbar" : "Termin: ${appointment.profile.fullName}"
      def description = appointment.profile.isPrivate && entity.id != currentEntity.id ? "<b>${message(code: 'description')}:</b> ${message(code: 'notAvailable')}" : "<b>${message(code: 'description')}:</b> ${appointment.profile.description}"
      list << [id: appointment.id, title: title, start: functionService.convertFromUTC(appointment.profile.beginDate), end: functionService.convertFromUTC(appointment.profile.endDate), allDay: appointment.profile.allDay, color: color, description: description]
    }

    return list
  }

  List getGroupActivities(start, end, entity, currentEntity, color) {
    List list = []

    // get all group activities the educator is part of
    List temp = Entity.findAllByType(metaDataService.etGroupActivity)

    List groupActivities = []
    temp.each { group ->
      def c = Link.createCriteria()
      def result = c.get {
        eq("source", entity)
        eq("target", group)
        eq("type", metaDataService.ltGroupMemberEducator)
      }
      if (result)
        groupActivities.add(group)
    }

    groupActivities.findAll{it.profile.date >= start && it.profile.date <= end}?.each { Entity groupActivity ->
      def dateStart = new DateTime(functionService.convertFromUTC(groupActivity.profile.date))
      def dateEnd = dateStart.plusMinutes("$groupActivity.profile.realDuration".toInteger())
      list << [id: groupActivity.id, title: "Aktivitätsblock: ${groupActivity.profile.fullName}", start: dateStart.toDate(), end: dateEnd.toDate(), allDay: false, color: color, description: "<b>Pädagogisches Ziel:</b> " + groupActivity.profile.educationalObjectiveText]
    }

    return list
  }

  List getThemeRoomActivities(start, end, entity, currentEntity, color) {
    List list = []

    def c = Entity.createCriteria()
    def temp = c.list {
      eq("type", metaDataService.etActivity)
      profile {
        eq("type", "Themenraum")
      }
    }

    List themeRoomActivities = []
    temp.each { activity ->
      def d = Link.createCriteria()
      def result = d.get {
        eq("source", entity)
        eq("target", activity)
        eq("type", metaDataService.ltActEducator)
      }
      if (result)
        themeRoomActivities.add(activity)
    }

    themeRoomActivities.findAll{it.profile.date >= start && it.profile.date <= end}?.each { Entity themeRoomActivity ->
      def dateStart = new DateTime(functionService.convertFromUTC(themeRoomActivity.profile.date))
      def dateEnd = dateStart.plusMinutes("$themeRoomActivity.profile.duration".toInteger())
      def description = "<b>${message(code: 'duration')}:</b> ${themeRoomActivity.profile.duration} min"
      list << [id: themeRoomActivity.id, title: "Themenraumaktivität: ${themeRoomActivity.profile.fullName}", start: dateStart.toDate(), end: dateEnd.toDate(), allDay: false, color: color, description: description]
    }

    return list
  }

  List getProjectUnits(start, end, entity, currentEntity, color) {
    List list = []

    // 1. find all project days the educator is linked to
    List projectDays = functionService.findAllByLink(entity, null, metaDataService.ltProjectDayEducator)

    List unitsDone = []
    if (projectDays) {
      projectDays.findAll{it.profile.date >= start && it.profile.date <= end}?.each { Entity projectDay ->
        // 2. for each project day find the project it belongs to
        Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

        // 3. for each project day get the project unit it is linked to
        List projectUnits = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

        if (projectUnits && project) {
          projectUnits.each { Entity projectUnit ->
            // make sure a unit is only displayed once
            if (!unitsDone.contains(projectUnit)) {
              unitsDone.add(projectUnit)

              def dateStart = new DateTime(functionService.convertFromUTC(projectUnit.profile.date))
              def dateEnd = dateStart.plusMinutes("$projectUnit.profile.duration".toInteger())
              def description = "<b>${message(code: 'cal.projectUnit')}:</b> ${projectUnit.profile.fullName}"

              list << [id: projectUnit.id, title: "${message(code: 'project')}: ${project.profile.fullName}", start:dateStart.toDate(), end:dateEnd.toDate(), allDay: false, color: color, description: description, one: projectDay.id]
            }
          }
        }
      }
    }

    return list
  }

  List getThemes(start, end, entity, currentEntity, color) {
    List list = []

    List themes = Entity.findAllByType(metaDataService.etTheme)

    themes?.each { Entity theme ->
      def dateEnd = new DateTime(functionService.convertFromUTC(theme.profile.endDate))
      dateEnd = dateEnd.plusHours(12) // workaround for theme duration displayed correctly in calendar
      def description = "<b>${message(code: 'description')}:</b> ${theme.profile.description}"
      list << [id: theme.id, title: "Thema: ${theme.profile.fullName}", start: functionService.convertFromUTC(theme.profile.startDate), end: dateEnd.toDate(), color: color, description: description]
    }

    return list
  }
}
