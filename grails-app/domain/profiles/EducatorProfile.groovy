package profiles

import at.openfactory.ep.Profile
import lernardo.CDate

class EducatorProfile extends Profile {

    SortedSet dates
    static hasMany = [languages: String,
                      inChargeOf: String,
                      dates: CDate]

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

    String contactCountry
    String contactZip
    String contactCity
    String contactStreet
    String contactPhone
    String contactMail

    String education
    String interests

    String employment

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
      originCountry (size: 1..50)
      originZip (size: 4..10)
      originCity (size: 2..50, maxSize: 50)
      originStreet (size: 2..50, maxSize: 50)
      contactCountry (size: 2..50, maxSize: 50)
      contactZip (size: 4..10)
      contactCity (size: 2..50, maxSize: 50)
      contactStreet (size: 2..50, maxSize: 50)
      contactPhone (size: 2..50, maxSize: 50)
      contactMail (size: 2..50, maxSize: 50)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
