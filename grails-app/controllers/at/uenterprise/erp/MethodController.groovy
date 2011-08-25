package at.uenterprise.erp

class MethodController {
  def entityHelperService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    List methods = Method.findAllByType('template', params)
    [methodInstanceList: methods, methodInstanceTotal: methods.size()]
  }

  def show = {
    def methodInstance = Method.get(params.id)

    if (!methodInstance) {
      //flash.message = "Method not found with id ${params.id}"
      flash.message = message(code: "method.idNotFound", args: [params.id])
      redirect(action: list)
    }
    else {
      [methodInstance: methodInstance]
    }
  }

  def delete = {
    def methodInstance = Method.get(params.id)
    if (methodInstance) {
      try {
        methodInstance.delete(flush: true)
        flash.message = message(code: "method.deleted", args: [methodInstance.name])
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "method.notDeleted", args: [params.id])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      //flash.message = "Method not found with id ${params.id}"
      flash.message = message(code: "method.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    def methodInstance = Method.get(params.id)

    if (!methodInstance) {
      //flash.message = "Method not found with id ${params.id}"
      flash.message = message(code: "method.idNotFound", args: [params.id])
      redirect action: 'list'
      return
    }

    return [methodInstance: methodInstance]

  }

  def update = {
    def methodInstance = Method.get(params.id)
    if (methodInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (methodInstance.version > version) {

          methodInstance.errors.rejectValue("version", "method.optimistic.locking.failure", "Another user has updated this Method while you were editing.")

          render view: 'edit', model: [methodInstance: methodInstance]
          return
        }
      }
      methodInstance.properties = params
      if (methodInstance.save()) {
        flash.message = message(code: "method.updated", args: [methodInstance.name])

        redirect action: 'show', id: methodInstance.id
      }
      else {
        render view: 'edit', model: [methodInstance: methodInstance]
      }
    }
    else {
      //flash.message = "Method not found with id ${params.id}"
      flash.message = message(code: "method.idNotFound", args: [params.id])
      redirect action: 'list'
    }
  }

  def create = {
    def methodInstance = new Method()
    methodInstance.properties = params
    return ['methodInstance': methodInstance]
  }

  def save = {
    def methodInstance = new Method(params)
    methodInstance.type = "template"
    if (methodInstance.save(flush: true)) {
      flash.message = message(code: "method.created", args: [methodInstance.name])

      redirect action: "show", id: methodInstance.id
    }
    else {
      render view: 'create', model: [methodInstance: methodInstance]
    }
  }

  def addElement = {
    Element element = new Element(params)
    Method method = Method.get(params.id)
    method.addToElements(element)
    render template: 'elements', model: [methodInstance: method, entity: entityHelperService.loggedIn]
  }

  def removeElement = {
    Method method = Method.get(params.id)
    method.removeFromElements(Element.get(params.element))
    Element.get(params.element).delete()
    render template: 'elements', model: [methodInstance: method, entity: entityHelperService.loggedIn]
  }

  def editElement = {
    Method method = Method.get(params.id)
    Element element = Element.get(params.element)
    render template: 'editelement', model: [methodInstance: method, element: element, i: params.i]
  }

  def updateElement = {
    Method method = Method.get(params.id)
    Element element = Element.get(params.element)

    // find all elements with the same name and rename them
    Element.findAllByName(element.name).each {
      it.name = params.name
      it.save()
    }

    element.name = params.name
    element.save(flush: true)
    render template: 'element', model: [methodInstance: method, element: element, i: params.i, entity: entityHelperService.loggedIn]
  }
}
