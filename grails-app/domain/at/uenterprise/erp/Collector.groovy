package at.uenterprise.erp

/**
 * This class represents the "Abholberechtigten" of a client
 *
 * @author  Alexander Zeillinger
 */
class Collector {

  String text // TODO: rename this property to "name" which makes more sense

  static constraints = {
    text maxSize: 50
  }

}
