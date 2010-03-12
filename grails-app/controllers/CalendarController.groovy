import org.joda.time.DateTime

import grails.converters.JSON
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

class CalendarController {
  def entityHelperService
  def metaDataService

    def index = { }

    def showall  = {
      params.name = params.name ?: 'all'
      Entity entity = entityHelperService.loggedIn

      // find facility the educator is working for
      def link = Link.findBySourceAndType(entity, metaDataService.ltWorking)
      List educators = []
      if (link) {
        Entity facility = link.target

        // find all educators working in that facility
        def temp = Link.findAllByTargetAndType(facility, metaDataService.ltWorking)
        temp.each {
            educators << it.source
        }
      }

      return ['name':params.name,
              'entity':entityHelperService.loggedIn,
              'educators':educators]
    }

    // handles event requests
    def events = {
        params.name = params.name ?: 'all'
        log.debug ("loading events for $params.name between $params.start and $params.end" )

        // get a list of facilities the current entity is working in
        def links = Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking)
        List facilities = []

        links.each {
          facilities << it.target
        }

       // create empty list for final results
        List activityList = []

        def activities = []
        // find all activities for given profile
        if (params.name == 'all') {

          facilities.each {
            List tempList = Link.findAllBySourceAndType(it, metaDataService.ltActFacility)

            tempList.each {bla ->
              activityList << bla.target
              }
          }

/*          activities = Activity.list()
          // sort them out
          activities.each {
            for (f in facilityList) {
              if (it.facility == f)
                activityList << it
            }
          }*/
        }
        else {
          // TODO: return only activities of the logged in entity
          facilities.each {
            List tempList = Link.findAllBySourceAndType(it, metaDataService.ltActFacility)

            tempList.each {bla ->
              activityList << bla.target
              }
          }
        }

        // convert to fullCalendar events
        def eventList = []
        activityList.each {
            def dtStart = new DateTime (it.profile.date)
            dtStart = dtStart.plusHours(1)
            def dtEnd = dtStart.plusMinutes("$it.profile.duration".toInteger())
            def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
            eventList << [id: it.id, title: it.profile.fullName, start:dtStart.toDate(), end:dtEnd.toDate(), allDay:false, className: className]
        }

        def json = eventList as JSON;
        render json
    }
}
