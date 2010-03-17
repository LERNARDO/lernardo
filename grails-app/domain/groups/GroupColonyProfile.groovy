package groups

import de.uenterprise.ep.Profile

class GroupColonyProfile extends Profile{

    String generalInformation
    String otherFacilities

    static constraints = {
      generalInformation (maxSize: 10000)
      otherFacilities (maxSize: 10000, blank: true)
    }
}
