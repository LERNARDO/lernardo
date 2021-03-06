package at.uenterprise.erp

/**
 * This class represents health entries that can be created for clients
 *
 * @author  Alexander Zeillinger
 */
class Healths implements Comparable {

  String  text
  Date    date

  static constraints = {
    text maxSize: 10000
  }

  int compareTo (obj) {
    date <=> obj.date
  }

}
