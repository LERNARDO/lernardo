import de.uenterprise.ep.Entity

class AppFilters {
  def entityHelperService

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