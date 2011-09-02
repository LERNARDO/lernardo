package at.uenterprise.erp

/**
 * This class represents publications types
 *
 * @author  Alexander Zeillinger
 */
class PublicationType {

  static hasMany = [publications: Publication]

  String name
  String description

  static constraints = {
    name        blank: false
    description nullable: true
  }

}
