import at.openfactory.ep.Entity
import lernardo.Msg
import at.openfactory.ep.EntityHelperService
import standard.FilterService
import standard.FunctionService

class MsgController {
  EntityHelperService entityHelperService
  FilterService filterService
  FunctionService functionService

  def index = {
    redirect action:"inbox", params:params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete:'POST', save:'POST', update:'POST']

  /*
   * shows the inbox of a given entity
   */
  def inbox = {
    params.max = Math.min( params.max ? params.int('max') : 10,  100)
    params.offset = params.offset ? params.int('offset') : 0
    def messages = filterService.getInbox(params.id, params)
    def messagesTotal = filterService.getInboxCount (params.id)
    return ['msgInstanceList': messages,
            'msgInstanceTotal': messagesTotal,
            'entity': Entity.get(params.id)]
  }

  /*
   * shows the outbox of a given entity
   */
  def outbox = {
    params.max = Math.min( params.max ? params.int('max') : 10,  100)
    params.offset = params.offset ? params.int('offset') : 0
    def messages = filterService.getOutbox(params.id, params)
    def messagesTotal = filterService.getOutboxCount (params.id)
    return ['msgInstanceList': messages,
            'msgInstanceTotal': messagesTotal,
            'entity': Entity.get(params.id)]
  }

  def show = {
    def message = Msg.get(params.id)
    if (!message.read)
      message.read = true

    if(!message) {
      flash.message = message(code:"msg.notFound", args:[params.id])
      redirect action:index, params:[name:params.name]
    }
    else {
      return ['msgInstance': message,
              'entity':Entity.get(params.entity),
              'box':params.box]
    }
  }

  def del = {
    def message = Msg.get( params.id )
    if(message) {
      try {
        // not working
        //flash.message = message(code:"msg.deleted", args:[message.subject])
        message.delete(flush:true)
        redirect action:params.box, id: params.entity
      }
      catch(org.springframework.dao.DataIntegrityViolationException ex) {
        flash.message = message(code:"msg.notDeleted", args:[message.subject])
        redirect action:"show",id:params.id
      }
    }
    else {
      flash.message = message(code:"msg.notFound", args:[params.id])
      redirect action:params.box, params:[name:params.name]
    }
  }

  def edit = {
    def message = Msg.get( params.id )
    if(!message) {
      flash.message = message(code:"msg.notFound", args:[params.id])
      redirect action:'index', params:[name:params.name]
    }
    else {
      return ['msgInstance': message]
    }
  }

  def update = {
    def message = Msg.get( params.id )
    if(message) {
      message.properties = params
      if(!message.hasErrors() && message.save()) {
        flash.message = "Msg ${params.id} updated"
        redirect action:'show', id:message.id
      }
      else {
        render view:'edit', model:[msgInstance:message]
      }
    }
    else {
      flash.message = message(code:"msg.notFound", args:[params.id])
      redirect action:'index', params:[name:params.name]
    }
  }

  def create = {
    def message = new Msg()

    // if this is an answer to a message use the subject
    if (params.subject)
      message.subject = params.subject

    Entity entity = Entity.get(params.id)
    return ['msgInstance':message,
            'receiver':entity,
            'entity': Entity.get(params.entity)]
  }

  def save = {
    Entity entity = Entity.get(params.entity)
    Entity currentEntity = entityHelperService.loggedIn

    // create first instance to be saved in outbox of sender
    functionService.createMessage(currentEntity, entity, currentEntity, params.subject, params.content, true) // the sender wrote it so it is already read

    // create second instance to be saved in inbox of receiver
    functionService.createMessage(currentEntity, entity, entity, params.subject, params.content)
     
    flash.message = message(code:"msg.sent", args:[params.subject])

    functionService.createEvent(currentEntity, 'Du hast <a href="' + createLink(controller: entity.type.supertype.name +'Profile', action:'show', id: entity.id) + '">' + entity.profile.fullName + '</a> eine Nachricht geschickt.')
    functionService.createEvent(entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: entity.id) + '">' + currentEntity.profile.fullName + '</a>  hat dir eine Nachricht geschickt.')

    //redirect controller: entity.type.supertype.name +'Profile', action:'show', id: entity.id, params:[entity: entity]
    redirect action:'inbox', id: entityHelperService.loggedIn.id
  }
}
