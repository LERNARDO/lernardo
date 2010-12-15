package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.CDate
import at.uenterprise.erp.WorkdayUnit

class EducatorProfile extends Profile {

    SortedSet dates, workdayunits
    static hasMany = [languages: String,
                      inChargeOf: String,
                      dates: CDate,
                      workdayunits: WorkdayUnit]

    String title
    String firstName
    String lastName
    Date birthDate
    Byte gender

    String currentCountry
    String currentZip
    String currentCity
    String currentStreet

    String originCountry
    String originZip
    String originCity
    String originStreet

    String contactName // added on 27.09.2010
    String contactCountry
    String contactZip
    String contactCity
    String contactStreet
    String contactPhone
    String contactMail

    String education
    String interests

    String employment

    // added for NOE
    String phone1
    String phone2
    String privEmail

    Integer workHours
    Integer hourlyWage
    Integer overtimePay

    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      title (blank: true, maxSize: 50)
      firstName (blank: false, size: 2..50, maxSize: 50)
      lastName (blank: false, size: 2..50, maxSize: 50)
      education (blank: true)
      interests (blank: true, maxSize: 2000)

      currentCountry (size: 1..50, maxSize: 50)
      currentZip (size: 4..10)
      currentCity (size: 2..50, maxSize: 50)
      currentStreet (size: 2..50, maxSize: 50)

      originCountry (nullable: true, size: 1..50)
      originZip (nullable: true, size: 4..10)
      originCity (nullable: true, size: 2..50, maxSize: 50)
      originStreet (nullable: true, size: 2..50, maxSize: 50)

      contactName (nullable: true, size: 2..50, maxSize: 50)
      contactCountry (nullable: true, size: 2..50, maxSize: 50)
      contactZip (nullable: true, size: 4..10)
      contactCity (nullable: true, size: 2..50, maxSize: 50)
      contactStreet (nullable: true, size: 2..50, maxSize: 50)
      contactPhone (nullable: true, size: 2..50, maxSize: 50)
      contactMail (nullable: true, size: 2..50, maxSize: 50)

      phone1 (nullable: true)
      phone2 (nullable: true)
      privEmail (email:true, nullable:true)

      workHours nullable: true
      hourlyWage nullable: true
      overtimePay nullable: true
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
