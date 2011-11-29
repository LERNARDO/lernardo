package at.uenterprise.erp

class LabelController {
  FunctionService functionService

  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def index = {
    redirect action: "list", params: params
  }

  def list = {
    [labelInstanceList: functionService.getLabels(), labelInstanceTotal: Label.countByType("template")]
  }

  def create = {
    def labelInstance = new Label()
    labelInstance.properties = params
    return [labelInstance: labelInstance]
  }

  def save = {
    def labelInstance = new Label(params)
    labelInstance.type = "template"
    if (labelInstance.save(flush: true)) {
      Label.labels.add(labelInstance.id.toString())
      flash.message = message(code: "object.created", args: [message(code: "label"), labelInstance.name])
      redirect action: "show", id: labelInstance.id
    }
    else {
      render(view: "create", model: [labelInstance: labelInstance])
    }
  }

  def show = {
    def labelInstance = Label.get(params.id)
    if (labelInstance) {
      [labelInstance: labelInstance]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "label")])
      redirect action: "list"
    }
  }

  def edit = {
    def labelInstance = Label.get(params.id)
    if (labelInstance) {
      [labelInstance: labelInstance]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "label")])
      redirect action: "list"
    }
  }

  def update = {
    def labelInstance = Label.get(params.id)
    if (labelInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (labelInstance.version > version) {

          labelInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'label.label', default: 'Label')] as Object[], "Another user has updated this Label while you were editing")
          render(view: "edit", model: [labelInstance: labelInstance])
          return
        }
      }

      // update all label instances
      List labels = Label.findAllByType("instance")
      labels.each {
        if (it.name == labelInstance.name) {
          it.name = params.name
          it.description = params.description
          it.save()
        }
      }

      labelInstance.properties = params
      if (!labelInstance.hasErrors() && labelInstance.save(flush: true)) {
        flash.message = message(code: "object.updated", args: [message(code: "label"), labelInstance.name])
        redirect action: "show", id: labelInstance.id
      }
      else {
        render(view: "edit", model: [labelInstance: labelInstance])
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "label")])
      redirect action: "list"
    }
  }

  def delete = {
    def labelInstance = Label.get(params.id)
    if (labelInstance) {
      try {
        labelInstance.delete(flush: true)
        Label.labels.remove(labelInstance.id.toString())
        flash.message = message(code: "object.deleted", args: [message(code: "label"), labelInstance.name])
        redirect action: "list"
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "label"), labelInstance.name])
        redirect action: "show", id: params.id
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "label")])
      redirect action: "list"
    }
  }

  def moveUp = {
      String label = params.id
      if (Label.labels.indexOf(label) > 0) {
        int i = Label.labels.indexOf(label)
        use(Collections){ Label.labels.swap(i, i - 1) }
      }
      redirect action: 'list'
    }

    def moveDown = {
      String label = params.id

      if (Label.labels.indexOf(label) < (Label.labels.size() - 1)) {
        int i = Label.labels.indexOf(label)
        use(Collections){ Label.labels.swap(i, i + 1) }
      }
      redirect action: 'list'
    }

}
