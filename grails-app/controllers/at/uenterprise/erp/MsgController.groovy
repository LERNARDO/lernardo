package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.SecHelperService

class MsgController {
  EntityHelperService entityHelperService
  FunctionService functionService
  SecHelperService secHelperService
  MetaDataService metaDataService

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

    Entity entity = Entity.get(params.id)

    // get messages
    def c = Msg.createCriteria()
    def messages = c.list (max: params.max, offset: params.offset) {
      eq('entity', entity)
      ne('sender', entity)
      order("dateCreated", "desc")
    }

    return ['messages': messages,
            'entity': entity]
  }

  /*
   * shows the outbox of a given entity
   */
  def outbox = {
    params.max = Math.min( params.max ? params.int('max') : 10,  100)
    params.offset = params.offset ? params.int('offset') : 0

    Entity entity = Entity.get(params.id)

    // get messages
    def c = Msg.createCriteria()
    def messages = c.list (max: params.max, offset: params.offset) {
      eq('entity', entity)
      eq('sender', entity)
      order("dateCreated", "desc")
    }

    return ['messages': messages,
            'entity': entity]
  }

  def show = {
    def message = Msg.get(params.id)

    if(!message) {
      flash.message = message(code:"msg.notFound", args:[params.id])
      redirect action:index, params:[name:params.name]
      return
    }

    // flag message as read
    if (!message.read)
      // if viewed by an admin or operator ..
      if (entityHelperService.loggedIn.type.name == metaDataService.etOperator.name || secHelperService.isAdmin())
      {
        // .. and it's one of their own messages
        if (message.entity.id == entityHelperService.loggedIn.id)
          // flag as read
          message.read = true
        // else it just won't be flagged as read
      }
      else
        message.read = true

    return ['msgInstance': message,
            'entity':Entity.get(params.entity),
            'box':params.box]

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
      return
    }

    return ['msgInstance': message]

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

  def createMany = {
    def message = new Msg()
    Entity entity = Entity.get(params.id)

    return [msgInstance: message,
            entity: entity]
  }

  def saveMany = {
    Entity currentEntity = entityHelperService.loggedIn

    params.receivers = params.list('receivers')

    params.receivers.each { id ->
      Entity entity = Entity.get(id)

      // create first instance to be saved in outbox of sender
      functionService.createMessage(currentEntity, entity, currentEntity, params.subject, params.content, true) // the sender wrote it so it is already read

      // create second instance to be saved in inbox of receiver
      functionService.createMessage(currentEntity, entity, entity, params.subject, params.content)

      functionService.createEvent(currentEntity, 'Du hast <a href="' + createLink(controller: entity.type.supertype.name +'Profile', action:'show', id: entity.id) + '">' + entity.profile.fullName + '</a> eine Nachricht geschickt.')
      functionService.createEvent(entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a>  hat dir eine Nachricht geschickt.')
    }

    flash.message = message(code:"msg.sent", args:[params.subject])

    redirect controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id, params:[entity: currentEntity]
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
    functionService.createEvent(entity, '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a>  hat dir eine Nachricht geschickt.')

    redirect controller: entity.type.supertype.name +'Profile', action:'show', id: entity.id, params:[entity: entity]
    //redirect action:'inbox', id: currentEntity.id
  }

  def remoteReceivers = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      or {
        eq('type', metaDataService.etClient)
        eq('type', metaDataService.etEducator)
        eq('type', metaDataService.etChild)
        eq('type', metaDataService.etParent)
        eq('type', metaDataService.etPartner)
        eq('type', metaDataService.etPate)
        eq('type', metaDataService.etOperator)
        eq('type', metaDataService.etUser)
      }
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'receiverresults', model: [results: results])
    }
  }

}
