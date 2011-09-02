package at.uenterprise.erp

import at.openfactory.ep.Entity

/**
 * This class represents general posts
 *
 * @author  Alexander Zeillinger
 */
class Post {

  static belongsTo = [author: Entity]

  String  content
  Date    dateCreated
  Date    lastUpdated

  static constraints = {
    content     blank: false, maxSize: 20000
    dateCreated nullable: true
    lastUpdated nullable: true
  }

}
