import de.uenterprise.ep.Entity
import lernardo.Msg

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
        def messages = filterService.getInbox (params.name)
        return ['msgInstanceList': messages,
                'msgInstanceTotal': messages.count(),
                'entity': Entity.findByName(params.name)]
    }

    def outbox = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        def messages = filterService.getOutbox (params.name)
        return ['msgInstanceList': messages,
                'msgInstanceTotal': messages.count(),
                'entity': Entity.findByName(params.name)]
    }

    def show = {
        def msgInstance = Msg.get( params.id )
        if (!msgInstance.read)
            msgInstance.read = true

        if(!msgInstance) {
            flash.message = message(code:"msg.notFound", args:[params.id])
            redirect action:index, params:[name:params.name]
        }
        else {
            return ['msgInstance': msgInstance,
                    'entity':Entity.findByName(params.name)]
        }
    }

    def del = {
        def msgInstance = Msg.get( params.id )
        if(msgInstance) {
            try {
                flash.message = message(code:"msg.deleted", args:[msgInstance.subject])
                msgInstance.delete(flush:true)
                redirect action:"index", params:[name:params.name]
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                flash.message = message(code:"msg.notDeleted", args:[msgInstance.subject])
                redirect action:"show",id:params.id
            }
        }
        else {
            flash.message = message(code:"msg.notFound", args:[params.id])
            redirect action:"index", params:[name:params.name]
        }
    }

    def edit = {
        def msgInstance = Msg.get( params.id )

        if(!msgInstance) {
            flash.message = message(code:"msg.notFound", args:[params.id])
            redirect action:'index', params:[name:params.name]
        }
        else {
            return ['msgInstance': msgInstance]
        }
    }

    def update = {
        def msgInstance = Msg.get( params.id )
        if(msgInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(msgInstance.version > version) {
                    msgInstance.errors.rejectValue("version", "msg.optimistic.locking.failure", "Another user has updated this lernardo.Msg while you were editing.")
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
            redirect action:'index', params:[name:params.name]
        }
    }

    def create = {
      def msgInstance = new Msg()
      msgInstance.properties = params
      Entity e = Entity.findByName(params.name)
      return ['msgInstance':msgInstance,
              'entity':e]
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
            flash.message = message(code:"msg.sent", args:[msgInstance.subject,msgInstance.receiver.profile.fullName])
            redirect controller:'profile', action:'showProfile', params:[name:params.name]
        }
        else {
            render view:'create', model:[ msgInstance:msgInstance, entity:Entity.findByName(params.name) ]
        }

    }
}
