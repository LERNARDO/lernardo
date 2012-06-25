package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService

class WorkdayUnitController {
    FunctionService functionService
    EntityHelperService entityHelperService
    MetaDataService metaDataService

    def workhours = {}

    def changeWorkHours = {
      Entity person = Entity.get(params.id)
      render template: 'editworkhours', model: [person: person, i: params.i]
    }

    def updateWorkHours = {
      Entity person = Entity.get(params.id)
      person.profile.properties = params
      person.profile.save()
      render template: 'showworkhours', model: [person: person, i: params.i]
    }

    def changeWorkDays = {
      Entity person = Entity.get(params.id)
      render template: 'editworkdays', model: [person: person, i: params.i]
    }

    def updateWorkDays = {
      Entity person = Entity.get(params.id)
      person.profile.workDays = params.int('workDays')
      person.profile.save()
      render template: 'showworkdays', model: [person: person, i: params.i]
    }

    def changeHourlyWage = {
      Entity person = Entity.get(params.id)
      render template: 'edithourlywage', model: [person: person, i: params.i]
    }

    def updateHourlyWage = {
      Entity person = Entity.get(params.id)
      person.profile.hourlyWage = params.int('hourlyWage')
      person.profile.save()
      render template: 'showhourlywage', model: [person: person, i: params.i]
    }

    def changeOvertimePay = {
      Entity person = Entity.get(params.id)
      render template: 'editovertimepay', model: [person: person, i: params.i]
    }

    def updateOvertimePay = {
      Entity person = Entity.get(params.id)
      person.profile.overtimePay = params.int('overtimePay')
      person.profile.save()
      render template: 'showovertimepay', model: [person: person, i: params.i]
    }

    def showPersons = {
      List persons = Entity.findAllByType(params.type == "user" ? metaDataService.etUser: metaDataService.etEducator).findAll {it.user.enabled}
      render template: "showpersons", model: [persons: persons]
    }
}