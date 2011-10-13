package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity
import at.uenterprise.erp.MetaDataService

class LogBookController {
  MetaDataService metaDataService

  def entries = { }

  def evaluation = { }

  def processes = { }

  def settings = {
    List facilities = Entity.findAllByType(metaDataService.etFacility)
    return [facilities: facilities]
  }

  def showAttendances = {
    Entity facility = Entity.get(params.facility)

    // find all attendances of this facility
    List attendances = Attendance.findAllByFacility(facility)

    render template: 'attendances', model: [attendances: attendances]
  }

  def editAttendance = {
    Attendance attendance = Attendance.get(params.id)

    render template: 'editAttendance', model: [attendance: attendance, i: params.i]
  }

  def updateAttendance = {
    Attendance attendance = Attendance.get(params.id)

    //attendance.properties = params

    attendance.costs = params.costs.toInteger()

    attendance.monday = params.monday ? true : false
    attendance.tuesday = params.tuesday ? true : false
    attendance.wednesday = params.wednesday ? true : false
    attendance.thursday = params.thursday ? true : false
    attendance.friday = params.friday ? true : false
    attendance.saturday = params.saturday ? true : false
    attendance.sunday = params.sunday ? true : false

    attendance.mondayFrom = params.mondayFrom ? Date.parse("HH:mm", params.mondayFrom) : null
    attendance.tuesdayFrom = params.tuesdayFrom ? Date.parse("HH:mm", params.tuesdayFrom) : null
    attendance.wednesdayFrom = params.wednesdayFrom ? Date.parse("HH:mm", params.wednesdayFrom) : null
    attendance.thursdayFrom = params.thursdayFrom ? Date.parse("HH:mm", params.thursdayFrom) : null
    attendance.fridayFrom = params.fridayFrom ? Date.parse("HH:mm", params.fridayFrom) : null
    attendance.saturdayFrom = params.saturdayFrom ? Date.parse("HH:mm", params.saturdayFrom) : null
    attendance.sundayFrom = params.sundayFrom ? Date.parse("HH:mm", params.sundayFrom) : null

    attendance.mondayTo = params.mondayTo ? Date.parse("HH:mm", params.mondayTo) : null
    attendance.tuesdayTo = params.tuesdayTo ? Date.parse("HH:mm", params.tuesdayTo) : null
    attendance.wednesdayTo = params.wednesdayTo ? Date.parse("HH:mm", params.wednesdayTo) : null
    attendance.thursdayTo = params.thursdayTo ? Date.parse("HH:mm", params.thursdayTo) : null
    attendance.fridayTo = params.fridayTo ? Date.parse("HH:mm", params.fridayTo) : null
    attendance.saturdayTo = params.saturdayTo ? Date.parse("HH:mm", params.saturdayTo) : null
    attendance.sundayTo = params.sundayTo ? Date.parse("HH:mm", params.sundayTo) : null

    attendance.save()

    render template: 'showAttendance', model: [attendance: attendance, i: params.i]
  }
}
