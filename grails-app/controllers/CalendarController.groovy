import org.joda.time.DateTime

import grails.converters.JSON
import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService

class CalendarController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService

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
    Entity currentEntity = entityHelperService.loggedIn

    Entity entity = params.id ? Entity.get(params.id) : currentEntity

    List educators = []

    if (currentEntity.type.name == metaDataService.etEducator) {
      // find facility the educator is working for
      Link link = Link.findBySourceAndType(entity, metaDataService.ltWorking)

      if (link) {
        Entity facility = link.target

        // find all educators working in that facility
        def links = Link.findAllByTargetAndType(facility, metaDataService.ltWorking)
        educators = links.collect {it.source}
      }
    }
    else
      educators = Entity.findAllByType(metaDataService.etEducator)

    return ['id': params.id,
            'educators': educators,
            'active': entity]
  }

  /*
   * retrieves the entries to display in the calendar like activities or themes
   */
  def events = {
    def eventList = []

    // get groupactivities
    List activityList = Entity.findAllByType(metaDataService.etGroupActivity)

    activityList.each {
      def dtStart = new DateTime(it.profile.date)
      dtStart = dtStart.plusHours(2)
      def dtEnd = dtStart.plusMinutes("$it.profile.realDuration".toInteger())
      //def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
      eventList << [id: it.id, title: it.profile.fullName, start: dtStart.toDate(), end: dtEnd.toDate(), allDay: false, className: 'group']
    }

    // get themes
    List themeList = Entity.findAllByType(metaDataService.etTheme)

    themeList.each {
      def dtStart = new DateTime(it.profile.startDate)
      dtStart = dtStart.plusHours(2)
      def dtEnd = new DateTime(it.profile.endDate)
      dtEnd = dtEnd.plusHours(12) // workaround for theme duration displayed correctly in calendar
      //def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
      eventList << [id: it.id, title: it.profile.fullName, start: dtStart.toDate(), end: dtEnd.toDate(), className: 'theme']
    }

    // get themeroomactivities
    def c = Entity.createCriteria()
    List themeroomList = c.list {
      eq("type", metaDataService.etActivity)
      profile {
        eq("type", "Themenraum")
      }
    }

    themeroomList.each {
      def dtStart = new DateTime(it.profile.date)
      dtStart = dtStart.plusHours(2)
      def dtEnd = dtStart.plusMinutes("$it.profile.duration".toInteger())
      //def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
      eventList << [id: it.id, title: it.profile.fullName, start: dtStart.toDate(), end: dtEnd.toDate(), allDay: false, className: 'activity']

    }

    // get project units
    /*  List projectUnits = Entity.findAllByType(metaDataService.etProjectUnit)

    projectUnits.each {
      def dtStart = new DateTime (it.profile.startDate)
      //dtStart = dtStart.plusHours(1)
      def dtEnd = dtStart.plusMinutes("$it.profile.duration".toInteger())
      //def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
      eventList << [id: it.id, title: it.profile.fullName, start:dtStart.toDate(), end:dtEnd.toDate(), className: 'projectunit']
    }  */


    def json = eventList as JSON;
    render json
  }
}
