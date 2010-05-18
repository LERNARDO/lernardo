package groups

import de.uenterprise.ep.Profile

class GroupClientProfile extends Profile {

    String description

    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 500)
    }

    String toString(){
      return "${fullName}"
    }
  
}
