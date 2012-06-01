package at.uenterprise.erp.base

public class LinkType {

  static hasMany = [links: Link]

  LinkSuperType type
  String        name

  static constraints = {
  }

}