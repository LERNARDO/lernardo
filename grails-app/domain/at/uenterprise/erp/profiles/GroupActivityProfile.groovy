package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Label

/**
 * This class represents a group of activities
 *
 * @author  Alexander Zeillinger
 */
class GroupActivityProfile extends Profile {

  SortedSet comments
  static hasMany = [comments: Comment,
                    labels: Label]

  Integer realDuration
  Date    date
  String  educationalObjective
  String  educationalObjectiveText
  String  description

  static constraints = {
    educationalObjectiveText  blank: true, maxSize: 2000
    description               blank: true, maxSize: 20000
  }

  String toString() {
    return "${fullName}"
  }

}
