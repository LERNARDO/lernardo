package at.uenterprise.erp

/**
 * This class represents help items
 *
 * @author  Alexander Zeillinger
 */
class Helper {

  static hasMany = [types: String]

  String  title
  String  content
  Date    dateCreated
  Date    lastUpdated

  static constraints = {
    title   blank: false, maxSize: 50
    content blank: false, maxSize: 2000
  }

}
