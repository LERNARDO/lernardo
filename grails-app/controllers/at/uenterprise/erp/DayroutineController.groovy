package at.uenterprise.erp

import at.openfactory.ep.Entity

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

    return [routines: routines, entity: entity, day: day]
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
    if (params.monday) createRoutine(entity, "monday")
    if (params.tuesday) createRoutine(entity, "tuesday")
    if (params.wednesday) createRoutine(entity, "wednesday")
    if (params.thursday) createRoutine(entity, "thursday")
    if (params.friday) createRoutine(entity, "friday")
    if (params.saturday) createRoutine(entity, "saturday")
    if (params.sunday) createRoutine(entity, "sunday")

    // find all routines of that day and facility
    List routines = Dayroutine.findAllByFacilityAndDay(entity, 'monday').sort() {it.dateFrom.getHours()}

    render template: "routineday", model: [routines: routines, entity: entity, day: 'monday']
  }

  void createRoutine (entity, day) {
    Dayroutine routine = new Dayroutine(params)
    routine.facility = entity
    routine.day = day
    routine.dateFrom = new Date()
    routine.dateTo = new Date()

    routine.dateFrom.setHours(params.int('dateFromHour'))
    routine.dateFrom.setMinutes(params.int('dateFromMinute'))

    routine.dateTo.setHours(params.int('dateToHour'))
    routine.dateTo.setMinutes(params.int('dateToMinute'))

    routine.dateFrom = functionService.convertToUTC(routine.dateFrom)
    routine.dateTo = functionService.convertToUTC(routine.dateTo)

    routine.save(flush: true)
  }

  def editroutine = {
    Dayroutine routine = Dayroutine.get(params.id)

    render template: "editroutine", model:[routine: routine, i: params.i]
  }

  def updateroutine = {
    Dayroutine routine = Dayroutine.get(params.id)
    routine.properties = params

    routine.dateFrom.setHours(params.int('dateFromHour'))
    routine.dateFrom.setMinutes(params.int('dateFromMinute'))

    routine.dateTo.setHours(params.int('dateToHour'))
    routine.dateTo.setMinutes(params.int('dateToMinute'))

    routine.dateFrom = functionService.convertToUTC(routine.dateFrom)
    routine.dateTo = functionService.convertToUTC(routine.dateTo)

    routine.save(flush:true)
    render template: "routine", model:[routine: routine, i: params.i]
  }

  def deleteroutine = {
    Dayroutine routine = Dayroutine.get(params.id)

    routine.delete()

    render ""
  }

}
