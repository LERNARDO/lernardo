package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.WorkdayUnit

/**
 * This class represents the profile of users
 *
 * @author  Alexander Zeillinger
 */
class UserProfile extends Profile {

  SortedSet workdayunits
  List favorites
  static hasMany = [favorites: String,
                    workdayunits: WorkdayUnit]

  ECalendar calendar
  String    firstName
  String    lastName
  Boolean   showTips = true

  BigDecimal workHoursMonday = 0
  BigDecimal workHoursTuesday = 0
  BigDecimal workHoursWednesday = 0
  BigDecimal workHoursThursday = 0
  BigDecimal workHoursFriday = 0
  BigDecimal workHoursSaturday = 0
  BigDecimal workHoursSunday = 0

  Integer hourlyWage = 0
  Integer overtimePay = 0

  static constraints = {
    fullName  blank: true, size: 1..100, maxSize: 100
    firstName blank: false, maxSize: 50
    lastName  blank: false, maxSize: 50
    calendar  nullable: true
    hourlyWage      nullable: true
    overtimePay     nullable: true
  }

  String toString() {
    return "${lastName} ${firstName}"
  }

}
