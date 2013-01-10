package at.uenterprise.erp

import org.joda.time.DateTime
import grails.converters.JSON

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.EntityType

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
        def result = Link.createCriteria().get {
          eq("source", entity)
          eq("target", currentEntity)
          eq("type", metaDataService.ltAppointment)
        }
        if (result)
          redirect controller: currentEntity.type.supertype.name + 'Profile', action: 'show', id: currentEntity.id, params: [ajax: 'appointments', ajaxId: entity.id]
        else
          redirect action: 'show'
      }
      else {
        Entity owner = functionService.findByLink(entity, null, metaDataService.ltAppointment)
        redirect controller: owner.type.supertype.name + 'Profile', action: 'show', id: owner.id, params: [ajax: 'appointments', ajaxId: entity.id]
      }
    }
    else if (entity.type.supertype.name == 'projectUnit') {
        // find projectDay of projectUnit
        Entity projectDay = functionService.findByLink(entity, null, metaDataService.ltProjectDayUnit)

        // find project of projectDay
        Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

        redirect controller: 'projectProfile', action: 'show', id: project.id, params: [entity: params.id, one: projectDay.id]
    }
    else
      redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: params.id
  }

  /*
   * shows the calendar
   */
  def show = {
    Entity currentEntity = entityHelperService.loggedIn

    List calEntities = currentEntity?.profile?.calendar?.entities?.toArray()
    calEntities = calEntities.sort {it.entity.profile.fullName}

    List operators = Entity.findAllByType(metaDataService.etOperator)

    return [calEntities: calEntities, operators: operators]
  }

  def sort = {
    Entity currentEntity = entityHelperService.loggedIn
    Set calEntities = currentEntity?.profile?.calendar?.entities
    render template: 'educators', model: [calEntities: calEntities]
  }
  
  def addEntity = {
    Entity currentEntity = entityHelperService.loggedIn
    Entity entity = Entity.get(params.id)
    
    if (!currentEntity.profile.calendar.entities.find {it.entity.id.toString() == params.id.toString()}) {
      CalEntity calEntity = new CalEntity(entity: entity, visible: true, color: "#cccccc").save()
      currentEntity.profile.calendar.addToEntities(calEntity)
      currentEntity.profile.save()
    }

    redirect action: "show"
  }

  def removeEntity = {
    Entity currentEntity = entityHelperService.loggedIn
    CalEntity calEntity = CalEntity.get(params.id)

    currentEntity.profile.calendar.removeFromEntities(calEntity)
    currentEntity.profile.save()

    redirect action: "show"
  }

  def togglePersonInCal = {
    ECalendar.withTransaction {
    def result

    Entity currentEntity = entityHelperService.loggedIn

    CalEntity calEntity = currentEntity?.profile?.calendar?.entities?.find {it.entity.id.toString() == params.id.toString()} 
      
    if (calEntity.visible) {
      calEntity.visible = false
      result = "false"
    }
    else {
      calEntity.visible = true
      result = "true"
    }
    calEntity.save(flush: true)

    render result
    }
  }

  def toggleThemesInCal = {
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
    def start = new Date()
    start.setTime(params.long('start') * 1000)

    def end = new Date()
    end.setTime(params.long('end') * 1000)

    Entity currentEntity = entityHelperService.loggedIn
    Entity entity = Entity.get(params.id)
    def eventList = []

    def color = currentEntity.profile.calendar.entities.find {it.entity.id.toString() == params.id.toString()}.color//entity.profile.color ?: '#aaa'

    // get all appointments
    eventList.addAll(getAppointments(start, end, entity, currentEntity, color))

    // get all project units
    eventList.addAll(getProjectUnits(start, end, entity, currentEntity, color))

    // get all project unit placeholders
    eventList.addAll(getProjectUnitPlaceHolders(start, end, entity, currentEntity, color))

    def json = eventList as JSON
    render json
  }

  List getAppointments(start, end, entity, currentEntity, color) {
    List list = []

    // get all appointments
    List appointments = functionService.findAllByLink(null, entity, metaDataService.ltAppointment)

    appointments?.findAll{(it.profile.beginDate >= start && it.profile.beginDate <= end) || (it.profile.endDate >= start && it.profile.endDate <= end)}?.each { Entity appointment ->
      def title = appointment.profile.isPrivate && entity.id != currentEntity.id ? "${message(code: 'appointment')}: ${message(code: 'notAvailable')}" : "${message(code: 'appointment')}: ${appointment.profile}"
      def description = appointment.profile.isPrivate && entity.id != currentEntity.id ? "<b>${message(code: 'description')}:</b> ${message(code: 'notAvailable')}" : "<b>${message(code: 'description')}:</b> ${appointment.profile.description}"
      list << [id: appointment.id, title: title, start: functionService.convertFromUTC(appointment.profile.beginDate), end: functionService.convertFromUTC(appointment.profile.endDate), allDay: appointment.profile.allDay, color: color, description: description]
    }

    return list
  }

  List getProjectUnits(start, end, entity, currentEntity, color) {
    List list = []

    // 1. find all project days
    List projectDays = functionService.findAllByLink(entity, null, metaDataService.ltProjectDayEducator)

    List moreDays = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
      EntityType etProjectDay = metaDataService.etProjectDay
      moreDays.each { Entity day ->
          if (day.type.id == etProjectDay.id)
              projectDays.add(day)
      }

    List unitsDone = []
    if (projectDays) {
      projectDays.findAll{it.profile.date >= start && it.profile.date <= end}?.each { Entity projectDay ->
        // 2. for each project day find the project it belongs to
        Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

        List responsibles = functionService.findAllByLink(null, project, metaDataService.ltResponsible)

          // 3. for each project day get the project units it is linked to
        List projectUnits = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

        if (projectUnits && project) {
          projectUnits.each { Entity projectUnit ->
            // make sure a unit is only displayed once
            if (!unitsDone.contains(projectUnit)) {
              unitsDone.add(projectUnit)

              def dateStart = new DateTime(functionService.convertFromUTC(projectUnit.profile.date))
              def dateEnd = dateStart.plusMinutes("$projectUnit.profile.duration".toInteger())
              def description = "<b>${message(code: 'cal.projectUnit')}:</b> ${projectUnit.profile}<br/>"
              description += "<b>${message(code: 'projectDayComplete')}:</b> ${formatBoolean(boolean: projectDay.profile.complete, true: message(code: 'yes'), false: message(code: 'no'))}<br/>"
              description += "<b>${message(code: 'responsible')}:</b> "

                responsibles.each { responsible ->
                    description += "${responsible.profile}<br/>"
                }

              list << [id: projectUnit.id, title: "${message(code: 'project')}: ${project.profile}", start:dateStart.toDate(), end:dateEnd.toDate(), allDay: false, color: color, description: description, one: projectDay.id]
            }
          }
        }
      }
    }

    return list
  }

  List getProjectUnitPlaceHolders(start, end, entity, currentEntity, color) {
      List list = []

      // 1. find all project days the educator is linked to
      List projectDays = functionService.findAllByLink(entity, null, metaDataService.ltProjectDayEducator)

      List unitsDone = []
      if (projectDays) {
        projectDays.findAll{it.profile.date >= start && it.profile.date <= end}?.each { Entity projectDay ->
          // 2. for each project day find the project it belongs to
          Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

          List responsibles = functionService.findAllByLink(null, project, metaDataService.ltResponsible)

          // 3. for each project day get the project unit it is linked to
          List projectUnits = functionService.findAllByLink(null, projectDay, metaDataService.ltProjectDayUnit)

          if (!projectUnits) {
            def dateStart = new DateTime(functionService.convertFromUTC(projectDay.profile.date))
            def dateEnd = dateStart.plusMinutes(60)
            def description = "${message(code: 'project')}: ${project.profile}<br/>"
            description += "<b>${message(code: 'projectDayComplete')}:</b> ${formatBoolean(boolean: projectDay.profile.complete, true: message(code: 'yes'), false: message(code: 'no'))}<br/>"
            description += "<b>${message(code: 'responsible')}:</b> "

            responsibles.each { responsible ->
                description += "${responsible.profile}<br/>"
            }

            list << [id: project.id, title: "${message(code: 'projectUnits.unplanned')}", start:dateStart.toDate(), end:dateEnd.toDate(), allDay: false, color: color, description: description, one: projectDay.id]
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
      list << [id: theme.id, title: "${message(code: 'theme')}: ${theme.profile}", start: functionService.convertFromUTC(theme.profile.startDate), end: dateEnd.toDate(), color: color, description: description]
    }

    return list
  }

  def search = {

    if (params.name == "") {
      render ""
      return
    }
    else if (params.name.size() < 2) {
        render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    List searchStrings = params.name.toString().split(" ")

    def all_results = Entity.createCriteria().listDistinct {
      user {
        eq("enabled", true)
      }
      or {
        if (params.child)
          eq("type", metaDataService.etChild)
        if (params.client)
          eq("type", metaDataService.etClient)
        if (params.educator)
          eq("type", metaDataService.etEducator)
        if (params.facility)
          eq("type", metaDataService.etFacility)
        if (params.operator)
          eq("type", metaDataService.etOperator)
        if (params.parent)
          eq("type", metaDataService.etParent)
        if (params.partner)
          eq("type", metaDataService.etPartner)
        if (params.pate)
          eq("type", metaDataService.etPate)
        if (params.family)
          eq("type", metaDataService.etGroupFamily)
        if (params.colony)
          eq("type", metaDataService.etGroupColony)
        if (params.groupClient)
          eq("type", metaDataService.etGroupClient)
        if (params.groupPartner)
          eq("type", metaDataService.etGroupPartner)
        if (params.projectTemplate)
          eq("type", metaDataService.etProjectTemplate)
        if (params.project)
          eq("type", metaDataService.etProject)
        if (params.user)
          eq("type", metaDataService.etUser)
      }
      profile {
        and {
          searchStrings.each {String s ->
            ilike('fullName', "%" + s + "%")
          }
        }
        order('fullName','asc')
      }
      // maxResults(5)
    }

    def results = all_results
    if ( all_results.size() > 5 ) {
      results = all_results.subList(0,5)
    }

    render template: 'searchresults', model: [results: results]
  }

  def updateColor = {
    Entity currentEntity = entityHelperService.loggedIn

    CalEntity calEntity = CalEntity.get(params.id)
    calEntity.color = params.color
    calEntity.save()

    redirect action: "show"
  }
}
