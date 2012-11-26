package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.Method
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Label
import at.uenterprise.erp.Resource

/**
 * This class represents the profile of activity templates
 *
 * @author  Alexander Zeillinger
 */
class TemplateProfile extends Profile {

  SortedSet comments
  static hasMany = [methods: Method,
                    comments: Comment,
                    labels: Label,
                    resources: Resource]

  String  description
  String  chosenMaterials
  String  socialForm
  String  amountEducators
  String  status
  String  type
  String  goal
  Integer duration
  Integer ageFrom
  Integer ageTo
  Date    dateCreated
  Date    lastUpdated

  static constraints = {
    description     blank: true, maxSize: 20000
    chosenMaterials size: 2..20000, maxSize: 20000
    duration        max: 500
    goal            nullable: true, maxSize: 20000
    ageFrom         nullable: true
    ageTo           nullable: true, validator: {at, obj ->
                                                 return at ? at >= obj.ageFrom : true
                                               }
  }

  String toString() {
    return "${fullName}"
  }

    String nameDuration() {
        return "${fullName} (${duration}min)"
    }

}
