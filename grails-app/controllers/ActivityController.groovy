class ActivityController {

    def index = {}

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        params.perMonth = params.perMonth ? params.perMonth: "alle"
        return ['activityType': params.perMonth,
                'activityList': Activity.list(params),
                'activityCount': Activity.count()]
    }

    def show = {
        def activity = Activity.findById(params.id)

        if (!activity) {
            response.sendError(404, "'$params.id': no such activity")
            return ;
        }

        return [activity:activity]
    }

    def create = {
        def template = ActivityTemplate.findById(params.id)

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