package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.CDate

import at.uenterprise.erp.Healths
import at.uenterprise.erp.Collector
import at.uenterprise.erp.Contact

import at.uenterprise.erp.Materials
import at.uenterprise.erp.Performances
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.SDate
import at.uenterprise.erp.Folder

/**
 * This class represents the profile of clients (children part of the educational program)
 *
 * @author  Alexander Zeillinger
 */
class ClientProfile extends Profile {
    def grailsApplication

  SortedSet dates, materials, performances, healths
  List favorites
  static hasMany = [languages: String,
                    schooldates: SDate,
                    dates: CDate,
                    materials: Materials,
                    performances: Performances,
                    healths: Healths,
                    jobtypes: String,
                    collectors: Collector,
                    contacts: Contact,
                    favorites: String]

  Folder    favoritesFolder
  ECalendar calendar
  String    firstName
  String    lastName
  String    interests
  Date      birthDate
  Integer   gender

  String currentStreet

  String originCountry
  String originZip
  String originCity

  String school
  String schoolLevel

  Boolean job
  Integer jobIncome
  String  jobFrequency

  String familyStatus

  Boolean support = false
  String  supportDescription

  Boolean showTips = true

  String  citizenship
  Integer socialSecurityNumber

  static constraints = {
    firstName             blank: false, size: 2..50, maxSize: 50
    lastName              blank: false, size: 2..50, maxSize: 50
    currentStreet         size: 2..50, maxSize: 50
    originCountry         size: 2..50, maxSize: 50
    originZip             nullable: true, size: 4..10
    originCity            nullable: true, size: 2..50, maxSize: 50
    interests             blank: true, maxSize: 2000
    jobIncome             nullable: true
    jobFrequency          nullable: true, blank: true, maxSize: 50
    supportDescription    nullable: true, blank: true, maxSize: 500
    citizenship           nullable: true
    socialSecurityNumber  nullable: true, size: 10..10
    familyStatus          nullable: true
    job                   nullable: true
    school                nullable: true
    calendar              nullable: true
    favoritesFolder nullable: true
  }

  String toString() {
      if (grailsApplication.config.customer == "sueninos")
          return "${firstName} ${lastName}"
      else
          return "${lastName} ${firstName}"
  }

}
