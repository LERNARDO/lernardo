import org.joda.time.DateTime

import grails.converters.JSON
import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import standard.FunctionService
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
    if (entity.type.supertype.name == 'activity')
      redirect controller: entity.type.supertype.name, action: 'show', id: params.id
    else
      redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: params.id
  }

  /*
   * shows the calendar
   */
  def show = {
    //println "params of show view: ${params}"
    Entity currentEntity = entityHelperService.loggedIn

    List visibleEducators = []

    Entity entity = params.id ? Entity.get(params.id) : currentEntity

    if (params.visibleEducators) {
      params.visibleEducators = params.list('visibleEducators')
      visibleEducators.addAll(params.visibleEducators)
    }

    //println "educator to add: ${entity.id}"
    //println "current list: ${visibleEducators}"
    //println "already in list: ${visibleEducators.contains(entity.id.toString())}"

    if (visibleEducators.contains(entity.id.toString())) {
      //println "removing ${entity.id}"
      visibleEducators.remove(entity.id.toString())
    }
    else
      if(entity.type.id == metaDataService.etEducator.id) {
        //println "adding ${entity.id}"
        visibleEducators.add(entity.id)
      }

    //println "new list: ${visibleEducators}"

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

    return ['visibleEducators': visibleEducators,
            'educators': educators]
  }

  /*
   * retrieves the entries to display in the calendar like activities or themes
   */
  def events = {
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

    params.visibleEducators = params.list('visibleEducators')

    // get events

    def eventList = []

    // get all themes the educator is part of
    List themeList = Entity.findAllByType(metaDataService.etTheme)

    themeList?.each {
      def dtStart = new DateTime(it.profile.startDate)
      dtStart = dtStart.plusHours(2)
      def dtEnd = new DateTime(it.profile.endDate)
      dtEnd = dtEnd.plusHours(12) // workaround for theme duration displayed correctly in calendar
      eventList << [id: it.id, title: "Thema: ${it.profile.fullName}", start: dtStart.toDate(), end: dtEnd.toDate(), className: 'educator-1']
    }

    params.visibleEducators?.each { ed ->
      Entity educator = Entity.get(ed)
      def className = "educator" + educatornumbers.indexOf(ed)

      // get all appointments
      List appointments = functionService.findAllByLink(null, educator, metaDataService.ltAppointment)

      appointments?.each {
        def dtStart = new DateTime(it.profile.beginDate)
        dtStart = dtStart.plusHours(2)
        def dtEnd = new DateTime(it.profile.endDate)
        def title = it.profile.isPrivate ? "Termin: Nicht verfügbar" : "Termin: ${it.profile.fullName}"
        eventList << [id: it.id, title: title, start: dtStart.toDate(), end: dtEnd.toDate(), className: className, description: "<b>Beschreibung:</b> " + it.profile.description]
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

      activityList?.each {
        def dtStart = new DateTime(it.profile.date)
        dtStart = dtStart.plusHours(2)
        def dtEnd = dtStart.plusMinutes("$it.profile.realDuration".toInteger())
        eventList << [id: it.id, title: "Aktivitätsblock: ${it.profile.fullName}", start: dtStart.toDate(), end: dtEnd.toDate(), allDay: false, className: className, description: "<b>Pädagogisches Ziel:</b> " + it.profile.educationalObjectiveText]
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

      themeRoomList?.each {
        def dtStart = new DateTime(it.profile.date)
        dtStart = dtStart.plusHours(2)
        def dtEnd = dtStart.plusMinutes("$it.profile.duration".toInteger())
        eventList << [id: it.id, title: "Themenraumaktivität: ${it.profile.fullName}", start: dtStart.toDate(), end: dtEnd.toDate(), allDay: false, className: className, description: "<b>Dauer:</b> " + it.profile.duration + " min"]

      }

      // get all project units the educator is part of

      // 1. find all project days the educator is linked to
      List projectDays = functionService.findAllByLink(educator, null, metaDataService.ltProjectDayEducator)

      List unitsDone = []
      projectDays?.each { projectDay ->
        // 2. for each project day find the project it belongs to
        Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)

        // 3. for each project day get the project unit it is linked to
        Entity projectUnit = functionService.findByLink(null, projectDay, metaDataService.ltProjectDayUnit)
        // make sure a unit is only displayed once
        if (!unitsDone.contains(projectUnit)) {
          unitsDone.add(projectUnit)

          def dtStart = new DateTime (projectUnit.profile.date)
          def dtEnd = dtStart.plusMinutes("$projectUnit.profile.duration".toInteger())

          eventList << [id: project.id, title: " Projekteinheit: ${projectUnit.profile.fullName}", start:dtStart.toDate(), end:dtEnd.toDate(), allDay: false, className: className, description: "<b>Projekt:</b> " + project.profile.fullName]
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

    def json = eventList as JSON;
    render json
  }
}
