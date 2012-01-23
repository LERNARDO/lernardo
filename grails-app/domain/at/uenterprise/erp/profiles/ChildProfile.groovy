package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ECalendar

/**
 * This class represents the profile of children
 *
 * @author  Alexander Zeillinger
 */
class ChildProfile extends Profile {

  List favorites
  static hasMany = [jobtypes: String,
                    favorites: String]

  ECalendar calendar
  String    firstName
  String    lastName
  String    jobFrequency
  Date      birthDate
  Integer   jobIncome
  Byte      gender
  Boolean   job
  Boolean   showTips = true

  static constraints = {
    fullName      blank: true, size: 1..100, maxSize: 100
    firstName     blank: false, size: 2..50, maxSize: 50
    lastName      blank: false, size: 2..50, maxSize: 50
    jobIncome     nullable: true
    jobFrequency  nullable: true, blank: true, maxSize: 50
    calendar      nullable: true
  }

  String toString() {
    return "${lastName} ${firstName}"
  }

}
