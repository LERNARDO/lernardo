package at.uenterprise.erp

import java.text.SimpleDateFormat
import at.openfactory.ep.Entity

class EventController {

  /*
   * shows the events page
   */
  def index = {
    params.sort = 'dateCreated'
    params.order = 'desc'
    params.max = params.max ?: 10
    
    List events = Event.list(params)

    return [events: events,
            totalEvents: Event.count()]
  }
  
  def delete = {
    Event event = Event.get(params.id)
    
    event.delete(flush: true)

    redirect action: 'index'
  }
  
  def indexNew = {
    params.sort = 'dateCreated'
    params.order = 'desc'
    params.max = params.max ?: 10
        
    List events = Event.list(params)
    List news = News.list([max: 5, sort: "dateCreated", order: "desc", offset: params.offset])
    
    return [events: events,
            totalEvents: Event.count(),
            news:  news,
            newsCount: News.count()]
  }
}
