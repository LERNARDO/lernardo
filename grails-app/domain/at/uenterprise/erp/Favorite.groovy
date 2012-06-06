package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

class Favorite {

  static belongsTo = [folder: Folder]

  Entity  entity
  String  description

  static constraints = {
    folder        nullable: true
    description   nullable: true
  }
}
