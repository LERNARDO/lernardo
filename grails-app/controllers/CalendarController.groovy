import org.joda.time.DateTime

import grails.converters.JSON
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityHelperService

class CalendarController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService

    def index = {
      redirect action:'show'
    }

    def show = {
      Entity entity = params.id ? Entity.get(params.id) : entityHelperService.loggedIn

      List educators = []
      
      if (entityHelperService.loggedIn.type.name == metaDataService.etEducator) {
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

      return ['id':params.id,
              'entity':entityHelperService.loggedIn,
              'educators':educators,
              'active': entity]
    }

    // handles event requests
    def events = {
          Entity entity = params.id ? Entity.get(params.id) : entityHelperService.loggedIn
      
          // create empty list for final results
          List activityList = []

          if (entityHelperService.loggedIn.type.name == metaDataService.etEducator.name) {
            // get a list of facilities the current entity is working in
            def links = Link.findAllBySourceAndType(entity, metaDataService.ltWorking)
            List facilities = links.collect {it.target}

            // find all activities for the given facility or facilities 
            facilities.each {
              List tempList = Link.findAllBySourceAndType(it, metaDataService.ltActFacility)

              tempList.each {bla ->
                activityList << bla.target
                }
            }
          }
          else
            activityList = Entity.findAllByType(metaDataService.etActivity)

        // convert to fullCalendar events
        def eventList = []
        activityList.each {
            def dtStart = new DateTime (it.profile.date)
            dtStart = dtStart.plusHours(1)
            def dtEnd = dtStart.plusMinutes("$it.profile.duration".toInteger())
            //def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
            eventList << [id: it.id, title: it.profile.fullName, start:dtStart.toDate(), end:dtEnd.toDate(), allDay:false/*, className: className*/]
        }

        def json = eventList as JSON;
        render json
    }
}
