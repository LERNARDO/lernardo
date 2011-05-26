package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Comment

class ProjectProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

    Date startDate
    Date endDate

    String description

    static constraints = {
      fullName (blank: false, size: 1..100, maxSize: 100)
      description (blank: true, maxSize: 5000)
    }

    String toString(){
      return "${fullName}"
    }
}
