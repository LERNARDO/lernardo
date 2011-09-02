package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Label

/**
 * This class represents the profile of projects
 *
 * @author  Alexander Zeillinger
 */
class ProjectProfile extends Profile {

  SortedSet comments
  static hasMany = [comments: Comment,
                    labels: Label]

  Date    startDate
  Date    endDate
  String  description
  String  educationalObjective
  String  educationalObjectiveText

  static constraints = {
    fullName                  blank: false, size: 1..100, maxSize: 100
    description               blank: true, maxSize: 20000
    educationalObjective      nullable: true
    educationalObjectiveText  nullable: true, maxSize: 2000
  }

  String toString() {
    return "${fullName}"
  }

}
