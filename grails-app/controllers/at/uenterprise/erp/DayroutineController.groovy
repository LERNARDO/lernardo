package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import grails.converters.JSON

class DayroutineController {
  FunctionService functionService

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    Entity entity = Entity.get(params.id)

    def day = params.day ?: 'monday'

    // find all routines of that day and facility
    List routines = Dayroutine.findAllByFacilityAndDay(entity, day).sort() {it.dateFrom.getHours()}

    render template: "list", model: [routines: routines, entity: entity, day: day]
  }

  def updateday = {
    Entity entity = Entity.get(params.id)

    def day = params.day ?: 'monday'

    // find all routines of that day and facility
    List routines = Dayroutine.findAllByFacilityAndDay(entity, day).sort() {it.dateFrom.getHours()}

    render template: "routineday", model: [routines: routines, entity: entity, day: day]
  }

  def save = {
    Entity entity = Entity.get(params.id)

    // create a day routine for every day marked
    if (params.monday) createRoutine(entity, "monday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.tuesday) createRoutine(entity, "tuesday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.wednesday) createRoutine(entity, "wednesday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.thursday) createRoutine(entity, "thursday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.friday) createRoutine(entity, "friday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.saturday) createRoutine(entity, "saturday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.sunday) createRoutine(entity, "sunday", params.title, params.description, params.dateFrom, params.dateTo)

    // find all routines of that day and facility
    List routines = Dayroutine.findAllByFacilityAndDay(entity, 'monday').sort() {it.dateFrom.getHours()}

    render template: "routineday", model: [routines: routines, entity: entity, day: 'monday']
  }

  void createRoutine (entity, day, title, description, dateFrom, dateTo) {
    Dayroutine routine = new Dayroutine()
    routine.facility = entity
    routine.day = day
    routine.title = title
    routine.description = description

    routine.dateFrom = Date.parse("HH:mm", dateFrom)
    routine.dateTo = Date.parse("HH:mm", dateTo)

    routine.dateFrom = functionService.convertToUTC(routine.dateFrom)
    routine.dateTo = functionService.convertToUTC(routine.dateTo)

    routine.save(flush: true)
  }

  def editroutine = {
    Dayroutine routine = Dayroutine.get(params.id)

    render template: "editroutine", model: [routine: routine, i: params.i]
  }

  def updateroutine = {
    Dayroutine routine = Dayroutine.get(params.id)
    routine.properties = params

    routine.dateFrom = params.date('dateFrom', 'HH:mm')
    routine.dateTo = params.date('dateTo', 'HH:mm')

    routine.dateFrom = functionService.convertToUTC(routine.dateFrom)
    routine.dateTo = functionService.convertToUTC(routine.dateTo)

    routine.save(flush:true)
    render template: "routine", model: [routine: routine, i: params.i]
  }

  def deleteroutine = {
    Dayroutine routine = Dayroutine.get(params.id)

    routine.delete()

    render ""
  }

  def showDayRoutines = {
    Entity entity = Entity.get(params.id)

    // find all routines of the facility
    List routines = Dayroutine.findAllByFacility(entity)

    def start = new Date()
    start.setTime(params.long('start') * 1000)
    start.setHours(0)
    start.setMinutes(0)

    def end = new Date()
    end.setTime(params.long('end') * 1000)
    end.setHours(23)
    end.setMinutes(59)

    def eventList = []

    def color = '#8ac'

    Calendar tcalendarStart = new GregorianCalendar()
    tcalendarStart.setTime(start)
    tcalendarStart.add(Calendar.DATE, 1)

    Calendar tcalendarEnd = new GregorianCalendar()
    tcalendarEnd.setTime(end)

    while (tcalendarStart <= tcalendarEnd) {
      Date currentDate = tcalendarStart.getTime()

      routines?.each { Dayroutine routine ->
        if ((routine.day == "sunday" && currentDate.getDay() == 0) ||
            (routine.day == "monday" && currentDate.getDay() == 1) ||
            (routine.day == "tuesday" && currentDate.getDay() == 2) ||
            (routine.day == "wednesday" && currentDate.getDay() == 3) ||
            (routine.day == "thursday" && currentDate.getDay() == 4) ||
            (routine.day == "friday" && currentDate.getDay() == 5) ||
            (routine.day == "saturday" && currentDate.getDay() == 6)) {

          def title = routine.title
          def description = routine.description
          routine.dateFrom.setYear(currentDate.getYear())
          routine.dateFrom.setMonth(currentDate.getMonth())
          routine.dateFrom.setDate(currentDate.getDate())
          routine.dateTo.setYear(currentDate.getYear())
          routine.dateTo.setMonth(currentDate.getMonth())
          routine.dateTo.setDate(currentDate.getDate())
          eventList << [id: routine.id, title: title, start: functionService.convertFromUTC(routine.dateFrom), end: functionService.convertFromUTC(routine.dateTo), allDay: false, color: color, description: description]
        }
      }
      tcalendarStart.add(Calendar.DATE, 1)

    }

    def json = eventList as JSON
    render json
  }

}
