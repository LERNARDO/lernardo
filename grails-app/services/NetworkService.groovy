import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

class NetworkService {

    boolean transactional = true

    def metaDataService
    def entityHelperService

    def findFriendsOf (Entity e,  def params=[]) {
      def c = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltFriend, params)
      def results = []
      for (v in c) { results << v.target }

      return results
    }
  
    boolean isFriendOf (Entity source, Entity target) {
      def links = Link.findAllBySourceAndTarget (source, target)
      def friendLink = links.find {it.type.id == metaDataService.ltFriend.id}
      return friendLink ? true :false;
    }
}
