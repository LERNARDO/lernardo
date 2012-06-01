package at.uenterprise.erp.base

public class Profile {
  static belongsTo = [entity: Entity]

  String fullName

  static constraints = {
    fullName  size: 5..80
  }

}