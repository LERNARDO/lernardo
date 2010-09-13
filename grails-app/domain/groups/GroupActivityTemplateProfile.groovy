package groups

import at.openfactory.ep.Profile
import lernardo.Comment

/*
 * used for grouping activity templates together by creating a link from the group to each activity template
 */

class GroupActivityTemplateProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

    String description
    String status
    Integer realDuration

    Date dateCreated
    Date lastUpdated

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      description (blank: true, maxSize: 2000)
    }

    String toString(){
      return "${fullName}"
    }
}
