package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService

class CommentController {
  EntityHelperService entityHelperService
  FunctionService functionService
  MetaDataService metaDataService
  ProfileHelperService profileHelperService

  def delete = {
    Entity entity = Entity.get(params.id)
    Comment comment = Comment.get(params.comment)
    Entity currentEntity = entityHelperService.loggedIn

    entity.profile.removeFromComments(comment)
    comment.delete()

    render template:'comments', model:[commented: entity, currentEntity: currentEntity]
  }

  def create = {
    render template: 'create', model: ['entity_id': params.id]
  }

  def save = {
    Entity entity = Entity.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn

    Comment comment = new Comment(content: params.content, creator: currentEntity.id).save()
    entity.profile.addToComments(comment)

    functionService.createEvent(EVENT_TYPE.COMMENT_CREATED, currentEntity.id.toInteger(), entity.id.toInteger())

    render template:'comments', model:[commented: entity, currentEntity: currentEntity]
  }

  def edit = {
    Entity entity = Entity.get(params.id)
    Comment comment = Comment.get(params.comment)
    render template:'updatecomment', model:[commented: entity, comment: comment, i: params.i]
  }

  def update = {
    Entity entity = Entity.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn
    Comment comment = Comment.get(params.comment)
    comment.content = params.content
    comment.save()
    render template: 'comment', model: [i:params.i, comment: comment, commented: entity, currentEntity: currentEntity]
  }

  def list = {

  }

  def updatelist = {
    Date dateFrom = Date.parse("dd. MM. yy", params.dateFrom)
    Date dateTo = Date.parse("dd. MM. yy", params.dateTo) + 1

    List entities = []

    if (params.activitytemplates)
      entities.addAll(Entity.findAllByType(metaDataService.etTemplate))
    if (params.activities)
      entities.addAll(Entity.findAllByType(metaDataService.etActivity))
    if (params.groupactivitytemplates)
      entities.addAll(Entity.findAllByType(metaDataService.etGroupActivityTemplate))
    if (params.groupactivities)
      entities.addAll(Entity.findAllByType(metaDataService.etGroupActivity))
    if (params.projecttemplates)
      entities.addAll(Entity.findAllByType(metaDataService.etProjectTemplate))
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

}
