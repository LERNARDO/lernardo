package groups

import at.openfactory.ep.Profile

class GroupNetworkProfile extends Profile {

    String description

    static constraints = {
      description (maxSize: 2000)
    }
}
