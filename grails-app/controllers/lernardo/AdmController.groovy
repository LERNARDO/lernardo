package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

class AdmController {
    def metaDataService

    def index = {
      redirect action:'overview'
    }

    def overview = {
      List operatorList = Entity.findAllByType(metaDataService.etOperator)
      List templatesList = ActivityTemplate.list()

      return [operatorList: operatorList,
              templatesList: templatesList]
    }

    def showFacility = {
      Entity facility = Entity.findByName(params.name)
      Entity operator = Entity.findByName(params.operator)

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
              clientList: clientList,
              operator: operator]
    }

    def showTemplate = {
      ActivityTemplate template = ActivityTemplate.findByName(params.name)

      return [template: template]
    }

    def showClient = {
      Entity entity = Entity.findByName(params.name)
      Entity facility = Entity.findByName(params.facility)
      Entity operator = Entity.findByName(params.operator)

      return [entity: entity,
              facility: facility,
              operator: operator]
    }

    def showPaed = {
      Entity entity = Entity.findByName(params.name)
      Entity facility = Entity.findByName(params.facility)
      Entity operator = Entity.findByName(params.operator)

      return [entity: entity,
              facility: facility,
              operator: operator]
    }

    def showOperator = {
      Entity entity = Entity.findByName(params.name)

      List facilityList = []
      List temp = Link.findAllByTargetAndType(entity, metaDataService.ltOperation)
      temp.each {
          facilityList << it.source
      }
      return [entity: entity,
              facilityList: facilityList]
    }
}
