class AdminController {
    def profileDataService
    def actionsDataService

    def index = {}

    def listProfiles = {
        params.profileType = params.profileType ?: "all"
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        def res = ['profileType': params.profileType,
                   'profileList': profileDataService.listProfiles (params.profileType, params.offset, params.max),
                   'totalProfiles': profileDataService.totalProfiles (params.profileType)]
        render (view:"list_profiles", model:res)
    }

    def listActions = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        def res = ['actionList': actionsDataService.listActions (params.offset, params.max),
                   'totalActions': actionsDataService.totalActions ()]
        render (view:"list_actions", model:res)
    }
}