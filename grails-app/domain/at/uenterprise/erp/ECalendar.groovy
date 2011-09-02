package at.uenterprise.erp

/**
 * This class represents the calendar settings saved for every (person) entity
 *
 * @author  Alexander Zeillinger
 */
class ECalendar {

  static hasMany = [calendareds: String]

  List    calendareds
  Boolean showThemes = true

  static constraints = {

  }

}
