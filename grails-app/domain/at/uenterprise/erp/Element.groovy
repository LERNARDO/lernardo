package at.uenterprise.erp

/**
 * This class represents the elements that can be added to a method
 *
 * @author  Alexander Zeillinger
 */
class Element implements Comparable {

  String  name
  Integer voting = 0

  static constraints = {

  }

  int compareTo (obj) {
    name <=> obj.name
  }

}
