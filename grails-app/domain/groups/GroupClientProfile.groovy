package groups

import at.openfactory.ep.Profile

/*
 * used for grouping clients together by creating a link from the group to each client
 */

class GroupClientProfile extends Profile {

    String description

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      description (blank: true, maxSize: 5000)
    }

    String toString(){
      return "${fullName}"
    }
  
}
