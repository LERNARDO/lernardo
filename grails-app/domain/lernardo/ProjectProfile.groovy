package lernardo

import de.uenterprise.ep.Profile

class ProjectProfile extends Profile {

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
