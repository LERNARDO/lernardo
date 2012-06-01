package at.uenterprise.erp.base

public class Entity {

  static hasMany = [tagslinks: EntityTagLink, assets: Asset]

  EntityType  type
  String      name
  Date        dateCreated
  Date        lastUpdated
  Account     user
  Profile     profile

  static constraints = {
    name    size: 1..50
    user    nullable: true
    profile nullable: true
  }

  String toString() {
    "Entity: $name"
  }

}