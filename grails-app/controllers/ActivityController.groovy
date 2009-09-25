class ActivityController {
    def activityDataService

    def index = {}

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        params.perMonth = params.perMonth ? params.perMonth.toInteger(): 0
        def res = ['activityList': activityDataService.getActivities (params.offset, params.max, params.perMonth),
                   'activityCount': activityDataService.getActivityCount ()]
        render (view:"list", model:res)
        
    }
}