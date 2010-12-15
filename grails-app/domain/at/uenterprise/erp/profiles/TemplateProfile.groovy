package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Method
import at.uenterprise.erp.Comment

class TemplateProfile extends Profile {

  SortedSet comments
  static hasMany = [methods: Method,
                    comments: Comment]

  String description
  String chosenMaterials
  String socialForm
  String amountEducators
  String status
  Integer duration
  String type

  Date dateCreated
  Date lastUpdated

  static constraints = {
    fullName (blank: false, size: 2..50, maxSize: 50)
    description (blank: true, maxSize: 5000)
    chosenMaterials (size: 2..5000, maxSize: 5000)
    duration (max: 500)
  }

  String toString(){
    return "${fullName} (${duration}min)"
  }
}
