package groups

import de.uenterprise.ep.Profile

class GroupNetworkProfile extends Profile {

    String description

    static constraints = {
      description (maxSize: 10000)
    }
}
