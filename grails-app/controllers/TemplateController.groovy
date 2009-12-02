import posts.TemplateComment

import lernardo.ActivityTemplate

class TemplateController {
  def entityHelperService

    def index = {
      redirect action:'list', params:params
    }

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 15

        return ['templateList': ActivityTemplate.list(params),
                'templateCount': ActivityTemplate.count(),
                'entity': entityHelperService.loggedIn]
    }

    def edit = {
        def template = ActivityTemplate.get(params.id)

        if(!template) {
            flash.message = message(code:"template.notFound", args:[params.id])
            redirect action:'list'
        }
        else {
            return ['template': template,
                    'entity': entityHelperService.loggedIn]
        }
    }

    def update = {
        def template = ActivityTemplate.get(params.id)
        if(template) {
            if(params.version) {
                def version = params.version.toLong()
                if(template.version > version) {
                    template.errors.rejectValue("version", "template.optimistic.locking.failure", "Another user has updated this template while you were editing.")
                    render view:'edit', model:[template:template]
                    return
                }
            }
            template.properties = params
            if(!template.hasErrors() && template.save()) {
                flash.message = message(code:"template.updated", args:[template.name])
                redirect action:'show', id:template.id
            }
            else {
                render view:'edit', model:[template:template]
            }
        }
        else {
            flash.message = message(code:"template.notFound", args:[template.id])
            redirect action:'edit', id:template.id
        }
    }

    def show = {
        def template = ActivityTemplate.get(params.id)
        if (!template)
          template = ActivityTemplate.findByName(params.name)

        if (!template) {
            flash.message = message(code:"template.notFound", args:[params.id])
            return
        }

        return ['template': template,
                'commentList': TemplateComment.findAllByTemplate(template),
                'entity': entityHelperService.loggedIn]
    }

    def create = {
      def templateInstance = new ActivityTemplate()
      templateInstance.properties = params
      return ['templateInstance': templateInstance,
              'entity': entityHelperService.loggedIn]
    }

    def save = {

      ActivityTemplate at = ActivityTemplate.findByName (params.name)
      if (at) {
        flash.message = message(code:"template.exist", args:[params.name])
        redirect action:"create", params:params
        return
      }

      def activityInstance = new ActivityTemplate(params)
      activityInstance.qualifications='keine'
        if(!activityInstance.hasErrors() && activityInstance.save(flush:true)) {
          flash.message = message(code:"template.created", args:[params.name])
          redirect action:'show', id:activityInstance.id
        }
    }

    def del = {
        def templateInstance = ActivityTemplate.get(params.id)
        if(templateInstance) {
            try {
                flash.message = message(code:"template.deleted", args:[templateInstance.name])
                templateInstance.delete(flush:true)
                redirect action:"list"
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                flash.message = message(code:"template.notDeleted", args:[templateInstance.name])
                redirect action:"show", id:params.id
            }
        }
        else {
            flash.message = message(code:"template.notFound", args:[params.id])
            redirect action:"list"
        }
    }
}