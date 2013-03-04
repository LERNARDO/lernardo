package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService

class CommentController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService
  ProfileHelperService profileHelperService

  def delete = {
    Entity entity = Entity.get(params.id)
    Comment comment = Comment.get(params.comment)

    entity.profile.removeFromComments(comment)
    comment.delete()

    render template: 'comments', model: [commented: entity]
  }

  def create = {
    render template: 'create', model: ['entity_id': params.id]
  }

  def save = {
      println params
    Entity entity = Entity.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn

    Comment comment = new Comment(content: params.comment_content, creator: currentEntity.id).save()
    entity.profile.addToComments(comment)

    functionService.createEvent(EVENT_TYPE.COMMENT_CREATED, currentEntity.id.toInteger(), entity.id.toInteger())

    render template: 'comments', model: [commented: entity]
  }

  def edit = {
    Entity entity = Entity.get(params.id)
    Comment comment = Comment.get(params.comment)
    render template: 'updatecomment', model: [commented: entity, comment: comment, i: params.i]
  }

  def update = {
    Entity entity = Entity.get(params.id)
    Comment comment = Comment.get(params.comment)
    comment.content = params.content
    comment.save()
    render template: 'comment', model: [i: params.i, comment: comment, commented: entity]
  }

  def list = {
  }

  def updatelist = {
    Date dateFrom = Date.parse("dd. MM. yy", params.dateFrom)
    Date dateTo = Date.parse("dd. MM. yy", params.dateTo) + 1

    List entities = []

    if (params.activitytemplates)
      entities.addAll(Entity.findAllByType(metaDataService.etTemplate))
    //if (params.projecttemplates)
      //entities.addAll(Entity.findAllByType(metaDataService.etProjectTemplate))
    if (params.projects)
      entities.addAll(Entity.findAllByType(metaDataService.etProject))

    Map comments = [:]

    entities.each { Entity entity ->
      entity.profile.comments.each { Comment comment ->
        if (comment.dateCreated >= dateFrom && comment.dateCreated <= dateTo) {
          comments.put(comment, entity)
        }
      }
    }
      
    render template: 'results', model: [comments: comments]

  }

  def show = {
    Entity entity = Entity.get(params.id)
    render template: "box", model: [commented: entity]
  }

}
