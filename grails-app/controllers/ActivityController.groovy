import java.text.SimpleDateFormat
import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link

class ActivityController {
  def entityHelperService
  def metaDataService
  def functionService
  def profileHelperService

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

          facilityList.each {
            List tempList = Link.findAllBySourceAndType(it, metaDataService.ltActFac)

            tempList.each {bla ->
              activityList << bla.target
              }
          }
          /*// get all activities
          def activities = Activity.list()

          List tempList = Entity.findAllByType(metaDataService.etActivity)

          // sort them out
          activities.each {
            for (f in facilityList) {
              if (it.facility == f)
                activityList << it
            }
          }*/

          def activityCount = activityList.size()
          def upperBound = params.offset + 10 < activityList.size() ? params.offset + 10 : activityList.size()
          activityList = activityList.subList(params.offset,upperBound)

          return ['activityList': activityList,
                  'activityCount': activityCount,
                  'entity': entityHelperService.loggedIn]
        }


        if(params.myDate_year && params.myDate_month && params.myDate_day) {
          Date inputDate = new Date()
          String input = "${params.myDate_year}/${params.myDate_month}/${params.myDate_day}"
          inputDate = new SimpleDateFormat("yyyy/MM/dd").parse(input)

/*          def c = Activity.createCriteria()
          def activities = c.list {
            String input = "${params.myDate_year}/${params.myDate_month}/${params.myDate_day}"
            inputDate = new SimpleDateFormat("yyyy/MM/dd").parse(input)
            between('date',inputDate,inputDate+1)
          }*/

          facilityList.each {
            List tempList = Link.findAllBySourceAndType(it, metaDataService.ltActFac)

            tempList.each {bla ->
              if (bla.target.profile.date > inputDate && bla.target.profile.date < inputDate+1)
                activityList << bla.target
              }
          }
/*          def c = Entity.createCriteria()
          def activities = c.list {

            profile {
              between('date',inputDate,inputDate+1)
            }
            eq('type', metaDataService.etActivity)
          }*/
          
          // sort them out
/*          activities.each {
            for (f in facilityList) {
              if (it.facility == f)
                activityList << it
            }
          }*/

          def activityCount = activityList.size()
          def upperBound = params.offset + 10 < activityList.size() ? params.offset + 10 : activityList.size()
          activityList = activityList.subList(params.offset,upperBound)

          return ['activityList': activityList,
                  'activityCount': activityCount,
                  'dateSelected': inputDate,
                  'entity': entityHelperService.loggedIn]
        }
        return ['activityList': Entity.findAllByType(metaDataService.etActivity, params),
                'activityCount': Entity.countByType(metaDataService.etActivity),
                'entity': entityHelperService.loggedIn]
    }

    def show = {
        def activity = Entity.get(params.id)

        if (!activity) {
          flash.message = message(code:"activity.notFound", args:[params.id])
          redirect action:index
        }

        return ['activity':activity,
                'entity': entityHelperService.loggedIn]
    }

    def create = {
      //def activity = new Activity()
      def template = Entity.get(params.id)
      //activity.title = template.name
      //activity.duration = template.duration
      //activity.template = template

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

      return [/*'activityInstance': activity,*/
              'template': template,
              'availFacilities': facilityMap,
              'availPaeds': paedMap,
              'availClients': clientMap,
              'entity': entityHelperService.loggedIn
              ]
    }

    def save = {
      EntityType etActivity = metaDataService.etActivity

      def entity = entityHelperService.createEntity(params.title, etActivity) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent)
        ent.profile.fullName = params.title
        ent.profile.date = new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),Integer.parseInt(params.date_hour),Integer.parseInt(params.date_minute))
        ent.profile.duration = params.duration.toInteger()
      }

      params.paeds.each {
        new Link(source: Entity.get(it), target: entity, type: metaDataService.ltActPaed).save()
        if (Entity.get(it) != entityHelperService.loggedIn) {
          functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+entity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
        }
      }
      params.clients.each {
        new Link(source: Entity.get(it), target: entity, type: metaDataService.ltActClient).save()
      }
      new Link(source: Entity.get(params.facility.toInteger()), target: entity, type: metaDataService.ltActFac).save()
      new Link(source: Entity.findByName(params.template), target: entity, type: metaDataService.ltActTemplate).save()
      new Link(source: entityHelperService.loggedIn, target: entity, type: metaDataService.ltActCreator).save()
      //new Link(source: Entity.findByName('martin'), target: entity, type: metaDataService.ltActResource).save()

/*     def activity = new Activity(title:params.title,
          owner:entityHelperService.loggedIn,
          date: new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),Integer.parseInt(params.date_hour),Integer.parseInt(params.date_minute)),
          duration: params.duration.toInteger(),
          paeds:params.paeds,
          clients:params.clients,
          facility:Entity.get(params.facility.toInteger()),
          template:params.template,
          attribution:ActivityTemplate.findByName(params.template).attribution).save()*/

      //if(!activity.hasErrors() && activity.save(flush:true)) {
          flash.message = message(code:"activity.created", args:[params.title])
          functionService.createEvent(entityHelperService.loggedIn, Entity.get(params.facility.toInteger()).profile.fullName+': Aktivität "'+entity.profile.fullName+'"', entity.profile.date)
          functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivität "'+entity.profile.fullName+'" angelegt.')
          redirect action:'show', id:entity.id
        //}
        //else {
        //  flash.message = message(code:"activity.notCreated", args:[params.title])
        //  redirect action:"create", id:"${ActivityTemplate.findByName(params.template).id}"
        //}
    }

    def cancel = {
        redirect controller:"template", action:"list"
    }

    def edit = {
        def activity = Entity.get(params.id)

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
        def activity = Entity.get(params.id)
        if(activity) {
            activity.properties = params
            //activityInstance.title = params.title
            ///activity.owner = entityHelperService.loggedIn
            activity.profile.date =  new Date(Integer.parseInt(params.date_year)-1900,Integer.parseInt(params.date_month)-1,Integer.parseInt(params.date_day),Integer.parseInt(params.date_hour),Integer.parseInt(params.date_minute))
            activity.profile.duration = params.duration.toInteger()
            //activity.paeds = params.paeds
            //activity.clients = params.clients
            ///activity.facility = Entity.get(params.facility.toInteger())
            //activity.attribution = ActivityTemplate.findByName(params.template).attribution

            // delete old links
            def links = Link.findAllByTargetAndType(activity, metaDataService.ltActPaed)
            links.each {it.delete()}
            links = Link.findAllByTargetAndType(activity, metaDataService.ltActClient)
            links.each {it.delete()}

            // create new links
            params.paeds.each {
              new Link(source: Entity.get(it), target: activity, type: metaDataService.ltActPaed).save()
              if (Entity.get(it) != entityHelperService.loggedIn) {
                functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+activity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
              }
            }
            params.clients.each {
              new Link(source: Entity.get(it), target: activity, type: metaDataService.ltActClient).save()
            }
            if(!activity.hasErrors() && activity.save()) {
                flash.message = message(code:"activity.updated", args:[activity.profile.fullName])

/*                functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivität "'+activity.title+'" aktualisiert.')
                activity.paeds.each {
                  if (it != entityHelperService.loggedIn)
                    functionService.createEvent(it, entityHelperService.loggedIn+' hat die Aktivität "'+activity.title+'" aktualisiert.')
                }*/

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
      def activity = Entity.get(params.id)

      def links = Link.findAllByTarget(activity)
      links.each {it.delete()}
      flash.message = message(code:"activity.deleted", args:[activity.profile.fullName])
      activity.delete(flush:true)
      redirect action:'list'

    }
}