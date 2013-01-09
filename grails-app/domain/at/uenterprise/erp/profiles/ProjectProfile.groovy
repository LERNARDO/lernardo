package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Label

/**
 * This class represents the profile of projects
 *
 * @author Alexander Zeillinger
 */
class ProjectProfile extends Profile {

    SortedSet comments
    static hasMany = [comments: Comment,
            labels: Label]

    Date startDate
    Date endDate
    String description
    //String educationalObjective
    String educationalObjectiveText

    Boolean completed = false
    Boolean objectiveReached = false
    String objectiveComment

    String goodFactors
    String badFactors

    Boolean wouldRepeatIt = false
    String repeatReason

    String status

    static constraints = {
        description blank: true, maxSize: 20000
        //educationalObjective nullable: true
        educationalObjectiveText nullable: true, maxSize: 2000

        objectiveComment nullable: true, maxSize: 2000
        goodFactors nullable: true, maxSize: 2000
        badFactors nullable: true, maxSize: 2000
        repeatReason nullable: true, maxSize: 2000

        status nullable: true
    }

    String toString() {
        return "${fullName}"
    }

}
