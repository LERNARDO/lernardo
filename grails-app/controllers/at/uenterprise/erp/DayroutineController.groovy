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
    if (params.monday) createRoutine(entity, "monday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.tuesday) createRoutine(entity, "tuesday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.wednesday) createRoutine(entity, "wednesday", params.title, params.description, params.dateFrom, params.dateTo)
    if (params.thursday) createRoutine(entity, "thursday", params.title, params.description, params.dateFrom, params.dateToo)
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

    routine.dateFrom = Date.parse("HH:mm", params.dateFrom)
    routine.dateTo = Date.parse("HH:mm", params.dateTo)

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

    routine.dateFrom = Date.parse("HH:mm", params.dateFrom)
    routine.dateTo = Date.parse("HH:mm", params.dateTo)

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
