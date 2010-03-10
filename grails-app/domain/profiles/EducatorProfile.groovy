package profiles

import de.uenterprise.ep.Profile

class EducatorProfile extends Profile {

    String title
    String firstName
    String lastName
    Date birthDate
    Integer gender
    Integer PLZ
    String city
    String street
    String nationality
    String contact
    String languages
    String education
    String interests
    Date joinDate
    Date quitDate
    String function
    Boolean employed // non-employed are voluntary educators
    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      firstName (blank: false)
      lastName (blank: false)
      PLZ (nullable: true)
      quitDate (nullable: true)
      education (blank: true, maxSize: 10000)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
