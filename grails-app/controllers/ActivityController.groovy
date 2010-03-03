import java.text.SimpleDateFormat
import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import lernardo.Activity
import lernardo.ActivityTemplate
import de.uenterprise.ep.Link

class ActivityController {
  def entityHelperService
  def metaDataService
  def functionService

    def index = {
      redirect action:list
    }

    def list = {
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        params.myDate_year = params.myDate_year ?: 'alle'

        // get a list of facilities the current entity is working in
        List facilities = Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking)
        List facilityList = []

        facilities.each {
          facilityList << it.target
        }

        // create empty list for final results
        List activityList = []

        if (params.myDate_year == 'alle' || params.list == 'Alle') {

          // get all activities
          def activities = Activity.list()

          // sort them out
          activities.each {
            for (f in facilityList) {
              if (it.facility == f)
                activityList << it
            }
          }

          def activityCount = activityList.size()
          def upperBound = params.offset + 10 < activityList.size() ? params.offset + 10 : activityList.size()
          activityList = activityList.subList(params.offset,upperBound)

          return ['activityList': activityList,
                  'activityCount': activityCount,
                  'entity': entityHelperService.loggedIn]
        }


        if(params.myDate_year && params.myDate_month && params.myDate_day) {
          def c = Activity.createCriteria()
          Date inputDate = new Date()
          def activities = c.list {
            String input = "${params.myDate_year}/${params.myDate_month}/${params.myDate_day}"
            inputDate = new SimpleDateFormat("yyyy/MM/dd").parse(input)
            between('date',inputDate,inputDate+1)
          }

          // sort them out
          activities.each {
            for (f in facilityList) {
              if (it.facility == f)
                activityList << it
            }
          }

          def activityCount = activityList.size()
          def upperBound = params.offset + 10 < activityList.size() ? params.offset + 10 : activityList.size()
          activityList = activityList.subList(params.offset,upperBound)

          return ['activityList': activityList,
                'activityCount': activityCount,
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
      def activity = new Activity()
      def template = ActivityTemplate.get(params.id)
      activity.title = template.name
      activity.duration = template.duration
      activity.template = template

      // get a list of facilities the current entity is working in
      List facilities = Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking)
      Map facilityMap = [:]
      facilities.each {
        facilityMap[it.target.id] = it.target.profile.fullName
      }

      List paeds = Entity.findAllByType(metaDataService.etPaed)
      Map paedMap = [:]
      paeds.each {
        paedMap[it.id] = it.profile.fullName
      }

      List clients = Entity.findAllByType(metaDataService.etClient)
      Map clientMap = [:]
      clients.each {
        clientMap[it.id] = it.profile.fullName
      }

      return ['activityInstance': activity,
              'template': template,
              'availFacilities': facilityMap,
              'availPaeds': paedMap,
              'availClients': clientMap,
              'entity': entityHelperService.loggedIn
              ]
    }

    def save = {
      println params

     def activity = new Activity(title:params.title,
          owner:entityHelperService.loggedIn,
          date: new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),Integer.parseInt(params.date_hour),Integer.parseInt(params.date_minute)),
          duration: params.duration.toInteger(),
          paeds:params.paeds,
          clients:params.clients,
          facility:Entity.get(params.facility.toInteger()),
          template:params.template,
          attribution:ActivityTemplate.findByName(params.template).attribution).save()

      if(!activity.hasErrors() && activity.save(flush:true)) {
          flash.message = message(code:"activity.created", args:[params.title])

          functionService.createEvent(entityHelperService.loggedIn, activity.facility.profile.fullName+': Aktivität "'+activity.title+'"', activity.date)
          functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivität "'+activity.title+'" angelegt.')
          activity.paeds.each {
            if (it != entityHelperService.loggedIn)
              functionService.createEvent(it, entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+activity.title+'" mit dir als TeilnehmerIn angelegt.')
          }
          redirect action:'show', id:activity.id
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
        def activity = Activity.get( params.id )

        if(!activity) {
            flash.message = message(code:"activity.notFound", args:[params.id])
            redirect action:'list'
        }

        List facilities = Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking)
        Map facilityMap = [:]
        facilities.each {
          facilityMap[it.target.id] = it.target.profile.fullName
        }

        List paeds = Entity.findAllByType(metaDataService.etPaed)
        Map paedMap = [:]
        paeds.each {
          paedMap[it.id] = it.profile.fullName
        }

        List clients = Entity.findAllByType(metaDataService.etClient)
        Map clientMap = [:]
        clients.each {
          clientMap[it.id] = it.profile.fullName
        }

        return ['activityInstance': activity,
                'availFacilities': facilityMap,
                'availPaeds': paedMap,
                'availClients': clientMap,
                'entity': entityHelperService.loggedIn]
    }

    def update = {
        def activity = Activity.get( params.id )
        if(activity) {
            activity.properties = params
            //activityInstance.title = params.title
            activity.owner = entityHelperService.loggedIn
            activity.date =  new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),Integer.parseInt(params.date_hour),Integer.parseInt(params.date_minute))
            activity.duration = params.duration.toInteger()
            //activity.paeds = params.paeds
            //activity.clients = params.clients
            activity.facility = Entity.get(params.facility.toInteger())
            //activity.attribution = ActivityTemplate.findByName(params.template).attribution

            if(!activity.hasErrors() && activity.save()) {
                flash.message = message(code:"activity.updated", args:[activity.title])

                functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivität "'+activity.title+'" aktualisiert.')
                activity.paeds.each {
                  if (it != entityHelperService.loggedIn)
                    functionService.createEvent(it, entityHelperService.loggedIn+' hat die Aktivität "'+activity.title+'" aktualisiert.')
                }

                redirect action:'show', id:activity.id
            }
            else {
                render view:'edit', model:[activityInstance: activity, entity: entityHelperService.loggedIn]
            }
        }
        else {
            flash.message = message(code:"activity.notFound", args:[activity.id])
            redirect action:'edit', params:params
        }
    }

    def del = {
      def activity = Activity.get( params.id )
      flash.message = message(code:"activity.deleted", args:[activity.title])
      activity.delete(flush:true)
      redirect action:'list'

    }
}