import java.text.SimpleDateFormat
import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import lernardo.Activity
import lernardo.ActivityTemplate

class ActivityController {
  def entityHelperService
  def metaDataService ;

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
                  'entity': entityHelperService.loggedIn]
        }


        if(params.myDate_year && params.myDate_month && params.myDate_day) {
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
                'entity': entityHelperService.loggedIn]
        }
        return ['activityList': Activity.list(params),
                'activityCount': Activity.count(),
                'entity': entityHelperService.loggedIn]
    }

    def show = {
        def activity = Activity.get(params.id)

        if (!activity) {
          flash.message = message(code:"activity.notFound", args:[params.id])
          redirect action:index
        }

        return ['activity':activity,
                'entity': entityHelperService.loggedIn]
    }

    def create = {
      def activityInstance = new Activity()
      activityInstance.properties = params

      def template = ActivityTemplate.get(params.id)
      activityInstance.title = template.name
      activityInstance.duration = template.duration
      activityInstance.template = template ;
      activityInstance.facility = Entity.findByName ("kaumberg")


      return ['activityInstance': activityInstance,
              'template': template,
              'hortList': Entity.findAllByType(EntityType.findByName('Hort')),
              'availPaeds': Entity.findAllByType(metaDataService.etPaed),
              'availClients': Entity.findAllByType(metaDataService.etClient),
              'entity': entityHelperService.loggedIn
              ]
    }

    def save = {
      lernardo.Activity activityInstance = new lernardo.Activity(params)
      activityInstance.owner = entityHelperService.loggedIn
      activityInstance.attribution = ActivityTemplate.findByName(params.template).attribution 

      if(activityInstance.save(flush:true)) {
          flash.message = message(code:"activity.created", args:[params.title])
          redirect action:'show', id:activityInstance.id
        }
        else {
          flash.message = message(code:"activity.notCreated", args:[params.title])
          redirect action:"create", id:"${ActivityTemplate.findByName(params.template).id}"
        }
    }

    def cancel = {
        redirect controller:"template", action:"list"
    }

    def edit = {
        def activityInstance = Activity.get( params.id )

        if(!activityInstance) {
            flash.message = message(code:"activity.notFound", args:[params.id])
            redirect action:'list'
        }
        else {
            return ['activityInstance': activityInstance,
                    'hortList': Entity.findAllByType(EntityType.findByName('Hort')),
                    'availPaeds': Entity.findAllByType(metaDataService.etPaed),
                    'availClients': Entity.findAllByType(metaDataService.etClient),
                    'entity': entityHelperService.loggedIn ]
        }
    }

    def update = {
        def activityInstance = Activity.get( params.id )
        if(activityInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(activityInstance.version > version) {
                    activityInstance.errors.rejectValue("version", "msg.optimistic.locking.failure", "Another user has updated this Template while you were editing.")
                    render view:'edit', model:[activityInstance:activityInstance]
                    return
                }
            }
            activityInstance.properties = params
            if(!activityInstance.hasErrors() && activityInstance.save()) {
                flash.message = message(code:"activity.updated", args:[activityInstance.title])
                redirect action:'show', id:activityInstance.id
            }
            else {
                render view:'edit', model:[activityInstance:activityInstance]
            }
        }
        else {
            flash.message = message(code:"activity.notFound", args:[activityInstance.id])
            redirect action:'edit', params:params
        }
    }
}