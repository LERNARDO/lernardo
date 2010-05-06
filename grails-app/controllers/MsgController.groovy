import de.uenterprise.ep.Entity
import lernardo.Msg
import de.uenterprise.ep.EntityHelperService

class MsgController {
  EntityHelperService entityHelperService
  FilterService filterService
  FunctionService functionService

  def index = {
    redirect action:"inbox", params:params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete:'POST', save:'POST', update:'POST']

  def inbox = {
    params.max = Math.min( params.max ? params.int('max') : 10,  100)
    params.offset = params.offset ? params.int('offset') : 0
    def messages = filterService.getInbox(params.id, params)
    def messagesTotal = filterService.getInboxCount (params.id)
    return ['msgInstanceList': messages,
            'msgInstanceTotal': messagesTotal,
            'entity': Entity.get(params.id)]
  }

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
        // not working as well
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
    Entity entity = Entity.get(params.id)
    return ['msgInstance':message,
            'receiver':entity,
            'entity': Entity.get(params.entity)]
  }

  def save = {
    // create first instance to be saved in outbox of sender
    def message = new Msg()
    message.sender = entityHelperService.loggedIn
    message.receiver = Entity.get(params.entity)
    message.read = true
    message.entity = entityHelperService.loggedIn
    message.content = params.content
    message.subject = params.subject
    // create second instance to be saved in inbox of receiver
    def message2 = new Msg()
    message2.sender = entityHelperService.loggedIn
    message2.receiver = Entity.get(params.entity)
    message2.read = false
    message2.entity = Entity.get(params.entity)
    message2.content = params.content
    message2.subject = params.subject
    if(!message.hasErrors() && message.save(flush:true) && message2.save(flush:true)) {
        // TODO: find out why this flash message suddenly won't work anymore
        //flash.message = message(code:"msg.sent", args:[message.subject])

        functionService.createEvent(message.sender, 'Du hast '+message.receiver.profile.fullName+' eine Nachricht geschickt.')
        functionService.createEvent(message.receiver, message.sender.profile.fullName+' hat dir eine Nachricht geschickt.')

        redirect controller: message2.entity.type.supertype.name +'Profile', action:'show', id:entityHelperService.loggedIn.id, params:[entity:entityHelperService.loggedIn]
    }
    else {
        render view:'create', model:[msgInstance: message, entity: Entity.get(params.entity)]
    }
  }
}
