class ActivityController {
    def activityDataService

    def index = {}

    def list = {
        println params
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        params.perMonth = params.perMonth ? params.perMonth: "alle"
        def res = ['activityType': params.perMonth,
                   'activityList': activityDataService.getActivities (params.offset, params.max, params.perMonth),
                   'activityCount': activityDataService.getActivityCount(params.perMonth)]
        render (view:"list", model:res)
        
    }
}