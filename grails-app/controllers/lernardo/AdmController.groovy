package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link
import profiles.OperatorProfile
import de.uenterprise.ep.Account
import de.uenterprise.ep.EntityType

class AdmController {
    def metaDataService
    def entityHelperService
    def functionService
    def authenticateService

    def index = {
      redirect action:'overview'
    }

    def overview = {
      return ['operatorList': Entity.findAllByType(metaDataService.etOperator),
              'templatesList': Entity.findAllByType(metaDataService.etTemplate)]
    }

    def showFacility = {
      Entity facility = Entity.findByName(params.name)
      Entity operator = Entity.findByName(params.operator)

      List temp

      List educators = []
      temp = Link.findAllByTargetAndType(facility, metaDataService.ltWorking)
      temp.each {
          educators << it.source
      }

      List clients = []
      temp = Link.findAllByTargetAndType(facility, metaDataService.ltClientship)
      temp.each {
          clients << it.source
      }

      return [facility: facility,
              educators: educators,
              clients: clients,
              operator: operator]
    }

    def showTemplate = {
      def template = Entity.findByName(params.name)

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

    def showEducator = {
      Entity entity = Entity.findByName(params.name)
      Entity facility = Entity.findByName(params.facility)
      Entity operator = Entity.findByName(params.operator)

      return [entity: entity,
              facility: facility,
              operator: operator]
    }

    def showOperator = {
      Entity entity = Entity.findByName(params.name)

      List facilities = []
      def links = Link.findAllByTargetAndType(entity, metaDataService.ltOperation)
      links.each {
          facilities << it.source
      }
      return [entity: entity,
              facilities: facilities]
    }

    def createNotification = {
        def msgInstance = new Msg()
        return [msgInstance:msgInstance,
                entity: entityHelperService.loggedIn]
    }

    def saveNotification = {
       def userList = Entity.list()

       userList.each {
          functionService.createEvent(it, 'Du hast eine Administrator-Nachricht erhalten.')
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
       redirect controller: entityHelperService.loggedIn.type.supertype.name + 'Profile', action:"show", id: entityHelperService.loggedIn.id
    }

    def createOperator = {
      def entityInstance = new Entity()
      return ['entityInstance':entityInstance]
    }

    def saveOperator = {
      EntityType etOperator = metaDataService.etOperator

      Account user = Account.findByEmail (params.email)
      if (user) {
        flash.message = message(code:"user.existsMail", args:[params.email])
        redirect action:"createOperator", params:params
      }
      else {
        Entity etst = Entity.findByName (params.name)
        if (etst) {
          flash.message = message(code:"user.existsName", args:[params.name])
          redirect action:"createOperator", params:params
          return
        }

        entityHelperService.createEntityWithUserAndProfile (params.name, etOperator, params.email, params.fullName) {Entity ent->
          OperatorProfile prf = ent.profile
          if (params.pass)
            ent.user.password = authenticateService.encodePassword(params.pass)
        }
        flash.message = message(code:"user.created", args:[params.name,'Admin'])
        redirect action:'overview'
      }
    }

    def editOperator = {
        def entityInstance = Entity.findByName(params.name)

        if(!entityInstance) {
            flash.message = message(code:"user.notFound", args:[params.name])
            redirect action:'showProfile', model:[name:params.name]
        }
        else {
            return [entityInstance :entityInstance]
        }
    }

    def updateOperator = {
       def entityInstance = Entity.get( params.id )
       if(entityInstance) {
           entityInstance.properties = params
           entityInstance.profile.fullName = params.fullName
           entityInstance.profile.PLZ = params.PLZ.toInteger()
           entityInstance.profile.city = params.city
           entityInstance.profile.street = params.street
           entityInstance.profile.tel = params.tel
           entityInstance.profile.description = params.description
           if (params.showTips)
             entityInstance.profile.showTips = true
           else
             entityInstance.profile.showTips = false
         if(!entityInstance.hasErrors() && entityInstance.save()) {
               flash.message = message(code:"user.updated", args:[entityInstance.profile.fullName])
               redirect action:'showOperator', params:[name:entityInstance.name]
           }
           else {
               render view:'editOperator', model:[entityInstance:entityInstance]
           }
       }
       else {
           flash.message = message(code:"user.notFound", args:[params.id])
           redirect action:'overview'
       }
   }
}
