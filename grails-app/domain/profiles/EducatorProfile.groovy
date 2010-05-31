package profiles

import de.uenterprise.ep.Profile
import lernardo.CDate

class EducatorProfile extends Profile {

    static hasMany = [languages: String, // changed on 20.04.2010, before: string languages
                      inChargeOf: String, // changed on 20.04.2010, before: function
                      dates: CDate] // added on 20.04.2010

    String title
    String firstName
    String lastName
    Date birthDate
    Byte gender

    String currentCountry // added on 20.04.2010
    String currentZip // changed on 20.04.2010, before: PLZ
    String currentCity // changed on 20.04.2010, before: city
    String currentStreet // changed on 20.04.2010, before: street

    //String nationality - removed on 20.04.2010

    String originCountry // added on 20.04.2010
    String originZip // added on 20.04.2010
    String originCity // added on 20.04.2010
    String originStreet // added on 20.04.2010

    String contactCountry // added on 20.04.2010
    String contactZip // added on 20.04.2010
    String contactCity // added on 20.04.2010
    String contactStreet // added on 20.04.2010
    String contactPhone // added on 20.04.2010
    String contactMail // added on 20.04.2010
    // String contact - removed on 20.04.2010

    String education
    String interests

    //Date joinDate - removed on 20.04.2010
    //Date quitDate - removed on 20.04.2010
  
    String employment // changed on 20.04.2010, before: Boolean employed

    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      title (blank: true, maxSize: 50)
      firstName (blank: false, size: 2..50)
      lastName (blank: false, size: 2..50)
      education (blank: true, maxSize: 10000)
      interests (blank: true, maxSize: 1000)
      currentCountry (size: 2..50)
      currentZip (size: 4..10)
      currentCity (size: 2..50)
      currentStreet (size: 2..50)
      originCountry (size: 2..50)
      originZip (size: 4..10)
      originCity (size: 2..50)
      originStreet (size: 2..50)
      contactCountry (size: 2..50)
      contactZip (size: 4..10)
      contactCity (size: 2..50)
      contactStreet (size: 2..50)
      contactPhone (size: 2..50)
      contactMail (size: 2..50)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
