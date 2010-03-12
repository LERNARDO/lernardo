// for other people like "ansprechpersonen" or lernardo personal

package profiles

import de.uenterprise.ep.Profile

class UserProfile extends Profile {

    String firstName
    String lastName
    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      firstName (blank: false)
      lastName (blank: false)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
