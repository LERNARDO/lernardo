package at.uenterprise.erp

/**
 * This class represents the calendar settings saved for every (person) entity
 *
 * @author  Alexander Zeillinger
 */
class ECalendar {

  static hasMany = [entities: CalEntity]
  Boolean showThemes = true

  static constraints = {

  }

}
