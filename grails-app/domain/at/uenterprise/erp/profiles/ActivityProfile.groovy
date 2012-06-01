package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.ClientEvaluation
import at.uenterprise.erp.Comment

/**
 * This class represents the profile of activities
 *
 * @author  Alexander Zeillinger
 */
class ActivityProfile extends Profile {

  SortedSet comments
  static hasMany = [clientEvaluations: ClientEvaluation,
                    comments: Comment]

  Integer duration
  String  type
  Date    date
  Date    dateCreated
  Date    lastUpdated

  static constraints = {
    fullName blank: false, size: 1..100, maxSize: 100
  }

  String toString() {
    return "${fullName}"
  }

}
