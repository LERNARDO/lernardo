import org.joda.time.DateTime

import grails.converters.JSON
import de.uenterprise.ep.Entity
import lernardo.Activity

class CalendarController {
  def entityHelperService

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

        def activities = []
        // find all activities for given profile
        if (params.name == 'all')
          activities = Activity.list()
        else
          activities = Activity.findAllByOwner(Entity.findByName(params.name))

        // convert to fullCalendar events
        def eventList = []
        activities.each {
            def dtStart = new DateTime (it.date)
            dtStart = dtStart.plusHours(1)
            def dtEnd = dtStart.plusMinutes("$it.duration".toInteger())
            eventList << [id: it.id, title: it.title, start:dtStart.toDate(), end:dtEnd.toDate(), allDay:false, className: it.attribution]
        }

        def json = eventList as JSON;
        render json
    }
}
