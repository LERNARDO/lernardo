package at.uenterprise.erp

import at.openfactory.ep.Entity

/**
 * This class represents the entities that each user can add/remove in the personal calendar
 *
 * @author  Alexander Zeillinger
 */
class CalEntity {
  
  Entity entity
  Boolean visible
  String color

  static constraints = {
  }
}
