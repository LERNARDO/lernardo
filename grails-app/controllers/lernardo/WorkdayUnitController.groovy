package lernardo

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class WorkdayUnitController {

    EntityHelperService entityHelperService

    def beforeInterceptor = [
            action:{
              params.date = params.date ? Date.parse("dd. MM. yy", params.date) : null}, only:['showunits']
    ]

    def index = { }

    def showunits = {
      Entity currentEntity = entityHelperService.loggedIn

      List workdayunits = []
      currentEntity.profile.workdayunits.each { workday ->
        if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
          workdayunits << workday
        }
      }

      render template: 'workdayunits', model:[workdayunits: workdayunits, date: params.date]
    }

    def addWorkdayUnit = {
      println params
      Entity currentEntity = entityHelperService.loggedIn

      WorkdayUnit workdayUnit = new WorkdayUnit(params)
      workdayUnit.date1 = params.date
      workdayUnit.date2 = params.date

      // something is broken here, date saving behaves weird

      println "dateFrom: ${workdayUnit.date1}"
      println "dateTo: ${workdayUnit.date2}"

      workdayUnit.date1.setHours(params.int('fromHour'))
      workdayUnit.date1.setMinutes(params.int('fromMinute'))

      println "dateFrom: ${workdayUnit.date1}"
      println "dateTo: ${workdayUnit.date2}"

      workdayUnit.date2.setHours(params.int('toHour'))
      workdayUnit.date2.setMinutes(params.int('toMinute'))

      println "dateFrom: ${workdayUnit.date1}"
      println "dateTo: ${workdayUnit.date2}"

      workdayUnit.save(flush: true)
      currentEntity.profile.addToWorkdayunits(workdayUnit)

      List workdayunits = []
      currentEntity.profile.workdayunits.each { workday ->
        if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
          workdayunits << workday
        }
      }

      render template: 'workdayunits', model:[workdayunits: workdayunits, date: params.date]
    }
}
