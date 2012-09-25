package at.uenterprise.erp

class LabelController {
  FunctionService functionService

  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def index = {
    redirect action: "list", params: params
  }

  def list = {
    [labelInstanceList: functionService.getLabels(), labelInstanceTotal: Label.countByType('template')]
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
      Setup.list()[0].addToLabels(labelInstance.id.toString())
      flash.message = message(code: "object.created", args: [message(code: "label"), labelInstance.name])
      redirect action: "show", id: labelInstance.id
    }
    else {
      render view: "create", model: [labelInstance: labelInstance]
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
        render view: "edit", model: [labelInstance: labelInstance]
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
        Setup.list()[0].removeFromLabels(labelInstance.id.toString())
        flash.message = message(code: "object.deleted", args: [message(code: "label"), labelInstance.name])
        redirect action: "list"
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
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
    if (Setup.list()[0].labels.indexOf(label) > 0) {
      int i = Setup.list()[0].labels.indexOf(label)
      use(Collections){ Setup.list()[0].labels.swap(i, i - 1) }
    }
    redirect action: 'list'
  }

  def moveDown = {
    String label = params.id

    if (Setup.list()[0].labels.indexOf(label) < (Setup.list()[0].labels.size() - 1)) {
      int i = Setup.list()[0].labels.indexOf(label)
      use(Collections){ Setup.list()[0].labels.swap(i, i + 1) }
    }
    redirect action: 'list'
  }
  
  def sortAlphabetical = {
    List labels = Label.findAllByType('template')
    labels = labels.sort() {it.name}
    Setup.list()[0].labels.clear()
    labels.each {
      Setup.list()[0].addToLabels(it.id.toString())
    }
    redirect action: 'list'
  }

}
