package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Comment

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

    String description

    static constraints = {
      fullName (blank: false, size: 1..100, maxSize: 100)
      educationalObjectiveText (blank: true, maxSize: 2000)
      description (blank: true, maxSize: 5000)
    }

    String toString(){
      return "${fullName}"
    }

}
