package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService

class WorkdayUnitController {
    FunctionService functionService

    EntityHelperService entityHelperService
    MetaDataService metaDataService

    def beforeInterceptor = [
            action:{
              params.date = params.date('date', 'dd. MM. yy')},
            only:['showunits']
    ]

    def index = {
      List workdaycategories = WorkdayCategory.list()
      Entity entity = Entity.get(params.id)
      return [entity: entity, workdaycategories: workdaycategories]
    }

    def report = {
      Entity entity = Entity.get(params.id)
      return [entity: entity]
    }

    def showreport = {
      Entity entity = Entity.get(params.id)
      List workdaycategories = WorkdayCategory.list()
      Date date1 = params.date('date1', 'dd. MM. yy')
      Date date2 = params.date('date2', 'dd. MM. yy')
      render template: 'results', model: [entity: entity, workdaycategories: workdaycategories, date1: date1, date2: date2]
    }

    def createpdf = {
      Entity entity = Entity.get(params.id)
      List workdaycategories = WorkdayCategory.list()
      Date date1 = params.date('date1', 'dd. MM. yy')
      Date date2 = params.date('date2', 'dd. MM. yy')
      renderPdf template: 'createpdf', model: [pageformat: params.pageformat, entity: entity, workdaycategories: workdaycategories, date1: date1, date2: date2], filename: message(code: 'privat.workday') + '_' + formatDate(date: date1, format: "dd.MM.yyyy") + '-' + formatDate(date: date2, format: "dd.MM.yyyy") + '.pdf'
    }

