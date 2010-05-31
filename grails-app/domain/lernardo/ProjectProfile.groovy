package lernardo

import at.openfactory.ep.Profile

class ProjectProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

    Date startDate
    Date endDate

    static constraints = {
      fullName (blank: false)
    }

    String toString(){
      return "${fullName}"
    }
}
