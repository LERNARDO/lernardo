package at.uenterprise.erp.profiles

import at.openfactory.ep.Profile
import at.uenterprise.erp.Method
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Label

class TemplateProfile extends Profile {

  SortedSet comments
  static hasMany = [methods: Method,
                    comments: Comment,
                    labels: Label]

  String description
  String chosenMaterials
  String socialForm
  String amountEducators
  String status
  Integer duration
  String type

  Date dateCreated
  Date lastUpdated

  String goal     // added on 26.05.2011
  Integer ageFrom // added on 26.05.2011
  Integer ageTo   // added on 26.05.2011

  static constraints = {
    fullName (blank: false, size: 1..100, maxSize: 100)
    description (blank: true, maxSize: 20000)
    chosenMaterials (size: 2..20000, maxSize: 20000)
    duration (max: 500)
    goal nullable: true, maxSize: 20000
    ageFrom nullable: true
    ageTo nullable: true
  }

  String toString(){
    return "${fullName} (${duration}min)"
  }
}
