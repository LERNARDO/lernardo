package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

/**
 * This class represents entries of a dayroutine of a facility
 *
 * @author  Alexander Zeillinger
 */
class Dayroutine {

  static belongsTo = [facility: Entity]

  String  day
  String  title
  String  description
  Date    dateFrom
  Date    dateTo

  static constraints = {
    title blank: false
  }

}
