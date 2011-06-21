package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class WorkdayUnitController {
    FunctionService functionService

    EntityHelperService entityHelperService
    MetaDataService metaDataService

    def beforeInterceptor = [
            action:{
              params.date = params.date ? Date.parse("dd. MM. yy", params.date) : null}, only:['showunits']
    ]

    def index = {
      List workdaycategories = WorkdayCategory.list()
      Entity entity = Entity.get(params.id)
      return [entity: entity, workdaycategories: workdaycategories]
    }

    def showunits = {
      Entity entity = Entity.get(params.id)

      List workdayunits = []
      if (entity.type.id == metaDataService.etEducator.id) {
        entity.profile.workdayunits.each { workday ->
          if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
            workdayunits << workday
          }
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'workdayunits', model:[workdayunits: workdayunits,
                                              date: params.date,
                                              workdaycategories: workdaycategories,
                                              datesOrdered: true,
                                              entity: entity,
                                              currentEntity: entityHelperService.loggedIn]
    }

    def removeUnit = {
      Entity entity = Entity.get(params.entity)

      WorkdayUnit workdayUnit = WorkdayUnit.get(params.id)

      entity.profile.removeFromWorkdayunits(workdayUnit)
      workdayUnit.delete(flush: true)

      render ""
    }

    def editUnit = {
      WorkdayUnit workdayUnit = WorkdayUnit.get(params.id)

      List workdaycategories = WorkdayCategory.list()

      render template: 'editunit', model: [workdayUnit: workdayUnit, workdaycategories: workdaycategories, i: params.i, entity: Entity.get(params.entity)]
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
      workdayUnit.date1 = functionService.convertToUTC(workdayUnit.date1)

      // set end
      calendar.set (Calendar.HOUR_OF_DAY, params.int('toHour'))
      calendar.set (Calendar.MINUTE, params.int('toMinute'))
      workdayUnit.date2 = calendar.getTime()
      workdayUnit.date2 = functionService.convertToUTC(workdayUnit.date2)

      workdayUnit.save(flush: true)

      render template: 'unit', model: [unit: workdayUnit, i: params.i, currentEntity: entityHelperService.loggedIn, entity: Entity.get(params.entity)]
    }

    def addWorkdayUnit = {
      Entity entity = Entity.get(params.id)

      WorkdayUnit workdayUnit = new WorkdayUnit(params)

      Calendar calendar = Calendar.getInstance()

      // set start
      calendar.setTime(params.date)
      calendar.set (Calendar.HOUR_OF_DAY, params.int('fromHour'))
      calendar.set (Calendar.MINUTE, params.int('fromMinute'))
      workdayUnit.date1 = calendar.getTime()
      workdayUnit.date1 = functionService.convertToUTC(workdayUnit.date1)

      // set end
      calendar.set (Calendar.HOUR_OF_DAY, params.int('toHour'))
      calendar.set (Calendar.MINUTE, params.int('toMinute'))
      workdayUnit.date2 = calendar.getTime()
      workdayUnit.date2 = functionService.convertToUTC(workdayUnit.date2)

      // check if the end date is after the begin date
      boolean datesOrdered = true
      if (workdayUnit.date1 > workdayUnit.date2)
        datesOrdered = false

      // check if the to be created workday unit does intersect with an already existing workday unit
      List existingWorkdayunits = []
      if (entity.type.id == metaDataService.etEducator.id) {
        entity.profile.workdayunits.each { workday ->
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

      if (!intersection && datesOrdered) {
            // create it
            workdayUnit.save(flush: true)
            entity.profile.addToWorkdayunits(workdayUnit)
      }

      List workdayunits = []
      if (entity.type.id == metaDataService.etEducator.id) {
        entity.profile.workdayunits.each { workday ->
          if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
            workdayunits << workday
          }
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'workdayunits', model:[workdayunits: workdayunits,
                                              date: params.date,
                                              workdaycategories: workdaycategories,
                                              intersection: intersection,
                                              datesOrdered: datesOrdered,
                                              entity: entity,
                                              currentEntity: entityHelperService.loggedIn]
    }

    def confirmDays = {
      Entity entity = Entity.get(params.id)

      List workdayunits = []
      entity.profile.workdayunits.each { workday ->
        if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
          workday.confirmed = true
          workdayunits.add(workday)
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'workdayunits', model:[workdayunits: workdayunits,
                                              date: params.date,
                                              workdaycategories: workdaycategories,
                                              datesOrdered: true,
                                              entity: entity,
                                              currentEntity: entityHelperService.loggedIn]
    }
}