    def showunits = {
      Entity entity = Entity.get(params.id)

      List workdayunits = []
      if (entity.type.id == metaDataService.etEducator.id || entity.type.id == metaDataService.etUser.id) {
        entity.profile.workdayunits.each { WorkdayUnit workday ->
          Date tempDate = functionService.convertFromUTC(workday.date1)
          if (tempDate.getYear() == params.date.getYear() && tempDate.getMonth() == params.date.getMonth() && tempDate.getDate() == params.date.getDate()) {
            workdayunits << workday
          }
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'workdayunits', model: [workdayunits: workdayunits,
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
      Date from = params.date('from', 'HH:mm')
      calendar.setTime(workdayUnit.date1)
      calendar.set (Calendar.HOUR_OF_DAY, from.getHours())
      calendar.set (Calendar.MINUTE, from.getMinutes())
      workdayUnit.date1 = calendar.getTime()
      workdayUnit.date1 = functionService.convertToUTC(workdayUnit.date1)

      // set end
      Date to = params.date('to', 'HH:mm')
      calendar.set (Calendar.HOUR_OF_DAY, to.getHours())
      calendar.set (Calendar.MINUTE, to.getMinutes())
      workdayUnit.date2 = calendar.getTime()
      workdayUnit.date2 = functionService.convertToUTC(workdayUnit.date2)

      workdayUnit.save(flush: true)

      render template: 'unit', model: [unit: workdayUnit, i: params.i, currentEntity: entityHelperService.loggedIn, entity: Entity.get(params.entity)]
    }

    def addWorkdayUnit = {
      Entity entity = Entity.get(params.id)

      // FIXME: workaround for IE not sending any formular data
      if (params.date) {
        WorkdayUnit workdayUnit = new WorkdayUnit(params)

        Calendar calendar = Calendar.getInstance()

        // set start
        Date from = params.date('from', 'HH:mm')
        calendar.setTime(params.date)
        calendar.set (Calendar.HOUR_OF_DAY, from.getHours())
        calendar.set (Calendar.MINUTE, from.getMinutes())
        workdayUnit.date1 = calendar.getTime()
        workdayUnit.date1 = functionService.convertToUTC(workdayUnit.date1)

        // set end
        Date to = params.date('to', 'HH:mm')
        calendar.set (Calendar.HOUR_OF_DAY, to.getHours())
        calendar.set (Calendar.MINUTE, to.getMinutes())
        workdayUnit.date2 = calendar.getTime()
        workdayUnit.date2 = functionService.convertToUTC(workdayUnit.date2)

        // check if the end date is after the begin date
        boolean datesOrdered = true
        if (workdayUnit.date1 > workdayUnit.date2)
          datesOrdered = false

        // check if the to be created workday unit does intersect with an already existing workday unit
        List existingWorkdayunits = []
        if (entity.type.id == metaDataService.etEducator.id || entity.type.id == metaDataService.etUser.id) {
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
        if (entity.type.id == metaDataService.etEducator.id || entity.type.id == metaDataService.etUser.id) {
          entity.profile.workdayunits.each { workday ->
            if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
              workdayunits << workday
            }
          }
        }

        List workdaycategories = WorkdayCategory.list()


        render template: 'workdayunits', model: [workdayunits: workdayunits,
                                                date: params.date,
                                                workdaycategories: workdaycategories,
                                                intersection: intersection,
                                                datesOrdered: datesOrdered,
                                                entity: entity,
                                                currentEntity: entityHelperService.loggedIn]
      }
      else
        render '<p class="red">' + message(code:"iebuggy") + '</p>'
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

      render template: 'workdayunits', model: [workdayunits: workdayunits,
                                              date: params.date,
                                              workdaycategories: workdaycategories,
                                              datesOrdered: true,
                                              entity: entity,
                                              currentEntity: entityHelperService.loggedIn]
    }

    def cancelDays = {
      Entity entity = Entity.get(params.id)

      List workdayunits = []
      entity.profile.workdayunits.each { workday ->
        if (workday.date1.getYear() == params.date.getYear() && workday.date1.getMonth() == params.date.getMonth() && workday.date1.getDate() == params.date.getDate()) {
          workday.confirmed = false
          workdayunits.add(workday)
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'workdayunits', model: [workdayunits: workdayunits,
                                              date: params.date,
                                              workdaycategories: workdaycategories,
                                              datesOrdered: true,
                                              entity: entity,
                                              currentEntity: entityHelperService.loggedIn]
    }

    def evaluation = {}

    def evaluate = {
      List employments = Setup.list()[0]?.employmentStatus

      Map educators = [:]

      employments?.eachWithIndex { emp, i ->
        List eds =  Entity.createCriteria().list {
          eq("type", metaDataService.etEducator)
          profile {
            eq('employment', emp)
            order('firstName','asc')
          }
        }
        if (eds.size() > 0)
          educators.putAt(i.toString(), eds)
      }
      List users = Entity.createCriteria().list {
        eq("type", metaDataService.etUser)
        profile {
          order('firstName','asc')
        }
      }

      List workdaycategories = WorkdayCategory.list()

      render template: 'evaluate', model: [educators: educators,
                                           users: users,
                                          workdaycategories: workdaycategories,
                                          date1: params.date1,
                                          date2: params.date2]
    }

    def evaluatePDF = {
      Date date1 = params.date('date1', 'dd. MM. yy')
      Date date2 = params.date('date2', 'dd. MM. yy')

      List employments = Setup.list()[0]?.employmentStatus

      Map educators = [:]

      employments?.eachWithIndex { emp, i ->
        List eds =  Entity.createCriteria().list {
          eq("type", metaDataService.etEducator)
          profile {
            eq('employment', emp)
            order('firstName','asc')
          }
        }
        if (eds.size() > 0)
          educators.putAt(i.toString(), eds)
      }
      List users = Entity.createCriteria().list {
        eq("type", metaDataService.etUser)
        profile {
          order('firstName','asc')
        }
      }

      List workdaycategories = WorkdayCategory.list()
      Entity currentEntity = entityHelperService.loggedIn
      renderPdf template: 'evaluatePDF', model: [educators: educators,
                                                 users: users,
                                                 workdaycategories: workdaycategories,
                                                 entity: currentEntity,
                                                 date1: params.date1, date2: params.date2],
                                                 filename: message(code: 'timeEvaluation') + '_' + formatDate(date: date1, format: "dd.MM.yyyy") + '-' + formatDate(date: date2, format: "dd.MM.yyyy") + '.pdf'
    }

    def workhours = {
      List persons = Entity.findAllByTypeOrType(metaDataService.etEducator, metaDataService.etUser)
      return [persons: persons]
    }

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
}