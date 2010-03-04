package groups

import de.uenterprise.ep.Profile

class GroupColonyProfile extends Profile{

    String generalInformation
    String facilities

    static constraints = {
      generalInformation (maxSize: 10000)
      facilities (maxSize: 10000, blank: true)
    }
}
