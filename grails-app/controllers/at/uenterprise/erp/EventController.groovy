package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService

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
    params.readOnly = true
    List events = Event.list(params)
    def totalEvents = Event.count()

    render template: 'events', model: [events: events, totalEvents: totalEvents]
  }

  def remoteNews = {
    params.max = 5
    params.sort = 'dateCreated'
    params.order = 'desc'
    params.readOnly = true
    List news = News.list(params)
    def totalNews = News.count()

    render template: 'news', model: [news: news, totalNews: totalNews]
  }
}
