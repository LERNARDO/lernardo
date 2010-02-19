import de.uenterprise.ep.Entity
import lernardo.Msg

class FilterService {

  boolean transactional = true

  def entityHelperService

  // returns the number of new inbox messages
  int getNewInboxMessages (String name) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity',Entity.findByName(name))
      ne('sender',entityHelperService.loggedIn)
      eq('read',false)
    }
    return results.size()
  }

  // returns all inbox messages for a given entity
  def getInbox (String name) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity',Entity.findByName(name))
      ne('sender',entityHelperService.loggedIn)
      order("dateCreated", "desc")
    }
    return results
  }

  // returns all outbox messages for a given entity
  def getOutbox (String name) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity',Entity.findByName(name))
      eq('sender',entityHelperService.loggedIn)
      order("dateCreated", "desc")
    }
    return results
  }

  // returns entities for user search
  def findUsers (String name) {
    def c = Entity.createCriteria()
    def results = c.list {
      or {
        ilike('name',"%"+name+"%")
        profile {
          ilike('fullName',"%"+name+"%")
        }
      }
      maxResults(15)
    }
    return results
  }

}
