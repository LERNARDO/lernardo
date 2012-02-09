package at.uenterprise.erp

import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.Entity

class NewsController {
  EntityHelperService entityHelperService

  def index = {
    params.max = params.int('max') ?: 5
    params.offset = params.int('offset') ?: 0
    List news = News.list([max: params.max, sort: "dateCreated", order: "desc", offset: params.offset])

    return [news: news,
            newsCount: News.count()]
  }

  def show = {
    News news = News.get(params.id)
    if (news)
      return [news: news]
    else
      redirect controller: "news", action: "index"
    return
  }

  def edit = {
    News news = News.get(params.id)
    return [news: news]
  }

  def create = {
    News news = new News()
    news.properties = params
    return [news: news]
  }

  def delete = {
    News news = News.get(params.id)
    if (news) {
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "news"), news.title])
        news.delete(flush: true)
        redirect controller: "event", action: "index"
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "news"), news.title])
        redirect controller: "event", action: "index"
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "news")])
      redirect controller: "event", action: "index"
    }
  }

  def save = {
    News news = new News(params)

    Entity currentEntity = entityHelperService.loggedIn

    news.author = currentEntity
    if (news.save()) {
      flash.message = message(code: "object.created", args: [message(code: "news"), news.title])
      redirect controller: "event", action: "index"
    }
    else {
      render view:"create", model:[news: news]
    }
  }

  def update = {
    News news = News.get(params.id)
    if (news) {
      news.properties = params
      if (news.save()) {
        flash.message = message(code: "object.updated", args: [message(code: "news"), news.title])
        redirect controller: "event", action: "index"
      }
      else {
        render view: 'edit', model: [news: news]
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "news")])
      redirect controller: "event", action: "index"
    }
  }
  
}
