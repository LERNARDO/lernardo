package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.Asset

class Publication {

  static belongsTo = [entity:Entity]

  PublicationType type
  Asset           asset

  String name
  Date dateCreated
  Integer accesslevel = 0

  static constraints = {
    name (blank: false)
    asset (nullable: false)
    dateCreated (nullable: true)
  }
}
