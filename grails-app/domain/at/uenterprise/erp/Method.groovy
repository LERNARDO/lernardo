package at.uenterprise.erp

/**
 * This class represents methods by which activity templates can be rated with
 *
 * @author  Alexander Zeillinger
 */
class Method {

  List elements
  static hasMany = [elements: Element]

  String name
  String description
  String type

  static constraints = {
    name        maxSize: 50
    description maxSize: 5000
  }

  String toString() {
    return "${name}"
  }

}
