import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityHelperService
import de.uenterprise.ep.ProfileHelperService
import standard.MetaDataService
import standard.FunctionService
import de.uenterprise.ep.Profile
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
   
    Comment comment = new Comment(content: params.content, creator: entityHelperService.loggedIn.id).save()

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
