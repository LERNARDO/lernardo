package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.SecHelperService

class MsgController {
  EntityHelperService entityHelperService
  FunctionService functionService
  SecHelperService secHelperService
  MetaDataService metaDataService

  def index = {
    redirect action: "inbox", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  /*
   * shows the inbox of a given entity
   */
  def inbox = {
    params.max = Math.min(params.int('max') ?: 10, 100)
    params.offset = params.int('offset') ?: 0

    Entity entity = Entity.get(params.id)

    def messages = Msg.createCriteria().list {
      eq('entity', entity)
      //ne('sender', entity)
      eq('receiver', entity)
      order("dateCreated", "desc")
      maxResults(params.max)
      firstResult(params.offset)
    }
    //int totalMessages = Msg.countByEntityAndSenderNotEqual(entity, entity)
    int totalMessages = Msg.countByEntityAndReceiver(entity, entity)

    return [messages: messages,
            totalMessages: totalMessages,
            entity: entity]
  }

  /*
   * shows the outbox of a given entity
   */
  def outbox = {
    params.max = Math.min(params.int('max') ?: 10, 100)
    params.offset = params.int('offset') ?: 0

    Entity entity = Entity.get(params.id)

    def messages = Msg.createCriteria().list {
      eq('entity', entity)
      eq('sender', entity)
      order("dateCreated", "desc")
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalMessages = Msg.countByEntityAndSender(entity, entity)

    return [messages: messages,
            totalMessages: totalMessages,
            entity: entity]
  }

  def show = {
    def message = Msg.get(params.id)

    if(!message) {
      flash.message = g.message(code: "object.notFound", args: [g.message(code: "msg")])
      redirect action: "index", params: [name: params.name]
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

    return [msgInstance: message,
            entity: Entity.get(params.entity),
            box: params.box]

  }

  def del = {
    def message = Msg.get( params.id )
    if(message) {
      try {
        flash.message = g.message(code: "object.deleted", args: [g.message(code: "msg"), message.subject])
        message.delete(flush:true)
        redirect action: params.box, id: params.entity
        //render ""
      }
      catch(org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = g.message(code: "object.notDeleted", args: [g.message(code: "msg"), message.subject])
        redirect action: "show", id: params.id
      }
    }
    else {
      flash.message = g.message(code: "object.notFound", args: [g.message(code: "msg")])
      //redirect action: params.box, params: [name:params.name]
    }
  }

  def edit = {
    def message = Msg.get( params.id )
    if(!message) {
      flash.message = g.message(code: "object.notFound", args: [g.message(code: "msg")])
      redirect action: 'index', params: [name: params.name]
      return
    }

    return ['msgInstance': message]

  }

  def update = {
    def message = Msg.get( params.id )
    if(message) {
      message.properties = params
      if(message.save()) {
        flash.message = "Msg ${params.id} updated"
        redirect action: 'show', id: message.id
      }
      else {
        render view: 'edit', model: [msgInstance:message]
      }
    }
    else {
      flash.message = g.message(code: "object.notFound", args: [g.message(code: "msg")])
      redirect action: 'index', params: [name:params.name]
    }
  }

  def create = {
    def message = new Msg()

    // if this is an answer to a message use the subject
    if (params.subject)
      message.subject = params.subject.decodeHTML()
    if (params.content)
        message.content = params.content.decodeHTML()

    Entity entity = Entity.get(params.id)
    return [msgInstance: message,
            receiver: entity,
            entity: entity,
            reply: params.reply ?: 'false']
  }

  def createMany = {
    def message = new Msg()
    Entity entity = Entity.get(params.id)

    return [msgInstance: message,
            entity: entity]
  }

  def saveMany = {MessageCommand mc->
    Entity entity1 = Entity.get(params.entity)

    if (mc.hasErrors()) {
      List receivers = []
      params.receivers = params.list('receivers')
      params.receivers.each { id ->
        receivers.add(Entity.get(id))
      }
      render view: 'createMany', model: [mc: mc, entity: entity1, receivers: receivers]
      return
    }

    Entity currentEntity = entityHelperService.loggedIn

    params.receivers = params.list('receivers')

    def failed = false
    def msg = null
    params.receivers.each { id ->
      Entity entity = Entity.get(id)

      if (entity != currentEntity) {

        // create first instance to be saved in outbox of sender
        msg = functionService.createMessage(currentEntity, entity, currentEntity, params.subject, params.content, true) // the sender wrote it so it is already read
        if (!msg.save()) {
          failed = true
        }

      }

      // create second instance to be saved in inbox of receiver
      functionService.createMessage(currentEntity, entity, entity, params.subject, params.content).save()
    }

    if (!failed) {
      flash.message = message(code: "msg.sent", args: [params.subject])
      redirect action: 'inbox', id: currentEntity.id
    }
    else
      render view: 'createMany', model: [msgInstance: msg, entity: Entity.get(params.entity.toInteger())]

  }

  def save = {
    Entity receiver = Entity.get(params.receiver.toInteger())
    Entity currentEntity = entityHelperService.loggedIn

    // create first instance to be saved in outbox of sender
    functionService.createMessage(currentEntity, receiver, currentEntity, params.subject, params.content, true).save() // the sender wrote it so it is already read

    // create second instance to be saved in inbox of receiver
    def msg = functionService.createMessage(currentEntity, receiver, receiver, params.subject, params.content)
    if (msg.save()) {
      flash.message = message(code: "msg.sent", args: [params.subject])
      if (params.reply == "true")
        redirect action: 'inbox', id: currentEntity.id
      else
        redirect controller: receiver.type.supertype.name + 'Profile', action: 'show', id: receiver.id, params: [entity: receiver]
    }
    else {
      render view: 'create', model: [msgInstance: msg, receiver: receiver, reply: params.reply, entity: Entity.get(params.entity.toInteger())]
    }

  }

  def remoteReceivers = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
        render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().listDistinct {
      user {
        eq("enabled", true)
      }
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
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render {span(class: 'italic', message(code: 'noResultsFound'))}
      return
    }
    else {
      render template: 'receiverresults', model: [results: results]
    }
  }

}

/*
* command object to handle validation of a notification
*/
class MessageCommand {

  String subject
  String content
  String receivers

  static constraints = {
    subject   blank: false
    content   blank: false
    receivers nullable: false
  }

}