package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.CDate

import at.uenterprise.erp.Healths
import at.uenterprise.erp.Collector
import at.uenterprise.erp.Contact

import at.uenterprise.erp.Materials
import at.uenterprise.erp.Performances
import at.uenterprise.erp.ECalendar

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
    String firstName
    String lastName
    String interests
    Date birthDate
    Integer gender
    Integer size
    Integer weight

    String currentCountry
    String currentZip
    String currentCity
    String currentStreet

    String originCountry
    String originZip
    String originCity

    String schoolLevel

    Boolean schoolDropout = false
    Date schoolDropoutDate
    String schoolDropoutReason

    Boolean schoolRestart = false
    Date schoolRestartDate
    String schoolRestartReason

    Boolean job
    //String jobType
    Integer jobIncome
    String jobFrequency

    String familyStatus

    Boolean support = false
    String supportDescription

    Boolean showTips = true

    // for Lernardo
    String citizenship
    Integer socialSecurityNumber

    //String contactName // added on 27.09.2010 - removed on 15.11.2010
    //String contactCountry // added on 27.09.2010 - removed on 15.11.2010
    //String contactZip // added on 27.09.2010 - removed on 15.11.2010
    //String contactCity // added on 27.09.2010 - removed on 15.11.2010
    //String contactStreet // added on 27.09.2010 - removed on 15.11.2010
    //String contactPhone // added on 27.09.2010 - removed on 15.11.2010
    //String contactMail // added on 27.09.2010 - removed on 15.11.2010

    static constraints = {
      fullName (blank: true)
      firstName (blank: false, size: 2..50, maxSize: 50)
      lastName (blank: false, size: 2..50, maxSize: 50)
      currentCountry (size: 2..50, maxSize: 50)
      currentZip (size: 4..10)
      currentCity (size: 2..50, maxSize: 50)
      currentStreet (size: 2..50, maxSize: 50)
      originCountry (size: 2..50, maxSize: 50)
      originZip (size: 4..10, nullable: true)
      originCity (size: 2..50, maxSize: 50, nullable: true)
      interests (blank: true, maxSize: 2000)
      //jobType (nullable: true)
      jobIncome (nullable: true)
      jobFrequency (nullable: true, blank: true, maxSize: 50)
      schoolDropoutDate (nullable: true)
      schoolDropoutReason (nullable: true, blank: false, maxSize: 500)
      schoolRestartDate (nullable: true)
      schoolRestartReason (nullable: true, blank: false, maxSize: 500)
      supportDescription (nullable: true, blank: true, maxSize: 500)

      citizenship (nullable: true)
      socialSecurityNumber (nullable: true, size: 10..10)
      //contactName (nullable: true, size: 2..50, maxSize: 50)
      //contactCountry (nullable: true, size: 2..50, maxSize: 50)
      //contactZip (nullable: true, size: 4..10)
      //contactCity (nullable: true, size: 2..50, maxSize: 50)
      //contactStreet (nullable: true, size: 2..50, maxSize: 50)
      //contactPhone (nullable: true, size: 2..50, maxSize: 50)
      //contactMail (nullable: true, size: 2..50, maxSize: 50)

      size (nullable: true)
      weight (nullable: true)

      familyStatus (nullable: true)

      job (nullable: true)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
