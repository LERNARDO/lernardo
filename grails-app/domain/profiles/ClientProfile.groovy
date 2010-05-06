package profiles

import de.uenterprise.ep.Profile
import lernardo.CDate
import lernardo.Status

class ClientProfile extends Profile {

    static hasMany = [languages: String, // changed on 20.04.2010, before: string languages
                      dates: CDate, // added on 20.04.2010
                      status: Status] // added on 20.04.2010

    String firstName
    String lastName
    String interests
    Date birthDate
    Byte gender
    Byte size // added on 20.04.2010
    Byte weight // added on 20.04.2010

    String currentCountry // changed on 20.04.2010, before: country
    String currentZip // changed on 20.04.2010, before: PLZ
    String currentCity // changed on 20.04.2010, before: city
    String currentStreet // changed on 20.04.2010, before: street

    String originCountry // changed on 20.04.2010, before: country2
    String originZip // changed on 20.04.2010, before: PLZ2
    String originCity // changed on 20.04.2010, before: city2
    //String street2 - removed on 20.04.2010
    //String nationality - removed on 20.04.2010
    //String personalDetails - removed on 20.04.2010
    //String attendance - removed on 20.04.2010

    //String school - removed on 20.04.2010
    Integer schoolLevel

    Boolean schoolDropout = false // changed on 20.04.2010, before: dropout
    Date schoolDropoutDate // added on 20.04.2010
    String schoolDropoutReason // changed on 20.04.2010, before: dropoutReason

    Boolean schoolRestart = false // added on 20.04.2010
    Date schoolRestartDate // added on 20.04.2010
    String schoolRestartReason // added on 20.04.2010
 
    //Date joinDate - removed on 20.04.2010
    //Date endDate - removed on 20.04.2010
    //Date joinDate2 - removed on 20.04.2010
    //Date endDate2 - removed on 20.04.2010
    Boolean job // changed on 20.04.2010, before: doesWork
    String jobType // changed on 20.04.2010, before: work
    Integer jobIncome // changed on 20.04.2010, before: income
    String jobFrequency // added on 20.04.2010

    String familyStatus // added on 20.04.2010

    Boolean support = false // added on 20.04.2010
    String supportDescription // added on 20.04.2010

    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      firstName (blank: false, size: 2..50)
      lastName (blank: false, size: 2..50)
      currentCountry (size: 2..50)
      currentZip (size: 4..10)
      currentCity (size: 2..50)
      currentStreet (size: 2..50)
      originCountry (size: 2..50)
      originZip (size: 4..10)
      originCity (size: 2..50)
      interests (blank: true, maxSize: 1000)
      jobType (nullable: true)
      jobIncome (nullable: true)
      jobFrequency (nullable: true, blank: true, maxSize: 20)
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
