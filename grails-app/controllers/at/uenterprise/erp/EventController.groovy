package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class EventController {
  EntityHelperService entityHelperService

  def index = {
  }

  def delete = {
    Event event = Event.get(params.id)
    event.delete(flush: true)
    redirect action: 'index'
  }

  def remoteEvents = {
    params.max = 10
    params.sort = 'dateCreated'
    params.order = 'desc'
    List events = Event.list(params)
    def totalEvents = Event.count()
    Entity currentEntity = entityHelperService.loggedIn
    
    render template: 'events', model: [events: events, totalEvents: totalEvents, currentEntity: currentEntity]
  }

  def remoteNews = {
    params.max = 5
    params.sort = 'dateCreated'
    params.order = 'desc'
    List news = News.list(params)
    def totalNews= News.count()
    Entity currentEntity = entityHelperService.loggedIn

    render template: 'news', model: [news: news, totalNews: totalNews, currentEntity: currentEntity]
  }
}
