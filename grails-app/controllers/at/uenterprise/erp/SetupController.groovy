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

  def addElement = {
    def setupInstance = Setup.get(params.id)
    if (params.type == "bloodTypes")
      setupInstance.addToBloodTypes(params.elementName)
    else if (params.type == "nationalities")
      setupInstance.addToNationalities(params.elementName)
    else if (params.type == "languages")
      setupInstance.addToLanguages(params.elementName)
    else if (params.type == "schoolLevels")
      setupInstance.addToSchoolLevels(params.elementName)
    else if (params.type == "workDescriptions")
      setupInstance.addToWorkDescriptions(params.elementName)
    else if (params.type == "educations")
      setupInstance.addToEducations(params.elementName)
    else if (params.type == "employmentStatus")
      setupInstance.addToEmploymentStatus(params.elementName)
    else if (params.type == "responsibilities")
      setupInstance.addToResponsibilities(params.elementName)
    else if (params.type == "familyStatus")
      setupInstance.addToFamilyStatus(params.elementName)
    render template: 'allElements', model: [setupInstance: setupInstance, type: params.type]
  }

  def removeElement = {
    def setupInstance = Setup.get(params.setupInstance)
    if (params.type == "bloodTypes")
      setupInstance.removeFromBloodTypes(params.id)
    else if (params.type == "nationalities")
      setupInstance.removeFromNationalities(params.id)
    else if (params.type == "languages")
      setupInstance.removeFromLanguages(params.id)
    else if (params.type == "schoolLevels")
      setupInstance.removeFromSchoolLevels(params.id)
    else if (params.type == "workDescriptions")
      setupInstance.removeFromWorkDescriptions(params.id)
    else if (params.type == "educations")
      setupInstance.removeFromEducations(params.id)
    else if (params.type == "employmentStatus")
      setupInstance.removeFromEmploymentStatus(params.id)
    else if (params.type == "responsibilities")
      setupInstance.removeFromResponsibilities(params.id)
    else if (params.type == "familyStatus")
      setupInstance.removeFromFamilyStatus(params.id)
    render template: 'allElements', model: [setupInstance: setupInstance, type: params.type]
  }

  def editElement = {
    def setupInstance = Setup.get(params.setupInstance)
    render template: 'editElement', model: [setupInstance: setupInstance, element: params.id, type: params.type, i: params.i]
  }

  def updateElement = {
    def setupInstance = Setup.get(params.id)
    int i = setupInstance[params.type].indexOf(params.elementOld)
    setupInstance[params.type].set(i, params.element)
    render template: 'element', model: [setupInstance: setupInstance, element: params.element, type: params.type, i: params.i]
  }

  def moveUp = {
    def setupInstance = Setup.get(params.setupInstance)
    if (setupInstance[params.type].indexOf(params.id) > 0) {
      int i = setupInstance[params.type].indexOf(params.id)
      use(Collections){ setupInstance[params.type].swap(i, i - 1) }
    }
    render template: 'allElements', model: [setupInstance: setupInstance, type: params.type]
  }

  def moveDown = {
    def setupInstance = Setup.get(params.setupInstance)
    if (setupInstance[params.type].indexOf(params.id) < setupInstance[params.type].size() - 1) {
      int i = setupInstance[params.type].indexOf(params.id)
      use(Collections){ setupInstance[params.type].swap(i, i + 1) }
    }
    render template: 'allElements', model: [setupInstance: setupInstance, type: params.type]
  }

}
