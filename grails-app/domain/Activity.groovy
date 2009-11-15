import de.uenterprise.ep.Entity

class Activity {

  static hasMany = [paeds:Entity,clients:Entity]
  String title
  Entity owner
  Date date
  Integer duration
  Entity facility
 

  Date dateCreated
  Date lastUpdated

    static constraints = {
    }
}
