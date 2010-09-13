package profiles

import at.openfactory.ep.Profile
import lernardo.CDate
import lernardo.Performances
import lernardo.Materials
import lernardo.Healths

class ClientProfile extends Profile {

    SortedSet dates, materials, performances, healths
    static hasMany = [languages: String,
                      dates: CDate,
                      materials: Materials,
                      performances: Performances,
                      healths: Healths]

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
    String jobType
    Integer jobIncome
    String jobFrequency

    String familyStatus

    Boolean support = false
    String supportDescription

    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      firstName (blank: false, size: 2..50, maxSize: 50)
      lastName (blank: false, size: 2..50, maxSize: 50)
      currentCountry (size: 2..50, maxSize: 50)
      currentZip (size: 4..10)
      currentCity (size: 2..50, maxSize: 50)
      currentStreet (size: 2..50, maxSize: 50)
      originCountry (size: 2..50, maxSize: 50)
      originZip (size: 4..10)
      originCity (size: 2..50, maxSize: 50)
      interests (blank: true, maxSize: 2000)
      jobType (nullable: true)
      jobIncome (nullable: true)
      jobFrequency (nullable: true, blank: true, maxSize: 50)
      schoolDropoutDate (nullable: true)
      schoolDropoutReason (nullable: true, blank: false, maxSize: 500)
      schoolRestartDate (nullable: true)
      schoolRestartReason (nullable: true, blank: false, maxSize: 500)
      supportDescription (nullable: true, blank: true, maxSize: 500)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
