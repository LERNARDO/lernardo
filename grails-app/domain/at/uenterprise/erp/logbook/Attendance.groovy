package at.uenterprise.erp.logbook

import at.uenterprise.erp.base.Entity

/**
 * This class represents the attendances of clients at a facility
 *
 * @author  Alexander Zeillinger
 */
class Attendance {

  Entity  client
  Entity  facility

  Boolean monday = false
  Boolean tuesday = false
  Boolean wednesday = false
  Boolean thursday = false
  Boolean friday = false
  Boolean saturday = false
  Boolean sunday = false

  Date mondayFrom
  Date tuesdayFrom
  Date wednesdayFrom
  Date thursdayFrom
  Date fridayFrom
  Date saturdayFrom
  Date sundayFrom

  Date mondayTo
  Date tuesdayTo
  Date wednesdayTo
  Date thursdayTo
  Date fridayTo
  Date saturdayTo
  Date sundayTo

  static constraints = {
    mondayFrom    nullable: true
    tuesdayFrom   nullable: true
    wednesdayFrom nullable: true
    thursdayFrom  nullable: true
    fridayFrom    nullable: true
    saturdayFrom  nullable: true
    sundayFrom    nullable: true

    mondayTo      nullable: true
    tuesdayTo     nullable: true
    wednesdayTo   nullable: true
    thursdayTo    nullable: true
    fridayTo      nullable: true
    saturdayTo    nullable: true
    sundayTo      nullable: true
  }

}
