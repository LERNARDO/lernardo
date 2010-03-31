package groups

import de.uenterprise.ep.Profile

class GroupActivityTemplateProfile extends Profile {

    String description

    Date dateCreated
    Date lastUpdated

    static constraints = {
      fullName (blank: false)
      description (blank: false, maxSize: 5000)
    }
}
