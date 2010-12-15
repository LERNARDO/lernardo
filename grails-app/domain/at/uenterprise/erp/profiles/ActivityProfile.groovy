package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.ClientEvaluation
import at.uenterprise.erp.Comment

class ActivityProfile extends Profile {

  SortedSet comments
  static hasMany = [clientEvaluations: ClientEvaluation,
                    comments: Comment]

  Date date
  Integer duration
  String type

  Date dateCreated
  Date lastUpdated

  static constraints = {
    fullName (blank: false, size: 1..50, maxSize: 50)
  }

  String toString(){
      return "${fullName}"
    }
}
