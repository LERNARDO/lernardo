// for other people like "ansprechpersonen" or ue staff

package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ECalendar

class UserProfile extends Profile {

    ECalendar calendar
    String firstName
    String lastName
    Boolean showTips = true

    static constraints = {
      fullName (blank: true, size: 1..100, maxSize: 100)
      firstName (blank: false, maxSize: 50)
      lastName (blank: false, maxSize: 50)
    }

    String toString(){
      return "${lastName} ${firstName}"
    }

}
