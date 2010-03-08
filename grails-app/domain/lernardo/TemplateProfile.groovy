package lernardo

import de.uenterprise.ep.Profile

class TemplateProfile extends Profile {

  String attribution
  String description
  String socialForm
  String qualifications
  Integer duration 
  Integer ll
  Integer be
  Integer pk
  Integer si
  Integer hk
  Integer tlt
  Integer requiredPaeds

  Date dateCreated
  Date lastUpdated

  static constraints = {
    fullName (blank: false)
    description (blank: false, maxSize: 5000)
  }
}
