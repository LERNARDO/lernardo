import java.text.SimpleDateFormat
import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import lernardo.Activity
import lernardo.ActivityTemplate
import de.uenterprise.ep.Link

class ActivityController {
  def entityHelperService
  def metaDataService
  def FunctionService

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
      def activityInstance = new Activity()
      def template = ActivityTemplate.get(params.id)
      activityInstance.title = template.name
      activityInstance.duration = template.duration
      activityInstance.template = template

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

      return ['activityInstance': activityInstance,
              'template': template,
              'availFacilities': facilityMap,
              'availPaeds': paedMap,
              'availClients': clientMap,
              'entity': entityHelperService.loggedIn
              ]
    }

    def save = {
      println params

     def activityInstance = new Activity(title:params.title,
          owner:entityHelperService.loggedIn,
          date: new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),Integer.parseInt(params.date_hour),Integer.parseInt(params.date_minute)),
          duration: params.duration.toInteger(),
          paeds:params.paeds,
          clients:params.clients,
          facility:Entity.get(params.facility.toInteger()),
          template:params.template,
          attribution:ActivityTemplate.findByName(params.template).attribution).save()

      if(!activityInstance.hasErrors() && activityInstance.save(flush:true)) {
          flash.message = message(code:"activity.created", args:[params.title])

          FunctionService.createEvent(entityHelperService.loggedIn, activityInstance.facility.profile.fullName+': Aktivität "'+activityInstance.title+'"', activityInstance.date)
          FunctionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivität "'+activityInstance.title+'" angelegt.')
          activityInstance.paeds.each {
            if (it != entityHelperService.loggedIn)
              FunctionService.createEvent(it, entityHelperService.loggedIn+' hat die Aktivität "'+activityInstance.title+'" mit dir als TeilnehmerIn angelegt.')
          }
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

        return ['activityInstance': activityInstance,
                'availFacilities': facilityMap,
                'availPaeds': paedMap,
                'availClients': clientMap,
                'entity': entityHelperService.loggedIn]
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
            //activityInstance.title = params.title
            activityInstance.owner = entityHelperService.loggedIn
            activityInstance.date =  new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),Integer.parseInt(params.date_hour),Integer.parseInt(params.date_minute))
            activityInstance.duration = params.duration.toInteger()
            //activityInstance.paeds = params.paeds
            //activityInstance.clients = params.clients
            activityInstance.facility = Entity.get(params.facility.toInteger())
            //activityInstance.attribution = ActivityTemplate.findByName(params.template).attribution

            if(!activityInstance.hasErrors() && activityInstance.save()) {
                flash.message = message(code:"activity.updated", args:[activityInstance.title])

                FunctionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivität "'+activityInstance.title+'" aktualisiert.')
                activityInstance.paeds.each {
                  if (it != entityHelperService.loggedIn)
                    FunctionService.createEvent(it, entityHelperService.loggedIn+' hat die Aktivität "'+activityInstance.title+'" aktualisiert.')
                }

                redirect action:'show', id:activityInstance.id
            }
            else {
                render view:'edit', model:[activityInstance:activityInstance, entity: entityHelperService.loggedIn]
            }
        }
        else {
            flash.message = message(code:"activity.notFound", args:[activityInstance.id])
            redirect action:'edit', params:params
        }
    }

    def del = {
      def activityInstance = Activity.get( params.id )
      flash.message = message(code:"activity.deleted", args:[activityInstance.title])
      activityInstance.delete(flush:true)
      redirect action:'list'

    }
}