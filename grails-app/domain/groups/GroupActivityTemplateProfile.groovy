package groups

import de.uenterprise.ep.Profile

class GroupActivityTemplateProfile extends Profile {

    String description
    String status // added on 30.04.2010
    Integer realDuration // added on 30.04.2010

    Date dateCreated
    Date lastUpdated

    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 2000)
    }

    String toString(){
      return "${fullName}"
    }
}
