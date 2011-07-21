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
      setupInstance.addToBloodTypes(params.elementName.toString())
    else if (params.type == "nationalities")
      setupInstance.addToNationalities(params.elementName.toString())
    else if (params.type == "languages")
      setupInstance.addToLanguages(params.elementName.toString())
    else if (params.type == "schoolLevels")
      setupInstance.addToSchoolLevels(params.elementName.toString())
    else if (params.type == "workDescriptions")
      setupInstance.addToWorkDescriptions(params.elementName.toString())
    else if (params.type == "educations")
      setupInstance.addToEducations(params.elementName.toString())
    else if (params.type == "employmentStatus")
      setupInstance.addToEmploymentStatus(params.elementName.toString())
    else if (params.type == "responsibilities")
      setupInstance.addToResponsibilities(params.elementName.toString())
    else if (params.type == "familyStatus")
      setupInstance.addToFamilyStatus(params.elementName.toString())
    else if (params.type == "maritalStatus")
      setupInstance.addToMaritalStatus(params.elementName.toString())
    else if (params.type == "partnerServices")
      setupInstance.addToPartnerServices(params.elementName.toString())
    else if (params.type == "familyProblems")
      setupInstance.addToFamilyProblems(params.elementName.toString())
    render template: 'allElements', model: [setupInstance: setupInstance, type: params.type]
  }

  def removeElement = {
    def setupInstance = Setup.get(params.setupInstance)
    if (params.type == "bloodTypes")
      setupInstance.removeFromBloodTypes(params.element.decodeHTML())
    else if (params.type == "nationalities")
      setupInstance.removeFromNationalities(params.element.decodeHTML())
    else if (params.type == "languages")
      setupInstance.removeFromLanguages(params.element.decodeHTML())
    else if (params.type == "schoolLevels")
      setupInstance.removeFromSchoolLevels(params.element.decodeHTML())
    else if (params.type == "workDescriptions")
      setupInstance.removeFromWorkDescriptions(params.element.decodeHTML())
    else if (params.type == "educations")
      setupInstance.removeFromEducations(params.element.decodeHTML())
    else if (params.type == "employmentStatus")
      setupInstance.removeFromEmploymentStatus(params.element.decodeHTML())
    else if (params.type == "responsibilities")
      setupInstance.removeFromResponsibilities(params.element.decodeHTML())
    else if (params.type == "familyStatus")
      setupInstance.removeFromFamilyStatus(params.element.decodeHTML())
    else if (params.type == "maritalStatus")
      setupInstance.removeFromMaritalStatus(params.element.decodeHTML())
    else if (params.type == "partnerServices")
      setupInstance.removeFromPartnerServices(params.element.decodeHTML())
    else if (params.type == "familyProblems")
      setupInstance.removeFromFamilyProblems(params.element.decodeHTML())
    render template: 'allElements', model: [setupInstance: setupInstance, type: params.type]
  }

  def editElement = {
    log.info 'params for edit:'+ params
    def setupInstance = Setup.get(params.setupInstance)
    render template: 'editElement', model: [setupInstance: setupInstance, element: params.element.decodeHTML(), type: params.type, i: params.i]
  }

  def updateElement = {
    log.info 'params for update:'+params
    def setupInstance = Setup.get(params.id)

    params.elementOld = params.elementOld.decodeHTML()

    log.info 'element to update: "' + params.elementOld + '"'
    log.info 'element index in list: ' + setupInstance[params.type].indexOf(params.elementOld)

    int i = setupInstance[params.type].indexOf(params.elementOld)
    setupInstance[params.type].set(i, params.element)
    render template: 'element', model: [setupInstance: setupInstance, element: params.element, type: params.type, i: params.i]
  }

  def moveUp = {
    log.info 'params for moveUp:' + params
    def setupInstance = Setup.get(params.setupInstance)
    if (setupInstance[params.type].indexOf(params.element.decodeHTML()) > 0) {
      int i = setupInstance[params.type].indexOf(params.element.decodeHTML())
      use(Collections){ setupInstance[params.type].swap(i, i - 1) }
    }
    render template: 'allElements', model: [setupInstance: setupInstance, type: params.type]
  }

  def moveDown = {
    log.info 'params for moveDown:' + params
    def setupInstance = Setup.get(params.setupInstance)
    if (setupInstance[params.type].indexOf(params.element.decodeHTML()) < setupInstance[params.type].size() - 1) {
      int i = setupInstance[params.type].indexOf(params.element.decodeHTML())
      use(Collections){ setupInstance[params.type].swap(i, i + 1) }
    }
    render template: 'allElements', model: [setupInstance: setupInstance, type: params.type]
  }

}
