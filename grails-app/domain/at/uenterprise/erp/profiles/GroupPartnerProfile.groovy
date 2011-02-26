package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile

/*
 * used for grouping partners together by creating a link from the group to each partner
 */

class GroupPartnerProfile extends Profile {

    String description
    String service

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      description (blank: true, maxSize: 5000)
    }

    String toString(){
      return "${fullName}"
    }
  
}
