package groups

import at.openfactory.ep.Profile

class GroupPartnerProfile extends Profile {

    String description
    String service

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      description (blank: true, maxSize: 2000)
    }
  
}
