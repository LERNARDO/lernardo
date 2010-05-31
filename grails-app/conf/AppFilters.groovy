import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class AppFilters {
  EntityHelperService entityHelperService

  static filters = {
    currentEntity (controller:"*", action:"*") {
      after = {model->
        if (model) {
          Entity e = entityHelperService.getLoggedIn()
          if (e)
            model['currentEntity'] = e
        }
      }
    }
  }
}