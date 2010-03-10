package profiles

import de.uenterprise.ep.Profile

class ClientProfile extends Profile {

    String firstName
    String lastName
    Date birthDate
    String country
    Integer PLZ
    String city
    String street
    String country2 // used for additional address
    Integer PLZ2
    String city2
    String street2
    String nationality
    String languages
    Integer schoolLevel
    Boolean dropout
    String dropoutReason
    String notes
    String interests
    String personalDetails
    Date joinDate
    Date endDate
    Date rejoinDate
    Date endDate2
    Date rejoinDate2
    String attendance
    Boolean doesWork
    String work
    Integer gender
    Integer income
    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      firstName (blank: false)
      lastName (blank: false)
      PLZ (nullable: true)
      PLZ (nullable: true)
      endDate (nullable: true)
      rejoinDate (nullable: true)
      endDate2 (nullable: true)
      rejoinDate2 (nullable: true)
      notes (blank: true, maxSize: 2000)
      interests (blank: true, maxSize: 2000)
      personalDetails (blank: true, maxSize: 2000)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
