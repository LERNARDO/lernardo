package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Contact
import at.uenterprise.erp.Building

/*
 * used for grouping planable resources, facilities, partners and educators together by creating a link from the group to each member
 */

class GroupColonyProfile extends Profile{

    static hasMany = [representatives: Contact,
                      buildings: Building]

    String description
  
    static constraints = {
      fullName (blank: false, size: 1..100, maxSize: 100)
      description (blank: true, maxSize: 5000)
    }

    String toString(){
      return "${fullName}"
    }

}
