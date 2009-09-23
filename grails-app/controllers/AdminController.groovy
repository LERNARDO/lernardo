class AdminController {
    def actionsDataService
    def activitiesDataService

    def index = {}

    def listActions = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        def res = ['actionList': actionsDataService.listActions (params.offset, params.max),
                   'totalActions': actionsDataService.totalActions ()]
        render (view:"list_actions", model:res)
    }

    def listActivities = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        def res = ['activityList': activitiesDataService.listActivities (params.offset, params.max),
                   'totalActivities': activitiesDataService.totalActivities ()]
        render (view:"list_activities", model:res)
    }
}