package lernardo

import at.openfactory.ep.Profile

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
    chosenMaterials (size: 2..50, maxSize: 5000)
    duration (max: 500)
  }

  String toString(){
    return "${fullName} (${duration}min)"
  }
}
