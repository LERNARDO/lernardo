package lernardo

import de.uenterprise.ep.Entity

class Activity {
  static hasMany = [paeds:Entity,clients:Entity]
  static belongsTo = [owner:Entity]
  String title
  Date date
  Integer duration
  Entity facility
  String template
  String attribution

  Date dateCreated
  Date lastUpdated

    static constraints = {
      facility(nullable:true)
      template(nullable:true)
      attribution (nullable:true)
      paeds(nullable:true)
      clients(nullable:true)
    }
}
