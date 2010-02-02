package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

class AdmController {
    def metaDataService

    def index = {
      redirect action:'listFacilities'
    }

    def listFacilities = {
      List facilityList = Entity.findAllByType(metaDataService.etHort)

      return [facilityList: facilityList]
    }

    def showFacility = {
      Entity facility = Entity.findByName(params.name)

      List temp

      List paedList = []
      temp = Link.findAllByTargetAndType(facility, metaDataService.ltWorking)
      temp.each {
          paedList << it.source
      }

      List clientList = []
      temp = Link.findAllByTargetAndType(facility, metaDataService.ltClientship)
      temp.each {
          clientList << it.source
      }

      return [facility: facility,
              paedList: paedList,
              clientList: clientList]
    }

    def showClient = {
      Entity entity = Entity.findByName(params.name)
      Entity facility = Entity.findByName(params.facility)

      return [entity: entity,
              facility: facility]
    }

    def showPaed = {
      Entity entity = Entity.findByName(params.name)
      Entity facility = Entity.findByName(params.facility)

      return [entity: entity,
              facility: facility]
    }
}
