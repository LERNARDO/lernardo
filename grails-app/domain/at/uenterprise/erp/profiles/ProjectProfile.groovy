package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Comment

class ProjectProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

    Date startDate
    Date endDate

    static constraints = {
      fullName (blank: false, maxSize: 50)
    }

    String toString(){
      return "${fullName}"
    }
}
