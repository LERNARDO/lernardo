package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class WorkdayUnitController {

    EntityHelperService entityHelperService
    MetaDataService metaDataService

    def beforeInterceptor = [
            action:{
              params.date = params.date ? Date.parse("dd. MM. yy", params.date) : null}, only:['showunits']
    ]

    def index = {
      List workdaycategories = WorkdayCategory.list()
      return [workdaycategories: workdaycategories]
    }

    def showunits = {
      Entity currentEntity = entityHelperService.loggedIn

      List workdayunits = []
      if (currentEntity.type.id == metaDataService.etEducator.id) {
        currentEntity.profile.workdayunits.each { workday ->
          if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
            workdayunits << workday
          }
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'workdayunits', model:[workdayunits: workdayunits, date: params.date, workdaycategories: workdaycategories]
    }

    def removeUnit = {
      Entity currentEntity = entityHelperService.loggedIn

      WorkdayUnit workdayUnit = WorkdayUnit.get(params.id)

      currentEntity.profile.removeFromWorkdayunits(workdayUnit)
      workdayUnit.delete(flush: true)

      render ""
    }

    def editUnit = {
      WorkdayUnit workdayUnit = WorkdayUnit.get(params.id)

      List workdaycategories = WorkdayCategory.list()

      render template: 'editunit', model: [workdayUnit: workdayUnit, workdaycategories: workdaycategories, i: params.i]
    }

    def updateUnit = {
      WorkdayUnit workdayUnit = WorkdayUnit.get(params.id)

      workdayUnit.properties = params

      Calendar calendar = Calendar.getInstance()

      // set start
      calendar.setTime(workdayUnit.date1)
      calendar.set (Calendar.HOUR_OF_DAY, params.int('fromHour'))
      calendar.set (Calendar.MINUTE, params.int('fromMinute'))
      workdayUnit.date1 = calendar.getTime()

      // set end
      calendar.set (Calendar.HOUR_OF_DAY, params.int('toHour'))
      calendar.set (Calendar.MINUTE, params.int('toMinute'))
      workdayUnit.date2 = calendar.getTime()

      workdayUnit.save(flush: true)

      render template: 'unit', model: [unit: workdayUnit, i: params.i]
    }

    def addWorkdayUnit = {
      Entity currentEntity = entityHelperService.loggedIn

      WorkdayUnit workdayUnit = new WorkdayUnit(params)

      Calendar calendar = Calendar.getInstance()

      // set start
      calendar.setTime(params.date)
      calendar.set (Calendar.HOUR_OF_DAY, params.int('fromHour'))
      calendar.set (Calendar.MINUTE, params.int('fromMinute'))
      workdayUnit.date1 = calendar.getTime()

      // set end
      calendar.set (Calendar.HOUR_OF_DAY, params.int('toHour'))
      calendar.set (Calendar.MINUTE, params.int('toMinute'))
      workdayUnit.date2 = calendar.getTime()

      // check if the to be created workday unit does intersect with an already existing workday unit
      List existingWorkdayunits = []
      if (currentEntity.type.id == metaDataService.etEducator.id) {
        currentEntity.profile.workdayunits.each { workday ->
          if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
            existingWorkdayunits << workday
          }
        }
      }

      boolean intersection = false
      existingWorkdayunits.each { checked ->
          if (!(workdayUnit.date1 >= checked.date2 || workdayUnit.date2 <= checked.date1)) {
            // intersection, don't create
            intersection = true
          }
      }

      if (!intersection) {
            // create it
            workdayUnit.save(flush: true)
            currentEntity.profile.addToWorkdayunits(workdayUnit)
      }

      List workdayunits = []
      if (currentEntity.type.id == metaDataService.etEducator.id) {
        currentEntity.profile.workdayunits.each { workday ->
          if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
            workdayunits << workday
          }
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'workdayunits', model:[workdayunits: workdayunits, date: params.date, workdaycategories: workdaycategories, intersection: intersection]
    }

    def confirmDays = {
      Entity currentEntity = entityHelperService.loggedIn

      List workdayunits = []
      currentEntity.profile.workdayunits.each { workday ->
        if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
          workday.confirmed = true
          workdayunits.add(workday)
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'workdayunits', model:[workdayunits: workdayunits, date: params.date, workdaycategories: workdaycategories]
    }
}
