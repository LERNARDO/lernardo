import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import standard.MetaDataService
import standard.FunctionService
import at.openfactory.ep.Profile
import lernardo.Comment

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

    //flash.message = message(code: "comment.deleted")
    render template:'comments', model:[commented: entity]
  }

  def create = {
    render template: 'create', model: ['entity_id': params.id]
  }

  def save = {
    Entity entity = Entity.get(params.id)
    Entity creator = entityHelperService.loggedIn

    Comment comment = new Comment(content: params.content, creator: creator.id).save()

    entity.profile.addToComments(comment)

    //flash.message = message(code:"comment.created", args:[entity.profile.fullName])

    functionService.createEvent(entityHelperService.loggedIn, 'Du hast ein Kommentar zu "'+entity.profile.fullName+'" erstellt.')
    List receiver = Entity.findAllByType(metaDataService.etEducator)
    receiver.each {
      if (it != entityHelperService.loggedIn)
        functionService.createEvent(it, entityHelperService.loggedIn.profile.fullName+' hat ein Kommentar zu "'+entity.profile.fullName+'" erstellt.')
    }

    render template:'comments', model:[commented: entity]
  }

}
