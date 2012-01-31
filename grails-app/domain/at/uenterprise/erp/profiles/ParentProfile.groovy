package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ECalendar

/**
 * This class represents the profile of parents
 *
 * @author  Alexander Zeillinger
 */
class ParentProfile extends Profile {

  List favorites
  static hasMany = [languages: String,
                    jobtypes: String,
                    favorites: String]

  ECalendar calendar
  String    firstName
  String    lastName
  Date      birthDate
  Byte      gender

  String comment

  //String currentCountry
  //String currentZip
  //String currentCity
  String currentStreet

  String maritalStatus
  String education

  Boolean job
  Integer jobIncome
  String  jobFrequency

  Boolean showTips = true

  // for Lernardo
  Integer socialSecurityNumber
  String  phone
  String  citizenship

  static constraints = {
    fullName              blank: true, size: 1..100, maxSize: 100
    firstName             blank: false, size: 2..50, maxSize: 50
    lastName              blank: false, size: 2..50, maxSize: 50
    //currentCountry        nullable: true, size: 1..50
    //currentZip            size: 4..10
    //currentCity           size: 2..50, maxSize: 50
    currentStreet         size: 2..50, maxSize: 50
    jobIncome             nullable: true
    jobFrequency          nullable: true, blank: true, maxSize: 50
    education             nullable: true, blank: true
    comment               blank: true, maxSize: 2000

    socialSecurityNumber  nullable: true, size: 10..10
    phone                 nullable: true
    citizenship           nullable: true
    birthDate             nullable: true
    calendar              nullable: true
  }

  String toString() {
    return "${lastName} ${firstName}"
  }
  
}
