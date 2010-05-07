package standard

import de.uenterprise.ep.Entity
import lernardo.Event
import org.springframework.web.servlet.support.RequestContextUtils

class FunctionService {

  boolean transactional = true

  def createEvent(Entity entity, String content, Date date = new Date()) {
    new Event(entity: entity, content: content, date: date).save()
  }

  def createNick (String firstName, String fullName) {
    def nickname = (firstName + fullName).toLowerCase()
    def matcher = (nickname =~/[^a-z0-9]+/)
    def newname = matcher.replaceAll("-")
    return newname
  }

  def createNick (String fullName) {
    def nickname = fullName.toLowerCase()
    def matcher = (nickname =~/[^a-z0-9]+/)
    def newname = matcher.replaceAll("-")
    return newname
  }
  
}
