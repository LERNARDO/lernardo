import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class AppFilters {
  EntityHelperService entityHelperService

  static filters = {

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

    loginCheck(controller: "(groupActivityProfile|groupActivityTemplateProfile|groupClientProfile|groupColonyProfile|groupFamilyProfile|groupPartnerProfile|projectProfile|projectTemplateProfile|resourceProfile|themeProfile|childProfile|clientProfile|educatorProfile|facilityProfile|operatorProfile|parentProfile|partnerProfile|pateProfile|userProfile|activityProfile|msg|template)", action: "*") {
      before = {
        Entity e = entityHelperService.getLoggedIn()
        if (!e) {
          redirect controller: 'app', action: 'home'
        }
      }
    }

  }
}