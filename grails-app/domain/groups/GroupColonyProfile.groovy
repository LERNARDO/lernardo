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

    String description
  
    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      description (blank: true, maxSize: 5000)
    }

    String toString(){
      return "${fullName}"
    }

}
