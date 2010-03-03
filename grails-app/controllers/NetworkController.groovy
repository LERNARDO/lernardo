import de.uenterprise.ep.Entity

class NetworkController {
  def networkService

  def index = {
    Entity entity = Entity.findByName(params.name)
    return ['entity':entity,
            'friendsList':networkService.findFriendsOf(entity),
            'clientsList':networkService.findClientsOf(entity),
            'bookmarksList':networkService.findBookmarksOf(entity)]
  }
}
