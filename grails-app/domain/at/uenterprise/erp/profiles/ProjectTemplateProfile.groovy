package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Label
import at.uenterprise.erp.Resource

/**
 * This class represents the profile of project templates
 *
 * @author  Alexander Zeillinger
 */
class ProjectTemplateProfile extends Profile {

  SortedSet comments
  List templates
  static hasMany = [comments: Comment,
                    labels: Label,
                    templates: String,
                    resources: Resource]

  String description
  String status
  String educationalObjectiveText
  Integer ageFrom
  Integer ageTo

  static constraints = {
    fullName                  blank: false, size: 1..100, maxSize: 100
    description               blank: true, maxSize: 20000
    educationalObjectiveText  nullable: true, maxSize: 2000
    ageFrom         nullable: true
    ageTo           nullable: true, validator: {at, obj ->
                                                 return at ? at >= obj.ageFrom : true
                                               }
  }

  String toString() {
    return "${fullName}"
  }

}
