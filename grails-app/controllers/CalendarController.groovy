import org.joda.time.DateTime

import grails.converters.JSON
import de.uenterprise.ep.Entity
import lernardo.Activity
import de.uenterprise.ep.Link

class CalendarController {
  def entityHelperService
  def metaDataService

    def index = { }

    def show_ajax = { }

    def show  = {
        def prf = Entity.findByName(params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return
        }

        return ['name': params.name]
    }

    def showall  = {
        return ['name':'all',
                'entity':entityHelperService.loggedIn]
    }

    def showall_month = {}
    def showall_week = {}
    def showall_day = {}

    // handles event requests
    def events = {
        params.name = params.name ?: 'all'
        log.debug ("loading events for $params.name between $params.start and $params.end" )

        // get a list of facilities the current entity is working in
        List facilities = Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking)
        List facilityList = []

        facilities.each {
          facilityList << it.target
        }

       // create empty list for final results
        List activityList = []

        def activities = []
        // find all activities for given profile
        if (params.name == 'all') {
          activities = Activity.list()
          // sort them out
          activities.each {
            for (f in facilityList) {
              if (it.facility == f)
                activityList << it
            }
          }
        }
        else {
          activityList = Activity.findAllByOwner(Entity.findByName(params.name))
          Activity.list().each {
            for (a in it.paeds) {
              if (a == Entity.findByName(params.name))
                activityList << it
            }
            for (a in it.clients) {
              if (a == Entity.findByName(params.name))
                activityList << it
            }
          }
        }

        // convert to fullCalendar events
        def eventList = []
        activityList.each {
            def dtStart = new DateTime (it.date)
            dtStart = dtStart.plusHours(1)
            def dtEnd = dtStart.plusMinutes("$it.duration".toInteger())
            eventList << [id: it.id, title: it.title, start:dtStart.toDate(), end:dtEnd.toDate(), allDay:false, className: it.attribution]
        }

        def json = eventList as JSON;
        render json
    }
}
