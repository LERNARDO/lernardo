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

    functionService.createEvent(currentEntity, 'Du hast ein Kommentar zu <a href="' + createLink(controller: entity.type.supertype.name +'Profile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> erstellt.')
    List receiver = Entity.findAllByType(metaDataService.etEducator)
    receiver.each {
      if (it.id != currentEntity.id)
        functionService.createEvent(it as Entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat ein Kommentar zu <a href="' + createLink(controller: entity.type.supertype.name +'Profile', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> erstellt.')
    }

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
    render template:'comment', model:[i:params.i, comment: comment, commented: entity, currentEntity: currentEntity]
  }

}
