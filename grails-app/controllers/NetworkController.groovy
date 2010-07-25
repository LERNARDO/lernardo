import at.openfactory.ep.Entity
import standard.NetworkService

class NetworkController {
  NetworkService networkService

  /*
   * shows the network of a given entity
   * NOT USED ATM
   */
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
