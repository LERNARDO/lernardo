package at.uenterprise.erp

import at.openfactory.ep.Entity

class DayroutineController {

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    Entity entity = Entity.get(params.id)

    def day = params.day ?: 'monday'

    // find all routines of that day and facility
    List routines = Dayroutine.findAllByFacilityAndDay(entity, day) //.sort() {it.from}

    return [routines: routines, entity: entity, day: day]
  }

  def updateday = {
    Entity entity = Entity.get(params.id)

    def day = params.day ?: 'monday'

    // find all routines of that day and facility
    List routines = Dayroutine.findAllByFacilityAndDay(entity, day) //.sort() {it.from}

    render template: "routineday", model: [routines: routines, entity: entity, day: day]
  }

  def save = {
    Entity entity = Entity.get(params.id)

    Dayroutine routine = new Dayroutine(params)
    routine.facility = entity
    routine.day = params.day
    routine.dateFrom = new Date()
    routine.dateTo = new Date()

    routine.dateFrom.setHours(params.int('dateFromHour'))
    routine.dateFrom.setMinutes(params.int('dateFromMinute'))

    routine.dateTo.setHours(params.int('dateToHour'))
    routine.dateTo.setMinutes(params.int('dateToMinute'))

    routine.save(flush: true)

    // find all routines of that day and facility
    List routines = Dayroutine.findAllByFacilityAndDay(entity, routine.day) //.sort() {it.from}

    render template: "routines", model: [routines: routines]
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

    routine.save(flush:true)
    render template: "routine", model:[routine: routine, i: params.i]
  }

  def deleteroutine = {
    Dayroutine routine = Dayroutine.get(params.id)

    routine.delete()

    render ""
  }

}
