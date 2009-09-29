class ActivityController {
    def activityDataService
    def profileDataService
    def templateDataService

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

    def show = {
      def activity = activityDataService.findById(params.id)

      if (!activity) {
        response.sendError(404, "'$params.id': no such activity")
        return ;
      }

      def e = profileDataService.getProfile(activity.einrichtung ?: "")
      
      return [activity:activity, einrichtung:e]
    }

    def create = {
        def template = templateDataService.findById(params.id)

        render (view:"create", model:template)
    }

    def cancel = {
        redirect (controller:"template", action:"list")
    }

    def save = {
        redirect (action:"create")
    }
}