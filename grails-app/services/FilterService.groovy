import de.uenterprise.ep.Entity

class FilterService {
  def entityHelperService

    boolean transactional = true

    def getInbox (String name) {
      def c = Msg.createCriteria()
      def results = c.list {
        eq('entity',Entity.findByName(name))
        ne('sender',entityHelperService.loggedIn)
      }
      return results
    }

    def getOutbox (String name) {
      def c = Msg.createCriteria()
      def results = c.list {
        eq('entity',Entity.findByName(name))
        eq('sender',entityHelperService.loggedIn)
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
