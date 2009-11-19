import org.joda.time.DateTime
import org.joda.time.DateMidnight
import grails.converters.JSON
import de.uenterprise.ep.Entity

class CalendarController {

    def index = { }

    def show_ajax = { }

    def show  = {
        def prf = Entity.findByName(params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return
        }

        return [name:params.name]
    }

    def showall  = {
        return [name:'all']
    }

    def showall_month = {}
    def showall_week = {}
    def showall_day = {}

    // handles event requests
    def events = {
        params.name = params.name ?: 'all'
        println ("loading events for $params.name between $params.start and $params.end" )

        // find all activities for given profile
        def activities = Activity.findAllByOwner(Entity.findByName(params.name))

        // convert to fullCalendar events
        def eventList = []
        activities.each {
            //  convert the @45%&  date/time back to something known in the rest of the universe
            def dtStart = new DateTime (Date.parse("dd.MM.yyyy HH:mm", "$it.date"));
            dtStart = dtStart.plusHours(2)
            def dtEnd = dtStart.plusMinutes("$it.duration".toInteger());
            eventList << [id: it.id, title: it.title, start:dtStart.toDate(), end:dtEnd.toDate(), allDay:false]
        }

        def json = eventList as JSON;
        render json
    }
}
