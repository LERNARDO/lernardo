package at.uenterprise.erp.base

class Tag {

  static hasMany = [entityLinks: EntityTagLink]

  String  name
  Date    dateCreated

  static constraints = {
  }

}
