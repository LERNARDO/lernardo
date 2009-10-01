import org.joda.time.DateTime
import org.joda.time.DateMidnight
import grails.converters.JSON

class CalendarController {
    def profileDataService ;
    def activityDataService ;

    def index = { }

    def show_ajax = { }

    def show  = {
        def prf = profileDataService.getProfile (params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return ;
        }

        return [name:params.name]
    }

    def showall  = {
        return [name:'all']
    }

    // handles event requests
    def events = {
        params.name = params.name ?: 'all'
        println ("loading events for $params.name between $params.start and $params.end" )

        // find all activities for given profile
        def activities = getActivitiesForProfile (params.name)

        // convert to fullCalendar events
        def eventList = []
        activities.each {
            //  convert the @45%&  date/time back to something known in the rest of the universe
            def dtStart = new DateTime (Date.parse("dd.MM.yyyy HH:mm", "$it.date $it.startTime")) ;
            dtStart = dtStart.plusHours(2)
            def dtEnd = dtStart.plusMinutes("$it.duration".toInteger()); //dtStart.plusHours(2) ;
            eventList << [id: it.id, title: it.title, start:dtStart.toDate() , end:dtEnd.toDate(), allDay:false]
        }

        def json = eventList as JSON ;
        render json
    }

    def getActivitiesForProfile (String name) {
        if (name == 'all')
        return MockUtil.asList(activityDataService.activities)

        def prf = profileDataService.getProfile (name)
        if (!prf)
        return null ;

        def activities = null ;
        switch (prf.type) {
            case 'paed':
            case 'client':
            activities = activityDataService.findActivitiesByNameAndType (name, prf.type)
            break ;

            case 'einrichtung':
            activities = MockUtil.asList(activityDataService.activities)
            activities = MockUtil.filter(activities, "einrichtung", name)
            break ;

            case 'betreiber':
            // todo: aggregate from all related einrichtungen
            activities = MockUtil.asList(activityDataService.activities)
            break ;

            case 'mitarbeiter':
            // todo: figure out if a MA should have a calendar at all (and if yes, what the �$% should be in it)
            activities = []
            break ;

            default:
            activities = MockUtil.asList(activityDataService.activities)
        }

        return activities ;
    }
}
