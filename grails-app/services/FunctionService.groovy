import de.uenterprise.ep.Entity
import lernardo.Event

class FunctionService {

    boolean transactional = true

    def createEvent(Entity entity, String content, Date date = new Date()) {
      new Event(entity: entity, content: content, date: date).save()
    }
}
