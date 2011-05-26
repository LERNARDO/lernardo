package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Comment

class ProjectProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment]

    Date startDate
    Date endDate

    String description

    String educationalObjective // added on 26.05.2011
    String educationalObjectiveText // added on 26.05.2011

    static constraints = {
      fullName (blank: false, size: 1..100, maxSize: 100)
      description (blank: true, maxSize: 5000)
      educationalObjective nullable: true
      educationalObjectiveText nullable: true, maxSize: 5000
    }

    String toString(){
      return "${fullName}"
    }
}
