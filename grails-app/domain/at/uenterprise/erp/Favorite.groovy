package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

class Favorite {

  Entity  entity
  String  description
  Folder  folder

  static constraints = {
    folder nullable: true
  }
}
