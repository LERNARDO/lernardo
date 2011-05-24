package at.uenterprise.erp

class SetupController {

  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def index = {
    redirect(action: "list", params: params)
  }

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [setupInstanceList: Setup.list(params), setupInstanceTotal: Setup.count()]
  }

  def create = {
    def setupInstance = new Setup()
    setupInstance.properties = params
    return [setupInstance: setupInstance]
  }

  def save = {
    def setupInstance = new Setup(params)
    if (setupInstance.save(flush: true)) {
      flash.message = "${message(code: 'default.created.message', args: [message(code: 'setup.label', default: 'Setup'), setupInstance.id])}"
      redirect(action: "show", id: setupInstance.id)
    }
    else {
      render(view: "create", model: [setupInstance: setupInstance])
    }
  }

  def show = {
    def setupInstance = Setup.get(params.id)
    if (!setupInstance) {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'setup.label', default: 'Setup'), params.id])}"
      redirect(action: "list")
    }
    else {
      [setupInstance: setupInstance]
    }
  }

  def edit = {
    def setupInstance = Setup.get(params.id)
    if (!setupInstance) {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'setup.label', default: 'Setup'), params.id])}"
      redirect(action: "list")
    }
    else {
      return [setupInstance: setupInstance]
    }
  }

  def update = {
    def setupInstance = Setup.get(params.id)
    if (setupInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (setupInstance.version > version) {

          setupInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'setup.label', default: 'Setup')] as Object[], "Another user has updated this Setup while you were editing")
          render(view: "edit", model: [setupInstance: setupInstance])
          return
        }
      }
      setupInstance.properties = params
      if (!setupInstance.hasErrors() && setupInstance.save(flush: true)) {
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'setup.label', default: 'Setup'), setupInstance.id])}"
        redirect(action: "show", id: setupInstance.id)
      }
      else {
        render(view: "edit", model: [setupInstance: setupInstance])
      }
    }
    else {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'setup.label', default: 'Setup'), params.id])}"
      redirect(action: "list")
    }
  }

  def delete = {
    def setupInstance = Setup.get(params.id)
    if (setupInstance) {
      try {
        setupInstance.delete(flush: true)
        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'setup.label', default: 'Setup'), params.id])}"
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'setup.label', default: 'Setup'), params.id])}"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'setup.label', default: 'Setup'), params.id])}"
      redirect(action: "list")
    }
  }
}
