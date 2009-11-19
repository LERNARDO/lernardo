import de.uenterprise.ep.Entity

class MsgController {
  def entityHelperService
  def filterService

    def index = {
        redirect action:"inbox", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def inbox = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        def messages = filterService.getInbox (entityHelperService.loggedIn.name)
        render template:'inbox', model:[msgInstanceList: messages,
                                        msgInstanceTotal: messages.count()]
    }

    def outbox = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        def messages = filterService.getOutbox (entityHelperService.loggedIn.name)
        render template:'outbox', model:[msgInstanceList: messages,
                                         msgInstanceTotal: messages.count()]
    }

    def show = {
        def msgInstance = Msg.get( params.id )
        Entity e = Entity.findByName(params.name)
        msgInstance.read = true

        if(!msgInstance) {
            flash.message = message(code:"msg.notFound", args:[params.id])
            redirect(action:index)
        }
        else {
            render template:'show', model:[ msgInstance : msgInstance, entity: e ]
        }
    }

    def delete = {
        def msgInstance = Msg.get( params.id )
        Entity e = Entity.findByName(params.name)
        if(msgInstance) {
            try {
                flash.message = message(code:"msg.deleted", args:[msgInstance.subject])
                msgInstance.delete(flush:true)
                render template:'inbox', model:[entity:e]
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"msg.notDeleted", args:[msgInstance.subject])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = message(code:"msg.notFound", args:[params.id])
            redirect(action:"index")
        }
    }

    def edit = {
        def msgInstance = Msg.get( params.id )

        if(!msgInstance) {
            flash.message = message(code:"msg.notFound", args:[params.id])
            redirect action:'index'
        }
        else {
            return [ msgInstance : msgInstance ]
        }
    }

    def update = {
        def msgInstance = Msg.get( params.id )
        if(msgInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(msgInstance.version > version) {

                    msgInstance.errors.rejectValue("version", "msg.optimistic.locking.failure", "Another user has updated this Msg while you were editing.")

                    render view:'edit', model:[msgInstance:msgInstance]
                    return
                }
            }
            msgInstance.properties = params
            if(!msgInstance.hasErrors() && msgInstance.save()) {
                flash.message = "Msg ${params.id} updated"

                redirect action:'show', id:msgInstance.id
            }
            else {
                render view:'edit', model:[msgInstance:msgInstance]
            }
        }
        else {
            flash.message = message(code:"msg.notFound", args:[params.id])
            redirect action:'index'
        }
    }

    def create = {
        def msgInstance = new Msg()
        msgInstance.properties = params
        Entity e = Entity.findByName(params.name)
        render template:'create', model:['msgInstance':msgInstance, entity:e ]
    }

    def save = {
        // create first instance to be saved in outbox of sender
        def msgInstance = new Msg(params)
        msgInstance.sender = entityHelperService.loggedIn
        msgInstance.receiver = Entity.findByName(params.name)
        msgInstance.read = true
        msgInstance.entity = entityHelperService.loggedIn
        // create second instance to be saved in inbox of receiver
        def msgInstance2 = new Msg(params)
        msgInstance2.sender = entityHelperService.loggedIn
        msgInstance2.receiver = Entity.findByName(params.name)
        msgInstance2.read = false
        msgInstance2.entity = Entity.findByName(params.name)
        if(!msgInstance.hasErrors() && msgInstance.save(flush:true) && msgInstance2.save(flush:true)) {
            flash.message = message(code:"msg.sent", args:[msgInstance.subject])

            redirect controller:'profile', action:'show', params:[name:params.name]
        }
        else {
            render view:'create', model:[ msgInstance:msgInstance, entity:Entity.findByName(params.name) ]
        }

    }
}
