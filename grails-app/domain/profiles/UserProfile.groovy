// for other people like "ansprechpersonen" or ue staff

package profiles

import at.openfactory.ep.Profile

class UserProfile extends Profile {

    String firstName
    String lastName
    Boolean showTips = true

    static constraints = {
      fullName (blank: true)
      firstName (blank: false, maxSize: 50)
      lastName (blank: false, maxSize: 50)
    }

    String toString(){
      return "${lastName}" + " " + "${firstName}"
    }

}
