package groups

import de.uenterprise.ep.Profile

class GroupPartnerProfile extends Profile {

    String description
    String service

    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 500)
    }
  
}
