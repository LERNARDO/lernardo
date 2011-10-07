package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.CDate

import at.uenterprise.erp.Healths
import at.uenterprise.erp.Collector
import at.uenterprise.erp.Contact

import at.uenterprise.erp.Materials
import at.uenterprise.erp.Performances
import at.uenterprise.erp.ECalendar

/**
 * This class represents the profile of clients (children part of the educational program)
 *
 * @author  Alexander Zeillinger
 */
class ClientProfile extends Profile {

  SortedSet dates, materials, performances, healths
  static hasMany = [languages: String,
                    dates: CDate,
                    materials: Materials,
                    performances: Performances,
                    healths: Healths,
                    jobtypes: String,
                    collectors: Collector,
                    contacts: Contact]

  ECalendar calendar
  String    firstName
  String    lastName
  String    interests
  Date      birthDate
  Integer   gender

  String currentCountry
  String currentZip
  String currentCity // not used anymore since 03.03.2011
  String currentStreet

  String originCountry
  String originZip
  String originCity

  String school
  String schoolLevel

  Boolean schoolDropout = false
  Date    schoolDropoutDate
  String  schoolDropoutReason

  Boolean schoolRestart = false
  Date    schoolRestartDate
  String  schoolRestartReason

  Boolean job
  Integer jobIncome
  String  jobFrequency

  String familyStatus

  Boolean support = false
  String  supportDescription

  Boolean showTips = true

  // for Lernardo
  String  citizenship
  Integer socialSecurityNumber

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
    fullName              blank: true, size: 1..100, maxSize: 100
    firstName             blank: false, size: 2..50, maxSize: 50
    lastName              blank: false, size: 2..50, maxSize: 50
    currentCountry        size: 2..50, maxSize: 50
    currentZip            size: 4..10
    currentCity           nullable: true, size: 2..50, maxSize: 50
    currentStreet         size: 2..50, maxSize: 50
    originCountry         size: 2..50, maxSize: 50
    originZip             nullable: true, size: 4..10
    originCity            nullable: true, size: 2..50, maxSize: 50
    interests             blank: true, maxSize: 2000
    jobIncome             nullable: true
    jobFrequency          nullable: true, blank: true, maxSize: 50
    schoolDropoutDate     nullable: true
    schoolDropoutReason   nullable: true, blank: false, maxSize: 500
    schoolRestartDate     nullable: true
    schoolRestartReason   nullable: true, blank: false, maxSize: 500
    supportDescription    nullable: true, blank: true, maxSize: 500
    citizenship           nullable: true
    socialSecurityNumber  nullable: true, size: 10..10
    familyStatus          nullable: true
    job                   nullable: true
    school                nullable: true

    mondayFrom            nullable: true
    tuesdayFrom           nullable: true
    wednesdayFrom         nullable: true
    thursdayFrom          nullable: true
    fridayFrom            nullable: true
    saturdayFrom          nullable: true
    sundayFrom            nullable: true

    mondayTo              nullable: true
    tuesdayTo             nullable: true
    wednesdayTo           nullable: true
    thursdayTo            nullable: true
    fridayTo              nullable: true
    saturdayTo            nullable: true
    sundayTo              nullable: true
  }

  String toString() {
    return "${lastName} ${firstName}"
  }

}
