import java.text.SimpleDateFormat
import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.EntityHelperService
import de.uenterprise.ep.ProfileHelperService
import standard.MetaDataService
import standard.FunctionService
import de.uenterprise.ep.Profile
import lernardo.ClientEvaluation

class ActivityController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService
  ProfileHelperService profileHelperService

  def index = {
    redirect action:list
  }

  def list = {
    params.offset = params.offset ? params.int('offset'): 0
    params.max = params.max ? params.int('max'): 10
    params.myDate_year = params.myDate_year ?: 'alle'

    // get a list of facilities the current entity is linked to
    List links = Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking)
    List facilities = links.collect {it.target}

    // create empty list for final results
    List activityList = []

    if (params.myDate_year == 'alle' || params.list == 'Alle') {

      if (entityHelperService.loggedIn.type.name == metaDataService.etEducator.name) {
        // get all activities of the facilities the current entity is linked to
        facilities.each {
          List tempList = Link.findAllBySourceAndType(it, metaDataService.ltActFacility)

          tempList.each {bla ->
            activityList << bla.target
            }
        }
      }
      else
        activityList = Entity.findAllByType(metaDataService.etActivity)

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

      // get all activities of the facilities within the timeframe
      if (entityHelperService.loggedIn.type.name == metaDataService.etEducator.name) {
        // get all activities of the facilities the current entity is linked to
        facilities.each {
          List tempList = Link.findAllBySourceAndType(it, metaDataService.ltActFacility)

          tempList.each {bla ->
            if (bla.target.profile.date > inputDate && bla.target.profile.date < inputDate+1)
              activityList << bla.target
            }
        }
      }
      else
        Entity.findAllByType(metaDataService.etActivity).each {bla ->
          if (bla.profile.date > inputDate && bla.profile.date < inputDate+1)
            activityList << bla
          }

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
      Entity activity = Entity.get(params.id)

      List clients = Entity.findAllByType(metaDataService.etClient)

      return ['activity':activity,
              'entity': entityHelperService.loggedIn,
              'clients': clients]
    }

    def create = {
      // get template the activity is created from
      Entity template = Entity.get(params.id)

      // get a list of facilities the current entity is working in
      def facilities = []
      if (entityHelperService.loggedIn.type.name == metaDataService.etEducator.name)
        Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking).each {facilities << it.target}
      else
        facilities = Entity.findAllByType(metaDataService.etFacility)
      def educators = Entity.findAllByType(metaDataService.etEducator)
      def clients = Entity.findAllByType(metaDataService.etClient)
      def resources = Entity.findAllByType(metaDataService.etResource)

      return ['template': template,
              'facilities': facilities,
              'educators': educators,
              'clients': clients,
              'entity': entityHelperService.loggedIn,
              'resources': resources]
    }

    def save = {
      //log.info params
      EntityType etActivity = metaDataService.etActivity

      Entity template = Entity.get(params.id)
       // params.fullName
      // params.periodStart
      // params.periodEnd
      // params.monday ... params.sunday
      // params.mondayStartHour / EndHour / StartMinute / EndMinute ...
      // params.facility
      // params.educators
      // params.resources

      Date periodStart = params.periodStart
      Date periodEnd = params.periodEnd

      Calendar calendarStart = new GregorianCalendar();
      calendarStart.setTime( periodStart );

      Calendar calendarEnd = new GregorianCalendar();
      calendarEnd.setTime( periodEnd );

      SimpleDateFormat df = new SimpleDateFormat("EEEE")     

      // loop through the date range and compare the dates day with the params
      while (calendarStart <= calendarEnd) {
        Date currentDate = calendarStart.getTime();
        //log.info df.format(currentDate)

        if ((params.monday && (df.format(currentDate) == 'Montag' || df.format(currentDate) == 'Monday')) ||
              (params.tuesday && (df.format(currentDate) == 'Dienstag' || df.format(currentDate) == 'Tuesday')) ||
              (params.wednesday && (df.format(currentDate) == 'Mittwoch' || df.format(currentDate) == 'Wednesday')) ||
              (params.thursday && (df.format(currentDate) == 'Donnerstag' || df.format(currentDate) == 'Thursday')) ||
              (params.friday && (df.format(currentDate) == 'Freitag' || df.format(currentDate) == 'Friday')) ||
              (params.saturday && (df.format(currentDate) == 'Samstag' || df.format(currentDate) == 'Saturday')) ||
              (params.sunday && (df.format(currentDate) == 'Sonntag' || df.format(currentDate) == 'Sunday'))) {
            //log.info "found"
            Entity entity = entityHelperService.createEntity("activity", etActivity) {Entity ent ->
              ent.profile = profileHelperService.createProfileFor(ent) as Profile
              ent.profile.type = "Themenraum"
              ent.profile.date = currentDate //loopDay + startHour
              if (df.format(currentDate) == 'Montag' || df.format(currentDate) == 'Monday') {
                ent.profile.date.setHours(params.int('mondayStartHour'))
                ent.profile.date.setMinutes(params.int('mondayStartMinute'))
                ent.profile.duration = (params.int('mondayEndHour') - params.int('mondayStartHour')) * 60 + (params.int('mondayEndMinute') - params.int('mondayStartMinute'))
              }
              if (df.format(currentDate) == 'Dienstag' || df.format(currentDate) == 'Tuesday') {
                ent.profile.date.setHours(params.int('tuesdayStartHour'))
                ent.profile.date.setMinutes(params.int('tuesdayStartMinute'))
                ent.profile.duration = (params.int('tuesdayEndHour') - params.int('tuesdayStartHour')) * 60 + (params.int('tuesdayEndMinute') - params.int('tuesdayStartMinute'))
              }
               if (df.format(currentDate) == 'Mittwoch' || df.format(currentDate) == 'Wednesday') {
                ent.profile.date.setHours(params.int('wednesdayStartHour'))
                ent.profile.date.setMinutes(params.int('wednesdayStartMinute'))
                 ent.profile.duration = (params.int('wednesdayEndHour') - params.int('wednesdayStartHour')) * 60 + (params.int('wednesdayEndMinute') - params.int('wednesdayStartMinute'))
              }
              if (df.format(currentDate) == 'Donnerstag' || df.format(currentDate) == 'Thursday') {
                ent.profile.date.setHours(params.int('thursdayStartHour'))
                ent.profile.date.setMinutes(params.int('thursdayStartMinute'))
                ent.profile.duration = (params.int('thursdayEndHour') - params.int('thursdayStartHour')) * 60 + (params.int('thursdayEndMinute') - params.int('thursdayStartMinute'))
              }
               if (df.format(currentDate) == 'Freitag' || df.format(currentDate) == 'Friday') {
                ent.profile.date.setHours(params.int('fridayStartHour'))
                ent.profile.date.setMinutes(params.int('fridayStartMinute'))
                 ent.profile.duration = (params.int('fridayEndHour') - params.int('fridayStartHour')) * 60 + (params.int('fridayEndMinute') - params.int('fridayStartMinute'))
              }
              if (df.format(currentDate) == 'Samstag' || df.format(currentDate) == 'Saturday') {
                ent.profile.date.setHours(params.int('saturdayStartHour'))
                ent.profile.date.setMinutes(params.int('saturdayStartMinute'))
                ent.profile.duration = (params.int('saturdayEndHour') - params.int('saturdayStartHour')) * 60 + (params.int('saturdayEndMinute') - params.int('saturdayStartMinute'))
              }
              if (df.format(currentDate) == 'Sonntag' || df.format(currentDate) == 'Sunday') {
                ent.profile.date.setHours(params.int('sundayStartHour'))
                ent.profile.date.setMinutes(params.int('sundayStartMinute'))
                ent.profile.duration = (params.int('sundayEndHour') - params.int('sundayStartHour')) * 60 + (params.int('sundayEndMinute') - params.int('sundayStartMinute'))
              }
              ent.profile.fullName = params.fullName
           }

            // create links to educators
            functionService.getParamAsList(params.educators).each {
              new Link(source: Entity.get(it), target: entity, type: metaDataService.ltActEducator).save()
              if (Entity.get(it) != entityHelperService.loggedIn) {
                functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+entity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
              }
            }

            // create links to resources
            functionService.getParamAsList(params.resources).each {
              new Link(source: Entity.get(it), target: entity, type: metaDataService.ltResource).save()
            }

            // create link to facility
            new Link(source: Entity.get(params.int('facility')), target: entity, type: metaDataService.ltActFacility).save()

            // create link to template
            new Link(source: template, target: entity, type: metaDataService.ltActTemplate).save()
        }

        // increment calendar
        calendarStart.add(Calendar.DATE, 1)
      }


      //redirect action:'create', id: params.id
      redirect action:'list'

/*      // get a list of facilities the current entity is working in
      List facilities = Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking).collect {it.target}

      def educators = Entity.findAllByType(metaDataService.etEducator)
      def clients = Entity.findAllByType(metaDataService.etClient)

      try {
      Entity entity = entityHelperService.createEntity("activity", etActivity) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      // create links to educators
*//*      if (params.educators) {
        def p_educators = params.educators
        if (p_educators.class.isArray()) {
          params.educators.each {
            new Link(source: Entity.get(it), target: entity, type: metaDataService.ltActEducator).save()
            if (Entity.get(it) != entityHelperService.loggedIn) {
              functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+entity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
            }
          }
        }
        else {
          new Link(source: Entity.get(p_educators), target: entity, type: metaDataService.ltActEducator).save()
        }
      }*//*

      // create client links
*//*      if (params.clients) {
        def p_clients = params.clients
        if (p_clients.class.isArray()) {
          params.clients.each {
            new Link(source: Entity.get(it), target: entity, type: metaDataService.ltActClient).save()
            if (Entity.get(it) != entityHelperService.loggedIn) {
              functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+entity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
            }
          }
        }
        else {
          new Link(source: Entity.get(p_clients), target: entity, type: metaDataService.ltActClient).save()
        }
      }*//*

      functionService.getParamAsList(params.clients).each {
        new Link(source: Entity.get(it), target: entity, type: metaDataService.ltActClient).save()
        if (Entity.get(it) != entityHelperService.loggedIn) {
          functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+entity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
        }
      }

      new Link(source: Entity.get(params.int('facility')), target: entity, type: metaDataService.ltActFacility).save()
      new Link(source: template, target: entity, type: metaDataService.ltActTemplate).save()
      new Link(source: entityHelperService.loggedIn, target: entity, type: metaDataService.ltCreator).save()
      //new Link(source: Entity.get(123), target: entity, type: metaDataService.ltActResource).save()


      flash.message = message(code:"activity.created", args:[entity.profile.fullName])
      functionService.createEvent(entityHelperService.loggedIn, Entity.get(params.int('facility')).profile.fullName+': Aktivität "'+entity.profile.fullName+'"', entity.profile.date)
      functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivität "'+entity.profile.fullName+'" angelegt.')
      redirect action:'show', id:entity.id
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[activityInstance: ee.entity, entity: entityHelperService.loggedIn, 'template': template,'facilities': facilities, 'educators': educators, 'clients': clients])
        return
      }*/

    }

    def edit = {
        Entity activity = Entity.get(params.id)

        // get a list of facilities the current entity is working in
        def facilities = []
        if (entityHelperService.loggedIn.type.name == metaDataService.etEducator.name)
          Link.findAllBySourceAndType(entityHelperService.loggedIn, metaDataService.ltWorking).each {facilities << it.target}
        else
          facilities = Entity.findAllByType(metaDataService.etFacility)
        def educators = Entity.findAllByType(metaDataService.etEducator)
        def clients = Entity.findAllByType(metaDataService.etClient)

        return ['activity': activity,
                'facilities': facilities,
                'educators': educators,
                'clients': clients,
                'entity': entityHelperService.loggedIn]
    }

    def update = {
      // TODO: fix validation
      Entity activity = Entity.get(params.id)

      activity.profile.properties = params

      // delete old links of educators and clients
      Link.findAllByTargetAndType(activity, metaDataService.ltActEducator).each {it.delete()}
      Link.findAllByTargetAndType(activity, metaDataService.ltActClient).each {it.delete()}

      // create links to educators
/*      if (params.educators) {
        def p_educators = params.educators
        if (p_educators.class.isArray()) {
          params.educators.each {
            new Link(source: Entity.get(it), target: activity, type: metaDataService.ltActEducator).save()
            if (Entity.get(it) != entityHelperService.loggedIn) {
              functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+activity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
            }
          }
        }
        else {
          new Link(source: Entity.get(p_educators), target: activity, type: metaDataService.ltActEducator).save()
        }
      }*/

      functionService.getParamAsList(params.educators).each {
        new Link(source: Entity.get(it), target: activity, type: metaDataService.ltActEducator).save()
        if (Entity.get(it) != entityHelperService.loggedIn) {
          functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+activity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
        }
      }

      // create links to clients
/*      if (params.clients) {
        def p_clients = params.clients
        if (p_clients.class.isArray()) {
          params.clients.each {
            new Link(source: Entity.get(it), target: activity, type: metaDataService.ltActClient).save()
            if (Entity.get(it) != entityHelperService.loggedIn) {
              functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+activity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
            }
          }
        }
        else {
          new Link(source: Entity.get(p_clients), target: activity, type: metaDataService.ltActClient).save()
        }
      }*/

      functionService.getParamAsList(params.clients).each {
        new Link(source: Entity.get(it), target: activity, type: metaDataService.ltActClient).save()
        if (Entity.get(it) != entityHelperService.loggedIn) {
          functionService.createEvent(Entity.get(it), entityHelperService.loggedIn.profile.fullName+' hat die Aktivität "'+activity.profile.fullName+'" mit dir als TeilnehmerIn angelegt.')
        }
      }

      if(!activity.hasErrors() && activity.save()) {
        flash.message = message(code:"activity.updated", args:[activity.profile.fullName])
        functionService.createEvent(entityHelperService.loggedIn, 'Du hast die Aktivität "'+activity.profile.fullName+'" aktualisiert.')
        redirect action:'show', id:activity.id
      }
      else {
          render view:'edit', model:[activityInstance: activity, entity: entityHelperService.loggedIn]
      }

    }

    def del = {
      Entity activity = Entity.get(params.id)

      // delete all links to activity
      Link.findAllByTarget(activity).each {it.delete()}
      
      flash.message = message(code:"activity.deleted", args:[activity.profile.fullName])
      activity.delete(flush:true)
      redirect action:'list'
    }

    def addClient = {
      ClientEvaluation clientEvaluation = new ClientEvaluation(params)
      Entity activity = Entity.get(params.id)
      
      activity.profile.addToClientEvaluations(clientEvaluation)
      render template:'clients', model: [activity: activity, entity: entityHelperService.loggedIn]
    }

    def removeClient = {
      Entity activity = Entity.get(params.id)
      activity.profile.removeFromClientEvaluations(ClientEvaluation.get(params.clientEvaluation))
      render template:'clients', model: [activity: activity, entity: entityHelperService.loggedIn]
    }
}