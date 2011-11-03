package at.uenterprise.erp

import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.Entity

class NewsController {
  EntityHelperService entityHelperService

  def show = {
    News news = News.get(params.id)
    if (news)
      return [news: news]
    else
      redirect controller: "profile", action: "news"
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
        redirect controller: "profile", action: "news"
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "news"), news.title])
        redirect controller: "profile", action: "news"
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "news")])
      redirect controller: "profile", action: "news"
    }
  }

  def save = {
    News news = new News(params)

    Entity currentEntity = entityHelperService.loggedIn

    news.author = currentEntity
    if (news.save()) {
      flash.message = message(code: "object.created", args: [message(code: "news"), news.title])
      redirect controller: "profile", action: "news"
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
        redirect controller: "profile", action: "news"
      }
      else {
        render view: 'edit', model: [news: news]
      }
    }
    else {
      flash.message = message(code: "post.notFound", args: [params.id])
      redirect controller: "profile", action: "news"
    }
  }
  
}
