package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Folder
import at.uenterprise.erp.CDate

/**
 * This class represents the profile of parents
 *
 * @author  Alexander Zeillinger
 */
class ParentProfile extends Profile {

  List favorites
  static hasMany = [languages: String,
                    jobtypes: String,
                    favorites: String,
                    dates: CDate]

  Folder    favoritesFolder
  ECalendar calendar
  String    firstName
  String    lastName
  Date      birthDate
  Integer   gender

  String comment

  String currentStreet

  String maritalStatus
  String education

  Boolean job
  Integer jobIncome
  String  jobFrequency
  String  incomeFrequency

  Boolean showTips = true

  Integer socialSecurityNumber
  String  phone
  String  citizenship

  static constraints = {
    firstName             blank: false, size: 2..50, maxSize: 50
    lastName              blank: false, size: 2..50, maxSize: 50
    currentStreet         size: 2..50, maxSize: 50
    jobIncome             nullable: true
    jobFrequency          nullable: true, blank: true, maxSize: 50
    education             nullable: true, blank: true
    comment               blank: true, maxSize: 2000
    incomeFrequency       nullable: true

    socialSecurityNumber  nullable: true, size: 10..10
    phone                 nullable: true
    citizenship           nullable: true
    birthDate             nullable: true
    calendar              nullable: true
    favoritesFolder nullable: true
  }

  String toString() {
    return "${lastName} ${firstName}"
  }
  
}
