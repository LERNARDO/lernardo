import de.uenterprise.ep.Entity

class NetworkController {
    def networkService

    def index = {
      Entity e = Entity.findByName(params.name)
      return ['entity':e,
              'friendsList':networkService.findFriendsOf(e),
              'clientsList':networkService.findClientsOf(e),
              'bookmarksList':networkService.findBookmarksOf(e)]
    }
}
