package standard

import at.openfactory.ep.Entity
import at.openfactory.ep.Link

class NetworkService {

  boolean transactional = true

  def metaDataService
  def entityHelperService

  /*
   * returns all facilities a given entity is working in
   */
  def findFacilitiesOf(Entity e, def params = []) {
    def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltWorking, params)

    //def results = links*.target // spread operator doing the same as the collect method
    def results = links.collect {it.target}

    return results
  }

  /*
   * returns all facilities a given entity is client of
   */
  def findFacilities2Of(Entity e, def params = []) {
    def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltClientship, params)
    def results = links.collect {it.target}

    return results
  }

  /*
   * returns all operators of a given entity
   */
  def findOperatorsOf(Entity e, def params = []) {
    def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltOperation, params)
    def results = links.collect {it.target}

    return results
  }

  /*
   * returns all friends of a given entity
   */
  def findFriendsOf(Entity e, def params = []) {
    def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltFriendship, params)
    def results = links.collect {it.target}

    return results
  }

  /*
   * returns all clients of a given entity (facility)
   */
  def findClientsOf(Entity e, def params = []) {
    //def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltClientship, params)
    def facility = Link.findBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltWorking, params)
    if (facility)
      facility = facility.target
    def results = []
    if (facility) {
      def links = Link.findAllByTargetAndType(facility, metaDataService.ltClientship)
      results = links.collect {it.source}
    }

    return results
  }

  /*
   * returns all bookmarks of a given entity
   */
  def findBookmarksOf(Entity e, def params = []) {
    def links = Link.findAllBySourceAndType(e ?: entityHelperService.loggedIn, metaDataService.ltBookmark, params)
    def results = links.collect {it.target}

    return results
  }

  /*
   * checks for a friendship between two given entities
   */
  boolean isFriendOf(Entity source, Entity target) {
    def links = Link.findAllBySourceAndTarget(source, target)
    def friendLink = links.find {it.type.id == metaDataService.ltFriendship.id}

    return friendLink ? true : false
  }

  /*
   * checks for a bookmark between two given entities
   */
  boolean isBookmarkOf(Entity source, Entity target) {
    def links = Link.findAllBySourceAndTarget(source, target)
    def bookmarkLink = links.find {it.type.id == metaDataService.ltBookmark.id}

    return bookmarkLink ? true : false
  }

}
