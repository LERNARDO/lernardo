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
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"
      params.offset = params.int('offset') ?: 0
      params.max = Math.min(params.int('max') ?: 20, 40)

      // 1. pass - filter by object properties
      def results = Entity.createCriteria().listDistinct  {
        eq('type', params.type == "user" ? metaDataService.etUser : metaDataService.etEducator)
        user {
          eq('enabled', params.active ? true : false)
        }
        profile {
          if (params.employment)
            eq('employment', params.employment)
          order(params.sort, params.order)
        }
      }

      int totalResults = results.size()
      int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
      results = results.subList(params.offset, upperBound)

      render template: 'showpersons', model: [persons: results, totalResults: totalResults, params: params]
    }
}