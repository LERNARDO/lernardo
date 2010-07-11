package lernardo

import at.openfactory.ep.Entity
import at.openfactory.ep.Asset

class Publication {

  static belongsTo = [entity:Entity]

  PublicationType type
  Asset           asset

  String name
  Date dateCreated
  Integer accesslevel = 0

  static constraints = {
    name (blank: false, maxSize: 50)
    asset (nullable: false)
    dateCreated (nullable: true)
  }
}
