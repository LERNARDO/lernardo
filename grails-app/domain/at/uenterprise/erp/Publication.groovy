package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Asset

/**
 * This class represents publications (documents) of entities
 *
 * @author  Alexander Zeillinger
 */
class Publication {

  static belongsTo = [entity: Entity]

  PublicationType type
  Asset           asset
  String          name
  Date            dateCreated
  Integer         accesslevel = 0
  Boolean         isPublic = false

  static constraints = {
    name        blank: false, maxSize: 50
    dateCreated nullable: true
  }

}
