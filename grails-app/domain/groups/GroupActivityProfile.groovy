package groups

import at.openfactory.ep.Profile
import lernardo.Comment

class  GroupActivityProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

    Integer realDuration
    Date date
    String educationalObjective
    String educationalObjectiveText

    static constraints = {
      fullName (blank: false, size: 2..50)
      educationalObjectiveText (blank: true, maxSize: 2000)
    }
}
