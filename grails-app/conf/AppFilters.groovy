import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class AppFilters {
  EntityHelperService entityHelperService

  static filters = {

    // adds the currently logged in user to the model passed to a GSP after an action has been executed
    // doesn't work when rendering templates because a template is rendered directly to the response
    currentEntity(controller: "*", action: "*") {
      after = {model ->
        if (model) {
          Entity e = entityHelperService.getLoggedIn()
          if (e) {
            model['currentEntity'] = e
            e.user.lastAction = new Date()
            e.user.save()
          }
        }
      }
    }

    // checks if a user is logged in before executing an action
    loginCheck(controller: "(app|security|static)", invert: true) {
      before = {
        Entity e = entityHelperService.getLoggedIn()
        log.info "controller: $controllerName, action: $actionName" (e.name)

        if (!e) {
          redirect controller: 'app', action: 'home'
        }
      }
    }

  }
}