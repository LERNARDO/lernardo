package at.uenterprise.erp

class WorkdayCategoryController {
    
    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ workdayCategoryInstanceList: WorkdayCategory.list( params ), workdayCategoryInstanceTotal: WorkdayCategory.count() ]
    }

    def show = {
        def workdayCategoryInstance = WorkdayCategory.get( params.id )

        if(!workdayCategoryInstance) {
            flash.message = "WorkdayCategory not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            [ workdayCategoryInstance : workdayCategoryInstance ]
        }
    }

    def delete = {
        def workdayCategoryInstance = WorkdayCategory.get( params.id )
        if(workdayCategoryInstance) {
            try {
                workdayCategoryInstance.delete(flush:true)
                flash.message = message(code:"workdaycategory.deleted", args:[workdayCategoryInstance.name])
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"workdaycategory.notDeleted", args:[workdayCategoryInstance.name])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "WorkdayCategory not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        def workdayCategoryInstance = WorkdayCategory.get( params.id )

        if(!workdayCategoryInstance) {
            flash.message = "WorkdayCategory not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            return [ workdayCategoryInstance : workdayCategoryInstance ]
        }
    }

    def update = {
        def workdayCategoryInstance = WorkdayCategory.get( params.id )
        if(workdayCategoryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(workdayCategoryInstance.version > version) {
                    
                    workdayCategoryInstance.errors.rejectValue("version", "workdayCategory.optimistic.locking.failure", "Another user has updated this WorkdayCategory while you were editing.")

                    render view:'edit', model:[workdayCategoryInstance:workdayCategoryInstance]
                    return
                }
            }
            workdayCategoryInstance.properties = params
            if(workdayCategoryInstance.save()) {
                flash.message = message(code:"workdaycategory.updated", args:[workdayCategoryInstance.name])

                redirect action:'show', id:workdayCategoryInstance.id
            }
            else {
                render view:'edit', model:[workdayCategoryInstance:workdayCategoryInstance]
            }
        }
        else {
            flash.message = "WorkdayCategory not found with id ${params.id}"
            redirect action:'list'
        }
    }

    def create = {
        def workdayCategoryInstance = new WorkdayCategory()
        workdayCategoryInstance.properties = params
        return ['workdayCategoryInstance':workdayCategoryInstance]
    }

    def save = {
        def workdayCategoryInstance = new WorkdayCategory(params)
        if(workdayCategoryInstance.save(flush:true)) {
            flash.message = message(code:"workdaycategory.created", args:[workdayCategoryInstance.name])

            redirect action:"show", id:workdayCategoryInstance.id
        }
        else {
            render view:'create', model:[workdayCategoryInstance:workdayCategoryInstance]
        }
    }
}
