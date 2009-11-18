import de.uenterprise.ep.Entity

class Msg {

    static belongsTo = [entity:Entity]

    String subject
    String content
    Date dateCreated
    Date lastUpdated
    Entity sender
    Entity receiver
    Boolean read = false

    static constraints = {
      subject(blank:false)
      content(blank:false,maxSize:2000)
      dateCreated (nullable: true)
      lastUpdated (nullable: true)
      sender (nullable: false)
      receiver (nullable: false)
      read (nullable: false)
    }
}
