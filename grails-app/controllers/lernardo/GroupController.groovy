

package lernardo

import de.uenterprise.ep.Entity

class GroupController {
    
    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ groupInstanceList: Group.list( params ), groupInstanceTotal: Group.count() ]
    }

    def show = {
        Entity entity = Entity.findByName(params.name)
        def groupInstance = Group.get( params.id )

        if(!groupInstance) {
            flash.message = "Group not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            [ groupInstance : groupInstance, entity: entity ]
        }
    }

    def delete = {
        def groupInstance = Group.get( params.id )
        if(groupInstance) {
            try {
                groupInstance.delete(flush:true)
                flash.message = "Group ${params.id} deleted"
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Group ${params.id} could not be deleted"
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "Group not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def groupInstance = Group.get( params.id )

        if(!groupInstance) {
            flash.message = "Group not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [ groupInstance : groupInstance ]
        }
    }

    def update = {
        def groupInstance = Group.get( params.id )
        if(groupInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(groupInstance.version > version) {
                    
                    groupInstance.errors.rejectValue("version", "group.optimistic.locking.failure", "Another user has updated this Group while you were editing.")

                    render view:'edit', model:[groupInstance:groupInstance]
                    return
                }
            }
            groupInstance.properties = params
            if(!groupInstance.hasErrors() && groupInstance.save()) {
                flash.message = "Group ${params.id} updated"

                redirect action:'show', id:groupInstance.id
            }
            else {
                render view:'edit', model:[groupInstance:groupInstance]
            }
        }
        else {
            flash.message = "Group not found with id ${params.id}"
            redirect action:'list'
        }
    }

    def create = {
        def groupInstance = new Group()
        groupInstance.properties = params
        return ['groupInstance':groupInstance]
    }

    def save = {
        def groupInstance = new Group(params)
        if(groupInstance.save(flush:true)) {
            flash.message = "Group ${groupInstance.id} created"

            redirect action:"show", id:groupInstance.id
        }
        else {
            render view:'create', model:[groupInstance:groupInstance]
        }
    }
}
