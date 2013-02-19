package at.uenterprise.erp.base

public class Profile {
  static belongsTo = [entity: Entity]

  String fullName

    String activityParams

  static constraints = {
        fullName    blank: false, size: 1..100, maxSize: 100
      activityParams nullable: true
  }

    static mapping = {
        activityParams type: "text"
    }

}