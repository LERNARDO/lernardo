package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

class AdmController {
    def metaDataService
    def entityHelperService
    def FunctionService

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

    def createNotification = {
        def msgInstance = new Msg()
        return [msgInstance:msgInstance,
                entity: entityHelperService.loggedIn]
    }

    def saveNotification = {

       def userList = Entity.list()

       userList.each {

          FunctionService.createEvent(it, 'Du hast eine Administrator-Nachricht erhalten.')
          def msgInstance = new Msg(params)
          msgInstance.entity = it
          msgInstance.dateCreated = new Date()
          msgInstance.sender = Entity.findByName('admin')
          msgInstance.receiver = it

          if(!msgInstance.save(flush:true)) {
              log.debug ("Notification for user" + msgInstance.entity + "could not be saved")
          }
       }
       flash.message = message(code:"admin.notificationSuccess")
       redirect controller:"profile", action:"showProfile", params:[name:entityHelperService.loggedIn.name]
    }
}
