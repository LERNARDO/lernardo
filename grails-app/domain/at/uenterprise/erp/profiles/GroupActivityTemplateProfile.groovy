package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Label
import at.uenterprise.erp.Resource

/**
 * This class represents a group of activity templates
 *
 * @author  Alexander Zeillinger
 */
class GroupActivityTemplateProfile extends Profile {

  SortedSet comments
  List templates
  static hasMany = [comments: Comment,
                    labels: Label,
                    templates: String,
                    resources: Resource]

  String  description
  String  status
  String  educationalObjectiveText
  Integer realDuration
  Date    dateCreated
  Date    lastUpdated

  static constraints = {
    fullName                  blank: false, size: 1..100, maxSize: 100
    description               blank: true, maxSize: 20000
    educationalObjectiveText  blank: true, maxSize: 2000
  }

  String toString() {
    return "${fullName}"
  }

}
