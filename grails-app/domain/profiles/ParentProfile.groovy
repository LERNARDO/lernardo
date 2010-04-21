package profiles

import de.uenterprise.ep.Profile

class ParentProfile extends Profile {

    String firstName
    String lastName
    String[] languages // changed on 20.04.2010, before: string languages
    Date birthDate
    Byte gender

    String currentCountry // added on 20.04.2010
    String currentZip // changed on 20.04.2010, before: PLZ
    String currentCity // changed on 20.04.2010, before: city
    String currentStreet // changed on 20.04.2010, before: street

    //String nationality - removed on 20.04.2010
    String maritalStatus // changed on 20.04.2010, before: familyStatus
    String education // changed on 20.04.2010, before: qualification

    Boolean job // changed on 20.04.2010, before: doesWork
    String jobType // changed on 20.04.2010, before: work
    Integer jobIncome // changed on 20.04.2010, before: income
    String jobFrequency // added on 20.04.2010

    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      firstName (blank: false, size: 2..50)
      lastName (blank: false, size: 2..50)
      currentCountry (size: 2..50)
      currentZip (size: 4..10)
      currentCity (size: 2..50)
      currentStreet (size: 2..50)
      jobType (nullable: true)
      jobIncome (nullable: true)
      jobFrequency (nullable: true, blank: true, maxSize: 20)
      education (blank: true)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }
  
}
