package at.uenterprise.erp.base

public class EntitySuperType {

  static hasMany = [entityTypes: EntityType]

  String  name
  String  profileType = "Generic"

  static constraints = {
  }


}