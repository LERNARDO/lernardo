package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService

class TimeRecordingController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService

  def index = {
    redirect action: "record", params: params
  }

  def record = {
    Entity entity = Entity.get(params.id)
    List workdaycategories = WorkdayCategory.list()

    Date date = params.date('date', 'dd. MM. yy')

    render template: "record", model: [entity: entity, workdaycategories: workdaycategories, date: date]
  }

  def showRecords = {
    Entity entity = Entity.get(params.id)

    params.date = params.date('date', 'dd. MM. yy')

    List workdayunits = []
    if (entity.type.id == metaDataService.etEducator.id || entity.type.id == metaDataService.etUser.id) {
      entity.profile.workdayunits.each { WorkdayUnit workday ->
        Date tempDate = functionService.convertFromUTC(workday.date1)
        if (tempDate.getYear() == params.date.getYear() && tempDate.getMonth() == params.date.getMonth() && tempDate.getDate() == params.date.getDate()) {
          workdayunits << workday
        }
      }
    }

      def hours = 0
      workdayunits?.each {
          hours += (it.date2.getTime() - it.date1.getTime()) / (60 * 60 * 1000)
      }

    List workdaycategories = WorkdayCategory.list().sort {it.name}

    render template: 'showrecords', model: [workdayunits: workdayunits,
        date: params.date,
        workdaycategories: workdaycategories,
        datesOrdered: true,
        entity: entity,
        currentEntity: entityHelperService.loggedIn,
        hours: hours]
  }

  def editRecord = {
    WorkdayUnit workdayUnit = WorkdayUnit.get(params.id)
    List workdaycategories = WorkdayCategory.list()

    render template: 'editrecord', model: [workdayUnit: workdayUnit, workdaycategories: workdaycategories, i: params.i, entity: Entity.get(params.entity)]
  }

  def removeRecord = {
    Entity entity = Entity.get(params.entity)
    WorkdayUnit workdayUnit = WorkdayUnit.get(params.id)

    entity.profile.removeFromWorkdayunits(workdayUnit)
    workdayUnit.delete(flush: true)

    render ""
  }

  def updateRecord = {
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

    render template: 'singlerecord', model: [unit: workdayUnit, i: params.i, currentEntity: entityHelperService.loggedIn, entity: Entity.get(params.entity)]
  }

  def addRecord = {
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
            Date workdayDate = functionService.convertFromUTC(workday.date1)
          if (workdayDate.getYear() == params.date.getYear() && workdayDate.getMonth() == params.date.getMonth() && workdayDate.getDate() == params.date.getDate()) {
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
            Date workdayDate = functionService.convertFromUTC(workday.date1)
          if (workdayDate.getYear() == params.date.getYear() && workdayDate.getMonth() == params.date.getMonth() && workdayDate.getDate() == params.date.getDate()) {
            workdayunits << workday
          }
        }
      }

        def hours = 0
        workdayunits?.each {
            hours += (it.date2.getTime() - it.date1.getTime()) / (60 * 60 * 1000)
        }

      List workdaycategories = WorkdayCategory.list()

      render template: 'showrecords', model: [workdayunits: workdayunits,
          date: params.date,
          workdaycategories: workdaycategories,
          intersection: intersection,
          datesOrdered: datesOrdered,
          entity: entity,
          currentEntity: entityHelperService.loggedIn,
          hours: hours]
    }
    else
      render {p(class: 'red', message(code: 'iebuggy'))}
  }

  def confirmDay = {
    Entity entity = Entity.get(params.id)

    List workdayunits = []
    entity.profile.workdayunits.each { workday ->
        Date workdayDate = functionService.convertFromUTC(workday.date1)
      if (workdayDate.getYear() == params.date.getYear() && workdayDate.getMonth() == params.date.getMonth() && workdayDate.getDate() == params.date.getDate()) {
        workday.confirmed = true
        workdayunits.add(workday)
      }
    }

    List workdaycategories = WorkdayCategory.list()

    render template: 'showrecords', model: [workdayunits: workdayunits,
        date: params.date,
        workdaycategories: workdaycategories,
        datesOrdered: true,
        entity: entity,
        currentEntity: entityHelperService.loggedIn]
  }

  def cancelDay = {
    Entity entity = Entity.get(params.id)

    List workdayunits = []
    entity.profile.workdayunits.each { workday ->
        Date workdayDate = functionService.convertFromUTC(workday.date1)
      if (workdayDate.getYear() == params.date.getYear() && workdayDate.getMonth() == params.date.getMonth() && workdayDate.getDate() == params.date.getDate()) {
        workday.confirmed = false
        workdayunits.add(workday)
      }
    }

    List workdaycategories = WorkdayCategory.list()

    render template: 'showrecords', model: [workdayunits: workdayunits,
        date: params.date,
        workdaycategories: workdaycategories,
        datesOrdered: true,
        entity: entity,
        currentEntity: entityHelperService.loggedIn]
  }

  def report = {
    Entity entity = Entity.get(params.id)
    render template: "report", model: [entity: entity]
  }

  def showReport = {
    Entity entity = Entity.get(params.id)
    List workdaycategories = WorkdayCategory.list()
    Date date1 = params.date('date1', 'dd. MM. yy')
    Date date2 = params.date('date2', 'dd. MM. yy')

    render template: 'showreport', model: [entity: entity, workdaycategories: workdaycategories, date1: date1, date2: date2]
  }

  def pdf = {
    Entity entity = Entity.get(params.id)
    List workdaycategories = WorkdayCategory.list()
    Date date1 = params.date('date1', 'dd. MM. yy')
    Date date2 = params.date('date2', 'dd. MM. yy')

    renderPdf template: 'pdf', model: [pageformat: params.pageformat,
        entity: entity,
        workdaycategories: workdaycategories,
        date1: date1,
        date2: date2],
        filename: message(code: 'privat.workday') + '_' + formatDate(date: date1, format: "dd.MM.yyyy") + '-' + formatDate(date: date2, format: "dd.MM.yyyy") + '.pdf'
  }

}
