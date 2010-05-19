package lernardo

import de.uenterprise.ep.Profile

class ActivityProfile extends Profile {

  static hasMany = [clientEvaluations: ClientEvaluation]

  Date date
  Integer duration

  Date dateCreated
  Date lastUpdated

  static constraints = {
    fullName (blank: false, size: 1..50)
  }
}
