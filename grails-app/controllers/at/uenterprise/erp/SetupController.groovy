package at.uenterprise.erp

class SetupController {

  def show = {
    def setupInstance = Setup.list()[0]
    if (!setupInstance)
      setupInstance = new Setup().save()
    if (!setupInstance) {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'setup.label', default: 'Setup'), params.id])}"
      redirect(action: "list")
    }
    else {
      [setupInstance: setupInstance]
    }
  }

  def addBloodType = {
    def setupInstance = Setup.get(params.id)
    setupInstance.addToBloodTypes(params.bloodType)
    render template: 'bloodTypes', model: [setupInstance: setupInstance]
  }

  def removeBloodType = {
    def setupInstance = Setup.get(params.setupInstance)
    setupInstance.removeFromBloodTypes(params.id)
    render template: 'bloodTypes', model: [setupInstance: setupInstance]
  }

  def editBloodType = {
    def setupInstance = Setup.get(params.setupInstance)
    def bloodType = params.id
    render template: 'editBloodType', model: [setupInstance: setupInstance, bloodType: params.id, i: params.i]
  }

  def updateBloodType = {
    def setupInstance = Setup.get(params.id)
    int i = setupInstance.bloodTypes.indexOf(params.bloodTypeOld)
    setupInstance.bloodTypes.set(i, params.bloodType)
    render template: 'bloodType', model: [setupInstance: setupInstance, bloodType: params.bloodType, i: params.i]
  }

  def moveUp = {
    def setupInstance = Setup.get(params.setupInstance)
    if (setupInstance.bloodTypes.indexOf(params.id) > 0) {
      int i = setupInstance.bloodTypes.indexOf(params.id)
      use(Collections){ setupInstance.bloodTypes.swap(i, i - 1) }
      render template: 'bloodTypes', model: [setupInstance: setupInstance]
    }
  }

  def moveDown = {
    def setupInstance = Setup.get(params.setupInstance)
    if (setupInstance.bloodTypes.indexOf(params.id) < setupInstance.bloodTypes.size() - 1) {
      int i = setupInstance.bloodTypes.indexOf(params.id)
      use(Collections){ setupInstance.bloodTypes.swap(i, i + 1) }
      render template: 'bloodTypes', model: [setupInstance: setupInstance]
    }
  }
}
