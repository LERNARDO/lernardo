package at.uenterprise.erp

/**
 * This class represents the dates a client or educator has
 * joined or left the educational program
 *
 * @author  Alexander Zeillinger
 */
class CDate implements Comparable {

  String  type // this can be either "entry" or "exit"
  Date    date

  static constraints = {

  }

  int compareTo (obj) {
    date <=> obj.date
  }

}
