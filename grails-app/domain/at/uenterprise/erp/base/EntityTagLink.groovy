package at.uenterprise.erp.base

class EntityTagLink {

  static belongsTo = [tag: Tag]

  Entity      entity
  TagLinkType type

  static constraints = {
  }

}
