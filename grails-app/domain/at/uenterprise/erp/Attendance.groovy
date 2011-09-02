package at.uenterprise.erp

import at.openfactory.ep.Entity

/**
 * This class represents the attendances of clients at
 * various activities
 *
 * @author  Alexander Zeillinger
 */
class Attendance {

  Entity  client
  Boolean didAttend
  Boolean didEat
  Date    date

  static constraints = {

  }

}
