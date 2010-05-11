package lernardo

import de.uenterprise.ep.Profile

class TemplateProfile extends Profile {

  static hasMany = [methods: Method]

  String description
  String chosenMaterials // added on 30.04.2010
  String socialForm
  String amountEducators // added on 30.04.2010
  String status // added on 30.04.2010
  Integer duration

  //String attribution - removed on 30.04.2010
  //String qualifications - removed on 30.04.2010
  //Integer ll - removed on 30.04.2010
  //Integer be - removed on 30.04.2010
  //Integer pk - removed on 30.04.2010
  //Integer si - removed on 30.04.2010
  //Integer hk - removed on 30.04.2010
  //Integer tlt - removed on 30.04.2010
  //Integer requiredEducators - removed on 30.04.2010

  Date dateCreated
  Date lastUpdated

  static constraints = {
    fullName (blank: false)
    description (blank: true, maxSize: 2000)
    chosenMaterials (size: 2..50)
  }

  String toString(){
    return "${fullName} (${duration}min)"
  }
}
