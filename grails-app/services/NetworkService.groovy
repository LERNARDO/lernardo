import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

class NetworkService {

  boolean transactional = true

  def metaDataService
  def entityHelperService

  // returns friends of a given entity
  def findFriendsOf (Entity e,  def params=[]) {
    def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltFriendship, params)
    def results = []
    links.each {results << it.target}

    return results
  }

  // returns clients of a given entity
  def findClientsOf (Entity e,  def params=[]) {
    //def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltClientship, params)
    def facility = Link.findBySourceAndType (e ?: entityHelperService.loggedIn, metaDataService.ltWorking, params)
    if (facility)
      facility = facility.target
    def results = []
    if (facility) {
      def links = Link.findAllByTargetAndType (facility, metaDataService.ltClientship)
      links.each {results << it.source}
    }

    return results
  }

  // returns bookmarks of a given entity
  def findBookmarksOf (Entity e,  def params=[]) {
    def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltBookmark, params)
    def results = []
    links.each {results << it.target}

    return results
  }

  // checks for a friendship between 2 given entities
  boolean isFriendOf (Entity source, Entity target) {
    def links = Link.findAllBySourceAndTarget (source, target)
    def friendLink = links.find {it.type.id == metaDataService.ltFriendship.id}

    return friendLink ? true : false
  }

  // checks for a bookmark between 2 given entities
  boolean isBookmarkOf (Entity source, Entity target) {
    def links = Link.findAllBySourceAndTarget (source, target)
    def bookmarkLink = links.find {it.type.id == metaDataService.ltBookmark.id}

    return bookmarkLink ? true : false
  }
  
}
