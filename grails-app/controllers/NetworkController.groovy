import de.uenterprise.ep.Entity

class NetworkController {
  NetworkService networkService

  def index = {
    Entity entity = Entity.get(params.id)
    return ['entity': entity,
            'friendsList': networkService.findFriendsOf(entity),
            'clientsList': networkService.findClientsOf(entity),
            'bookmarksList': networkService.findBookmarksOf(entity),
            'operatorsList': networkService.findOperatorsOf(entity),
            'facilitiesList': networkService.findFacilitiesOf(entity),
            'facilities2List': networkService.findFacilities2Of(entity)]
  }
}
