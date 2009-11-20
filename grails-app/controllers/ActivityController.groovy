import java.text.SimpleDateFormat
import de.uenterprise.ep.Entity

class ActivityController {
  def entityHelperService

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
      def activityInstance = new Activity()
      activityInstance.properties = params
      return ['activityInstance':activityInstance]
    }

    def save = {

      Activity a = Activity.findByTitle (params.title)
      if (a) {
        flash.message = "activity already exists"
        redirect action:"create", params:params
        return
      }

      println params

      def activityInstance = new Activity(params)
      activityInstance.owner = entityHelperService.loggedIn
      activityInstance.date = new Date()                                  // test placeholder
      activityInstance.duration = Integer.parseInt(params.duration)
      activityInstance.paeds = []                                         // test placeholder
      activityInstance.clients = []                                       // test placeholder
      activityInstance.facility = Entity.findByName('kaumberg')           // test placeholder
        if(!activityInstance.hasErrors() && activityInstance.save(flush:true)) {
          flash.message = "aktivität wurde angelegt"
          redirect controller:'template', action:'list'
        }
        else {
          flash.message = "aktivität konnte nicht angelegt werden"
          redirect controller:'template', action:'list'
        }
    }

    def cancel = {
        redirect (controller:"template", action:"list")
    }
}