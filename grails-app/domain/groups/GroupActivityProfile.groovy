package groups

import at.openfactory.ep.Profile
import lernardo.Comment

/*
 * used for grouping activities together by creating a link from the group to each activity
 */

class GroupActivityProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

    Integer realDuration
    Date date
    String educationalObjective
    String educationalObjectiveText

    static constraints = {
      fullName (blank: false, size: 2..50, maxSize: 50)
      educationalObjectiveText (blank: true, maxSize: 2000)
    }

}
