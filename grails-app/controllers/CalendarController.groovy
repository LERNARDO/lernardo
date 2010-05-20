import org.joda.time.DateTime

import grails.converters.JSON
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityHelperService
import standard.MetaDataService

class CalendarController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService

    def index = {
      redirect action:'show'
    }

    def destination = {
      Entity entity = Entity.get(params.id)
      redirect controller: entity.type.supertype.name + 'Profile', action:'show', id: params.id  
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
        //Entity entity = params.id ? Entity.get(params.id) : entityHelperService.loggedIn

        // create empty list for final results
/*        List activityList = []

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
        }*/

        def eventList = []

        // get groupactivities
        List activityList = Entity.findAllByType(metaDataService.etGroupActivity)

        activityList.each {
            def dtStart = new DateTime (it.profile.date)
            dtStart = dtStart.plusHours(1)
            def dtEnd = dtStart.plusMinutes("$it.profile.realDuration".toInteger())
            //def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
            eventList << [id: it.id, title: it.profile.fullName, start:dtStart.toDate(), end:dtEnd.toDate(), allDay:false, className: 'group']
        }

        // get themes
        List themeList = Entity.findAllByType(metaDataService.etTheme)

        themeList.each {
          def dtStart = new DateTime (it.profile.startDate)
          dtStart = dtStart.plusHours(1)
          def dtEnd = new DateTime (it.profile.endDate)
          //def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
          eventList << [id: it.id, title: it.profile.fullName, start:dtStart.toDate(), end:dtEnd.toDate(), className: 'theme']

        }

        // get themeroomactivities
        List themeroomList = Entity.findAllByType(metaDataService.etActivity)

        themeroomList.each {
          def dtStart = new DateTime (it.profile.date)
          dtStart = dtStart.plusHours(1)
          def dtEnd = dtStart.plusMinutes("$it.profile.duration".toInteger())
          //def className = Link.findByTargetAndType(it, metaDataService.ltCreator).source.name
          eventList << [id: it.id, title: it.profile.fullName, start:dtStart.toDate(), end:dtEnd.toDate(), allDay:false, className: 'activity']

        }

        def json = eventList as JSON;
        render json
    }
}
