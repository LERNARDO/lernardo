package at.uenterprise.erp.base

public class Profile {
  static belongsTo = [entity: Entity]

  String fullName

  static constraints = {
        fullName    blank: false, size: 1..100, maxSize: 100
  }

}