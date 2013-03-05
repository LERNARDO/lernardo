import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService

class AppFilters {
    EntityHelperService entityHelperService
    def securityManager

    static filters = {

        currentEntityFilter(controller: '*', action: '*') {
            before = {
                Entity e = securityManager.getLoggedIn(request);
                if (e) {
                    e = Entity.get(e.id)
                    log.info "controller: $controllerName, action: $actionName ($e.name)"
                }
                return true
            }

            // inject currentEntity into model for backward compatibility -> use the tag instead
            after = {model ->
                if (model) {
                    Entity e = entityHelperService.getLoggedIn()
                    if (e) {
                        model['currentEntity'] = e
                        //e.user.lastAction = new Date()
                        //e.user.save()
                    }
                }
            }
        }

    }
}