package profiles

import at.openfactory.ep.Profile

class ParentProfile extends Profile {

    static hasMany = [languages: String,
                      jobtypes: String]

    String firstName
    String lastName
    Date birthDate
    Byte gender

    String comment

    String currentCountry
    String currentZip
    String currentCity
    String currentStreet

    String maritalStatus
    String education

    Boolean job
    //String jobType
    Integer jobIncome
    String jobFrequency

    Boolean showTips = true

    // for Lernardo
    Integer socialSecurityNumber
    String phone
    String citizenship

    static constraints = {
      fullName (blank: true)
      firstName (blank: false, size: 2..50, maxSize: 50)
      lastName (blank: false, size: 2..50, maxSize: 50)
      currentCountry (nullable: true, size: 1..50)
      currentZip (size: 4..10)
      currentCity (size: 2..50, maxSize: 50)
      currentStreet (size: 2..50, maxSize: 50)
      //jobType (nullable: true)
      jobIncome (nullable: true)
      jobFrequency (nullable: true, blank: true, maxSize: 20)
      education (nullable: true, blank: true)
      comment (blank: true, maxSize: 2000)

      socialSecurityNumber (nullable: true, size: 10..10)
      phone (nullable: true)
      citizenship (nullable: true)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }
  
}
