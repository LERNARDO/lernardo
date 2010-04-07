import de.uenterprise.ep.Entity
import lernardo.Msg

class FilterService {

  boolean transactional = true

  def entityHelperService

  // returns the number of new inbox messages
  int getNewInboxMessages (String id) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity',Entity.get(id))
      ne('sender',entityHelperService.loggedIn)
      eq('read',false)
    }
    return results.size()
  }

  // returns all inbox messages for a given entity
  def getInbox (String id) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity',Entity.get(id))
      ne('sender',entityHelperService.loggedIn)
      order("dateCreated", "desc")
      maxResults(params.max)
      firstResult(params.offset)
    }
    return results
  }

  def getInboxCount (String id) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity',Entity.get(id))
      ne('sender',entityHelperService.loggedIn)
    }
    return results.size()
  }

  // returns all outbox messages for a given entity
  def getOutbox (String id) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity',Entity.get(id))
      eq('sender',entityHelperService.loggedIn)
      order("dateCreated", "desc")
      maxResults(params.max)
      firstResult(params.offset)
    }
    return results
  }

  def getOutboxCount (String id) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity',Entity.get(id))
      eq('sender',entityHelperService.loggedIn)
    }
    return results.size()
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
