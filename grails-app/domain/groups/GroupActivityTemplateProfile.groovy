package groups

import at.openfactory.ep.Profile
import lernardo.Comment

class GroupActivityTemplateProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

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
