package at.uenterprise.erp

class MethodController {
  def entityHelperService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.max = Math.min(params.int('max') ?: 10, 100)
    params.sort = "name"
    params.order  = "asc"
    List methods = Method.findAllByType('template', params)
    [methodInstanceList: methods, methodInstanceTotal: methods.size()]
  }

  def show = {
    def methodInstance = Method.get(params.id)
    if (methodInstance) {
      [methodInstance: methodInstance]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "method")])
      redirect action: list
    }
  }

  def delete = {
    def methodInstance = Method.get(params.id)
    if (methodInstance) {
      try {
        methodInstance.delete(flush: true)
        flash.message = message(code: "object.deleted", args: [message(code: "method"), methodInstance.name])
        redirect action: "list"
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "method"), methodInstance.name])
        redirect action: "show", id: params.id
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "method")])
      redirect action: "list"
    }
  }

  def edit = {
    def methodInstance = Method.get(params.id)

    if (methodInstance) {
      [methodInstance: methodInstance]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "method")])
      redirect action: 'list'
    }
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

      // find all methods with the same name and rename them
      Method.findAllByName(methodInstance.name).each {
        it.name = params.name
        it.save()
      }

      methodInstance.properties = params
      if (methodInstance.save()) {

        flash.message = message(code: "object.updated", args: [message(code: "method"), methodInstance.name])
        redirect action: 'show', id: methodInstance.id
      }
      else {
        render view: 'edit', model: [methodInstance: methodInstance]
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "method")])
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
      flash.message = message(code: "object.created", args: [message(code: "method"), methodInstance.name])

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

    // find all methods that have the same name and add the element each
    List methods = Method.findAllByNameAndType(method.name, "instance")
    methods.each { Method meth ->
      meth.addToElements(new Element(name: element.name))
    }

    render template: 'elements', model: [methodInstance: method]
  }

  def removeElement = {
    Method method = Method.get(params.id)
    Element element = Element.get(params.element)
    method.removeFromElements(element)

    // find all methods that have the same name and remove the element each
    List methods = Method.findAllByNameAndType(method.name, "instance")
    methods.each { Method meth ->
      Element elementToDelete = null
      meth.elements.each { Element el ->
        if (el.name == element.name)
          elementToDelete = el
      }
      meth.removeFromElements(elementToDelete)
      elementToDelete.delete()
    }

    element.delete(flush: true)

    render template: 'elements', model: [methodInstance: method]
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
    render template: 'element', model: [methodInstance: method, element: element, i: params.i]
  }

    def moveUp = {
        Method method = Method.get(params.id)
        Element element = Element.get(params.element)

        if (method.elements.indexOf(element) > 0) {
            int i = method.elements.indexOf(element)
            use(Collections){ method.elements.swap(i, i - 1) }
        }
        render template: 'elements', model: [methodInstance: method]
    }

    def moveDown = {
        Method method = Method.get(params.id)
        Element element = Element.get(params.element)

        if (method.elements.indexOf(element) < (method.elements.size() - 1)) {
            int i = method.elements.indexOf(element)
            use(Collections){ method.elements.swap(i, i + 1) }
        }
        render template: 'elements', model: [methodInstance: method]
    }
}
