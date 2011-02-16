package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Contact
import at.uenterprise.erp.ECalendar

class PartnerProfile extends Profile {

    static hasMany = [contacts: Contact,
                      services: String]

    ECalendar calendar
    String description
    String country
    String zip
    String city
    String street
    String phone
    String website

    Boolean showTips = true

    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 5000)
      zip (size: 4..10)
      city (size: 2..50, maxSize: 50)
      street (size: 2..50, maxSize: 50)
      phone (size: 2..20)
      website (blank: true, size: 2..50)
    }

    String toString(){
      return "${fullName}"
    }

}
