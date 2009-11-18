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
}
