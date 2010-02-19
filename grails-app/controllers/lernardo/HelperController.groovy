

package lernardo

import de.uenterprise.ep.Entity

class HelperController {
    def functionService
    def metaDataService

    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        def entity = Entity.findByName(params.name)

        def type = entity.type.name
        def helper = Helper.findAllByType(type)

        def helperFor
        if (type == 'Paed')
          helperFor = 'Pädagogen'
        else if (type == 'User')
          helperFor = 'Moderatoren'
        else if (type == 'Hort')
          helperFor = 'die Hortverwaltung'
        return [helperInstanceList: helper,
                helperInstanceTotal: helper.size(),
                entity: entity,
                helperFor: helperFor]
    }

    def show = {
        def helperInstance = Helper.get( params.id )

        if(!helperInstance) {
            flash.message = "Helper not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [helperInstance :helperInstance]
        }
    }

    def del = {
        def helperInstance = Helper.get( params.id )
        if(helperInstance) {
            try {
                helperInstance.delete(flush:true)
                flash.message = message(code:"helper.deleted")
                redirect(action:"list", params:[name: params.name])
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Helper ${params.id} could not be deleted"
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "Helper not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def helperInstance = Helper.get( params.id )
        def entity = Entity.findByName(params.name)

        if(!helperInstance) {
            flash.message = "Helper not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [helperInstance :helperInstance,
                    entity: entity]
        }
    }

    def update = {
        def helperInstance = Helper.get( params.id )
        if(helperInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(helperInstance.version > version) {
                    
                    helperInstance.errors.rejectValue("version", "helper.optimistic.locking.failure", "Another user has updated this Helper while you were editing.")

                    render view:'edit', model:[helperInstance:helperInstance]
                    return
                }
            }
            helperInstance.properties = params
            if(!helperInstance.hasErrors() && helperInstance.save()) {
                flash.message = message(code:"helper.updated")  
                redirect action:'list', params:[name: params.name]
            }
            else {
                render view:'edit', model:[helperInstance:helperInstance]
            }
        }
        else {
            flash.message = "Helper not found with id ${params.id}"
            redirect action:'list'
        }
    }

    def create = {
        def helperInstance = new Helper()
        helperInstance.properties = params
        def entity = Entity.findByName(params.name)

        return [helperInstance: helperInstance,
                entity: entity]
    }

    def save = {
        def helperInstance = new Helper(params)

        def type
        if (helperInstance.type == 'Paed')
          type = metaDataService.etPaed
        if (helperInstance.type == 'User')
          type = metaDataService.etUser
        if (helperInstance.type == 'Hort')
          type = metaDataService.etHort

        List receiver = Entity.findAllByType(type)
        receiver.each {
          functionService.createEvent(it, 'Es wurde das Hilfethema "'+helperInstance.title+'" angelegt.')
        }

        if(helperInstance.save(flush:true)) {
            flash.message = message(code:"helper.created")
            redirect action:"list", params:[name:params.name]
        }
        else {
            render view:'create', model:[helperInstance:helperInstance]
        }
    }
}
