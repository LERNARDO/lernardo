class ActivityController {
    def activityDataService
    def profileDataService
    def templateDataService

    def index = {}

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        params.perMonth = params.perMonth ? params.perMonth: "alle"
        return ['activityType': params.perMonth,
                'activityList': activityDataService.find (params.offset, params.max, params.perMonth),
                'activityCount': activityDataService.findCountByMonth(params.perMonth)]
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

        if (!template) {
            response.sendError(404, "'$params.id': no such template")
            return ;
        }
        return template
    }

    def cancel = {
        redirect (controller:"template", action:"list")
    }

    def save = {
        redirect (action:"create")
    }
}