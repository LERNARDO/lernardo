package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

/**
 * This class represents news
 *
 * @author  Alexander Zeillinger
 */
class News {

  static belongsTo = [author: Entity]

  String  title
  String  teaser
  String  content
  Date    dateCreated
  Date    lastUpdated

  static constraints = {
    title       blank: false, maxSize: 50
    teaser      blank: true, maxSize: 500
    content     blank: false, maxSize: 20000
    dateCreated nullable: true
    lastUpdated nullable: true
  }

}
