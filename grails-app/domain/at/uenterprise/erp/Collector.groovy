package at.uenterprise.erp

/**
 * This class represents the "Abholberechtigten" of a client
 *
 * @author  Alexander Zeillinger
 */
class Collector {

  String name

  static constraints = {
    name maxSize: 50
  }

}
