import java.text.SimpleDateFormat

class ActivityController {

    def index = {}

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        params.myDate_year = params.myDate_year ?: 'alle'
        println params

        if (params.list== 'Alle')
          return ['activityList': Activity.list(),
                  'activityCount': Activity.count()]

        if(params.myDate_year && params.myDate_month && params.myDate_day){
          def c = Activity.createCriteria()
          Date inputDate = new Date()
          def results = c.list {
            String input = "${params.myDate_year}/${params.myDate_month}/${params.myDate_day}"
            inputDate = new SimpleDateFormat("yyyy/MM/dd").parse(input)
            between('date',inputDate,inputDate+1)
          }
          println inputDate
          return ['activityList': results,
                'activityCount': results.size(),
                'dateSelected': inputDate]
        }
        return ['activityList': Activity.list(),
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