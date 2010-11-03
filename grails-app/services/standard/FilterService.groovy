package standard

import at.openfactory.ep.Entity
import lernardo.Msg
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.EntityType

class FilterService {
  EntityHelperService entityHelperService

  boolean transactional = true

  /*
   * returns the number of new inbox messages of a given entity
   */
  int getNewInboxMessages(Integer id) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity', Entity.get(id))
      ne('sender', Entity.get(id))
      eq('read', false)
    }
    return results.size()
  }

  /*
   * returns all inbox messages of a given entity
   */
  def getInbox(Integer id, def params = []) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity', Entity.get(id))
      ne('sender', Entity.get(id))
      order("dateCreated", "desc")
      maxResults(params.max)
      firstResult(params.offset)
    }
    return results
  }

  /*
   * returns the number of all inbox messages of a given entity
   */
  def getInboxCount(Integer id) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity', Entity.get(id))
      ne('sender', Entity.get(id))
    }
    return results.size()
  }

  /*
   * returns all outbox messages of a given entity
   */
  def getOutbox(Integer id, def params = []) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity', Entity.get(id))
      eq('sender', Entity.get(id))
      order("dateCreated", "desc")
      maxResults(params.max)
      firstResult(params.offset)
    }
    return results
  }

  /*
   * returns the number of all outbox messages of a given entity
   */
  def getOutboxCount(Integer id) {
    def c = Msg.createCriteria()
    def results = c.list {
      eq('entity', Entity.get(id))
      eq('sender', entityHelperService.loggedIn)
    }
    return results.size()
  }

  /*
   * returns all entities that match a given search parameter
   */
  List findUsers(String name) {
    def c = Entity.createCriteria()
    def results = c.list {
      or {
        ilike('name', "%" + name + "%")
        profile {
          ilike('fullName', "%" + name + "%")
        }
      }
      maxResults(15)
    }
    return results
  }

  /*
   * returns all entities that match a given search parameter and type
   */
  def findUsers(String name, EntityType type) {
    def c = Entity.createCriteria()
    def results = c.list {
      if (type != 'all')
        eq('type', type)
      or {
        ilike('name', "%" + name + "%")
        profile {
          ilike('fullName', "%" + name + "%")
        }
      }
      maxResults(15)
    }
    return results
  }
}
