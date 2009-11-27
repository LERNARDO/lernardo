import de.uenterprise.ep.Entity

class AdminController {

    def index = {
      return [entity: Entity.findByName(params.name)]}
}
