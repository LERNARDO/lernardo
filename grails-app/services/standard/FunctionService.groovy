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

  /* the return type of a multiple select box is inconsistent (string when a single entry was selected, or a list when
     multiple entries were selected) so this helper method takes the parameter and returns it as a list either way */
  def getParamAsList(param) {
		def paramList = []
		if (param && param != 'null') {
			(param?.class?.isArray()) ? paramList << (param as List) : paramList << (param)
			paramList = paramList.flatten()
		}
		return paramList
	}
  
}
