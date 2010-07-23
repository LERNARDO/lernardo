package groups

import at.openfactory.ep.Profile
import lernardo.Contact
import lernardo.Building

/*
 * used for grouping planable resources, facilities, partners and educators together by creating a link from the group to each member
 */

class GroupColonyProfile extends Profile{

    static hasMany = [representatives: Contact,
                      buildings: Building]

    String description // added on 21.04.2010
    //String generalInformation - removed on 21.04.2010
    //String otherFacilities - removed on 21.04.2010
  
    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      description (blank: true, maxSize: 2000)
    }

    String toString(){
      return "${fullName}"
    }

}
