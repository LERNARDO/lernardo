package at.uenterprise.erp

import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.Entity

class ArticlePostController {
  EntityHelperService entityHelperService

  def index = {
    params.offset = params.offset ?: 0
    return ['articleList': ArticlePost.list([max: 10, sort: "dateCreated", order: "desc", offset: params.offset]),
            'listTitle': 'Aktuelle Ereignisse',
            'articleCount': ArticlePost.count()]
  }

  def show = {
    ArticlePost article = ArticlePost.get(params.id)
    if (article)
      return ['article': article]
    else
      redirect controller: "profile", action: "news"
    return
  }

  def edit = {
    ArticlePost article = ArticlePost.get(params.id)
    return ['postInstance': article]
  }

  def create = {
    ArticlePost article = new ArticlePost()
    article.properties = params
    return ['postInstance': article]
  }

  def delete = {
    ArticlePost article = ArticlePost.get(params.id)
    if (article) {
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "article"), article.title])
        article.delete(flush: true)
        redirect controller: "profile", action: "news"
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "article"), article.title])
        redirect controller: "profile", action: "news"
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "article")])
      redirect controller: "profile", action: "news"
    }
  }

  def save = {
    ArticlePost article = new ArticlePost(params)

    Entity currentEntity = entityHelperService.loggedIn

    article.author = currentEntity
    if (article.save()) {
      flash.message = message(code: "object.created", args: [message(code: "article"), article.title])
      redirect controller: "profile", action: "news"
    }
    else {
      render view:"create", model:[postInstance:article]
    }
  }

  def update = {
    ArticlePost article = ArticlePost.get(params.id)
    if (article) {
      article.properties = params
      if (article.save()) {
        flash.message = message(code: "object.updated", args: [message(code: "article"), article.title])
        redirect controller: "profile", action: "news"
      }
      else {
        render view: 'edit', model: [postInstance: article]
      }
    }
    else {
      flash.message = message(code: "post.notFound", args: [params.id])
      redirect controller: "profile", action: "news"
    }
  }
  
}
