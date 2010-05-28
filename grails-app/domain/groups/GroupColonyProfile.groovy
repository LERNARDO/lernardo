package groups

import de.uenterprise.ep.Profile
import lernardo.Contact
import lernardo.Building

class GroupColonyProfile extends Profile{

    static hasMany = [representatives: Contact,
                      buildings: Building]

    String description // added on 21.04.2010
    //String generalInformation - removed on 21.04.2010
    //String otherFacilities - removed on 21.04.2010
  
    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 500)
    }

    String toString(){
      return "${fullName}"
    }

}
