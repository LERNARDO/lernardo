import de.uenterprise.ep.Entity

class FilterService {
  def entityHelperService

    boolean transactional = true

    // used to display the number of new messages in the profile navigation
    def getNewInboxMessages (String name) {
      def c = Msg.createCriteria()
      def results = c.list {
        eq('entity',Entity.findByName(name))
        ne('sender',entityHelperService.loggedIn)
        eq('read',false)
      }
      return results.size()
    }   

    def getInbox (String name) {
      def c = Msg.createCriteria()
      def results = c.list {
        eq('entity',Entity.findByName(name))
        ne('sender',entityHelperService.loggedIn)
        order("dateCreated", "desc")
      }
      return results
    }

    def getOutbox (String name) {
      def c = Msg.createCriteria()
      def results = c.list {
        eq('entity',Entity.findByName(name))
        eq('sender',entityHelperService.loggedIn)
        order("dateCreated", "desc")
      }
      return results
    }

    def findUsers (String name) {
      def c = Entity.createCriteria()
      def results = c.list {
        profile {
        ilike('fullName',"%"+name+"%")
        maxResults(10)
        }
      }
      return results
    }
}
