package at.uenterprise.erp

/**
 * This class represents the dates a client or educator has
 * joined or left the school
 *
 * @author  Alexander Zeillinger
 */
class SDate implements Comparable {

  String  type // this can be either "entry" or "exit"
  String  reason
  Date    date

  static constraints = {

  }

  int compareTo (obj) {
    date <=> obj.date
  }

}
