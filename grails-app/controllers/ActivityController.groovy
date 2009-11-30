import java.text.SimpleDateFormat
import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType

class ActivityController {
  def entityHelperService
  def metaDataService

    def index = {
      redirect action:list
    }

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        params.myDate_year = params.myDate_year ?: 'alle'

        if (params.myDate_year == 'alle' || params.list == 'Alle') {
          return ['activityList': Activity.list(params),
                  'activityCount': Activity.count(),
                  'entity':entityHelperService.loggedIn]
        }


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
                'dateSelected': inputDate,
                'entity':entityHelperService.loggedIn]
        }
        return ['activityList': Activity.list(params),
                'activityCount': Activity.count(),
                'entity':entityHelperService.loggedIn]
    }

    def show = {
        def activity = Activity.get(params.id)

        if (!activity) {
          flash.message = message(code:"activity.notFound", args:[params.id])
          redirect action:index
        }

        return ['activity':activity, 'entity':entityHelperService.loggedIn]
    }

    def create = {
      def activityInstance = new Activity()
      activityInstance.properties = params

      def template = ActivityTemplate.get(params.id)
      activityInstance.title = template.name
      activityInstance.duration = template.duration
      return ['activityInstance':activityInstance,
              'template':template,
              'hortList':Entity.findAllByType(EntityType.findByName('Hort')),
              'entity':entityHelperService.loggedIn]
    }

    def save = {

      def activityInstance = new Activity()
      activityInstance.title = params.title
      activityInstance.owner = entityHelperService.loggedIn
      activityInstance.date = new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day))
      activityInstance.duration = Integer.parseInt(params.duration)
      activityInstance.paeds = []                                         // test placeholder
      activityInstance.clients = []                                       // test placeholder
      activityInstance.facility = Entity.findByName(params.facility)
      activityInstance.template = params.template
      activityInstance.attribution = ActivityTemplate.findByName(params.template).attribution
        if(activityInstance.save(flush:true)) {
          flash.message = message(code:"activity.created", args:[params.title])
          redirect action:'show', id:activityInstance.id
        }
        else {
          flash.message = message(code:"activity.notCreated", args:[params.title])
          render view:'create', model:[activityInstance:activityInstance,template:ActivityTemplate.findByName(params.template)]
        }
    }

    def cancel = {
        redirect (controller:"template", action:"list")
    }
}