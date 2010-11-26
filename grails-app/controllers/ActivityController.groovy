import java.text.SimpleDateFormat
import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.ProfileHelperService
import standard.MetaDataService
import standard.FunctionService
import at.openfactory.ep.Profile
import lernardo.ClientEvaluation

class ActivityController {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService
  ProfileHelperService profileHelperService

  def beforeInterceptor = [
          action:{
            params.periodStart = params.periodStart ? Date.parse("dd. MM. yy", params.periodStart) : null
            params.periodEnd = params.periodEnd ? Date.parse("dd. MM. yy", params.periodEnd) : null},
            only:['save','update']
  ]

  def index = {
    redirect action: list
  }

  /*
   * lists either all activities or only activities of a selected date of a given entity
   */
  def list = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = params.max ? params.int('max') : 10
    params.myDate_year = params.myDate_year ?: 'alle'

    Entity currentEntity = entityHelperService.loggedIn

    // get a list of facilities the current entity is linked to
    List facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking)

    // create empty list for final results
    List activityList = []
    def activityCount

    // get all activities
    if (params.myDate_year == 'alle' || params.list == "Alle") {

      // show educator only his own activities
      if (currentEntity.type.id == metaDataService.etEducator.id) {
        // get all activities of the facilities the current entity is linked to
        facilities.each {
          List activities = functionService.findAllByLink(it as Entity, null, metaDataService.ltActFacility)

          activities.each {bla ->
            // there are 2 types of activities, we only want theme room activities here
            if (bla.profile.type == "Themenraum")
              activityList << bla
          }
        }
        activityCount = activityList.size()
        def upperBound = params.offset + 10 < activityList.size() ? params.offset + 10 : activityList.size()
        activityList = activityList.subList(params.offset, upperBound)
      }
      else
      {
        def c = Entity.createCriteria()
        activityList = c.list {
          eq("type", metaDataService.etActivity)
          profile {
            eq("type", "Themenraum")
            order("date","desc")
          }
          maxResults(params.max)
          firstResult(params.offset)
        }

        def d = Entity.createCriteria()
        def count = d.list {
          eq("type", metaDataService.etActivity)
          profile {
            eq("type", "Themenraum")
          }
        }

        activityCount = count.size()

      }

      return ['activityList': activityList,
              'activityCount': activityCount]
    }

    // get all activities between a given date range    
    if (params.myDate_year && params.myDate_month && params.myDate_day) {
      Date inputDate = new Date()
      String input = "${params.myDate_year}/${params.myDate_month}/${params.myDate_day}"
      inputDate = new SimpleDateFormat("yyyy/MM/dd").parse(input)

      // get all activities of the facilities within the timeframe
      if (currentEntity.type.id == metaDataService.etEducator.id) {
        // get all activities of the facilities the current entity is linked to
        facilities.each {
          List activities = functionService.findAllByLink(it as Entity, null, metaDataService.ltActFacility)

          activities.each {bla ->
            // there are 2 types of activities, we only want theme room activities here
            if (bla.profile.date > inputDate && bla.profile.date < inputDate + 1 && bla.profile.type == "Themenraum")
              activityList << bla
          }
        }
        activityCount = activityList.size()
        def upperBound = params.offset + 10 < activityList.size() ? params.offset + 10 : activityList.size()
        activityList = activityList.subList(params.offset, upperBound)
      }
      else {
        /*Entity.findAllByType(metaDataService.etActivity).each {bla ->
          if (bla.profile.date > inputDate && bla.profile.date < inputDate + 1)
            activityList << bla*/

        def c = Entity.createCriteria()
        activityList = c.list {
          eq("type", metaDataService.etActivity)
          profile {
            eq("type", "Themenraum")
            between("date", inputDate, inputDate + 1)
            order("date","desc")
          }
          maxResults(params.max)
          firstResult(params.offset)
        }

        def d = Entity.createCriteria()
        def count = d.list {
          eq("type", metaDataService.etActivity)
          profile {
            eq("type", "Themenraum")
            between("date", inputDate, inputDate + 1)
          }
        }

         activityCount = count.size()
      }

      return ['activityList': activityList,
              'activityCount': activityCount,
              'dateSelected': inputDate]
    }
    return
    /*return ['activityList': Entity.findAllByType(metaDataService.etActivity, params),
            'activityCount': Entity.countByType(metaDataService.etActivity)]*/
  }

  /*
   * shows an activity
   */
  def show = {
    Entity activity = Entity.get(params.id)
    Entity entity = params.entity ? activity : entityHelperService.loggedIn

    List clients = Entity.findAllByType(metaDataService.etClient)

    return ['activity': activity,
            'entity': entity,
            'clients': clients]
  }

  /*
  * shows view to create a theme room activity
  */
  def create = {
    // get template the activity is created from
    //Entity template = Entity.get(params.id)

    Entity currentEntity = entityHelperService.loggedIn

    // get a list of facilities the current entity is working in
    def facilities = []
    if (currentEntity.type.name == metaDataService.etEducator.name)
      facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking)
    else
      facilities = Entity.findAllByType(metaDataService.etFacility)
    def educators = Entity.findAllByType(metaDataService.etEducator)
    def clients = Entity.findAllByType(metaDataService.etClient)
    def resources = Entity.findAllByType(metaDataService.etResource)

    def c = Entity.createCriteria()
    def templates = c.list {
      profile {
        eq("type", "Themenraumaktivitätsvorlage")
      }
    }

    return [/*'template': template,*/
            'facilities': facilities,
            'educators': educators,
            'clients': clients,
            'resources': resources,
            'templates': templates]
  }

  /*
   * saves a batch of theme room activities between a certain time range
   */
  def save = {ActivityCommand ac->
    Entity currentEntity = entityHelperService.loggedIn

    if (ac.hasErrors()) {

      def facilities = []
      if (currentEntity.type.name == metaDataService.etEducator.name)
        facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking)
      else
        facilities = Entity.findAllByType(metaDataService.etFacility)
      def educators = Entity.findAllByType(metaDataService.etEducator)
      def clients = Entity.findAllByType(metaDataService.etClient)
      def resources = Entity.findAllByType(metaDataService.etResource)

      def c = Entity.createCriteria()
      def templates = c.list {
        profile {
          eq("type", "Themenraumaktivitätsvorlage")
        }
      }

      render view:'create', model:['ac':ac,
                                   'facilities': facilities,
                                   'educators': educators,
                                   'clients': clients,
                                   'resources': resources,
                                   'templates': templates]
      return
    }

    EntityType etActivity = metaDataService.etActivity

    Entity template = Entity.get(params.template)
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
    params.periodEnd.setHours(23);
    params.periodEnd.setMinutes(59);

    Calendar calendarStart = new GregorianCalendar();
    calendarStart.setTime(periodStart);

    Calendar calendarEnd = new GregorianCalendar();
    calendarEnd.setTime(periodEnd);

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
          if (Entity.get(it).id != currentEntity.id) {
            functionService.createEvent(Entity.get(it), '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Aktivität <a href="' + createLink(controller: 'activity', action: 'show', id: entity.id) + '">' + entity.profile.fullName + '</a> mit dir als TeilnehmerIn angelegt.')
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

    flash.message = "Themenraumaktivitäten wurden geplant!"
    redirect action: 'list'
  }

  def edit = {
    Entity activity = Entity.get(params.id)

    Entity currentEntity = entityHelperService.loggedIn

    // get a list of facilities the current entity is working in
    def facilities = []
    if (currentEntity.type.name == metaDataService.etEducator.name)
      facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking)
    else
      facilities = Entity.findAllByType(metaDataService.etFacility)
    def educators = Entity.findAllByType(metaDataService.etEducator)
    def clients = Entity.findAllByType(metaDataService.etClient)

    List currentEducators = functionService.findAllByLink(null, activity, metaDataService.ltActEducator)
    List currentClients = functionService.findAllByLink(null, activity, metaDataService.ltActClient)

    return ['activity': activity,
            'facilities': facilities,
            'educators': educators,
            'clients': clients,
            'currentEducators': currentEducators,
            'currentClients': currentClients]
  }

  def update = {
    Entity activity = Entity.get(params.id)

    Entity currentEntity = entityHelperService.loggedIn

    activity.profile.properties = params

    // delete old links of educators and clients
    Link.findAllByTargetAndType(activity, metaDataService.ltActEducator).each {it.delete()}
    Link.findAllByTargetAndType(activity, metaDataService.ltActClient).each {it.delete()}

    functionService.getParamAsList(params.educators).each {
      new Link(source: Entity.get(it), target: activity, type: metaDataService.ltActEducator).save()
      if (Entity.get(it).id != currentEntity.id) {
        functionService.createEvent(Entity.get(it), '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Aktivität <a href="' + createLink(controller: 'activity', action: 'show', id: activity.id) + '">' + activity.profile.fullName + '</a> aktualisiert.')
      }
    }

    functionService.getParamAsList(params.clients).each {
      new Link(source: Entity.get(it), target: activity, type: metaDataService.ltActClient).save()
      if (Entity.get(it).id != currentEntity.id) {
        functionService.createEvent(Entity.get(it), '<a href="' + createLink(controller: currentEntity.type.supertype.name +'Profile', action:'show', id: currentEntity.id) + '">' + currentEntity.profile.fullName + '</a> hat die Aktivität <a href="' + createLink(controller: 'activity', action: 'show', id: activity.id) + '">' + activity.profile.fullName + '</a> aktualisiert.')
      }
    }   

    if (!activity.hasErrors() && activity.save()) {
      flash.message = message(code: "activity.updated", args: [activity.profile.fullName])
      functionService.createEvent(currentEntity, 'Du hast die Aktivität "' + activity.profile.fullName + '" aktualisiert.')
      redirect action: 'show', id: activity.id
    }
    else {
      // get a list of facilities the current entity is working in
      def facilities = []
      if (currentEntity.type.name == metaDataService.etEducator.name)
        facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking)
      else
        facilities = Entity.findAllByType(metaDataService.etFacility)
      def educators = Entity.findAllByType(metaDataService.etEducator)
      def clients = Entity.findAllByType(metaDataService.etClient)

      List currentEducators = functionService.findAllByLink(null, activity, metaDataService.ltActEducator)
      List currentClients = functionService.findAllByLink(null, activity, metaDataService.ltActClient)
      render view: 'edit', model: ['activity': activity,
                                   'facilities': facilities,
                                   'educators': educators,
                                   'clients': clients,
                                   'currentEducators': currentEducators,
                                   'currentClients': currentClients]
    }

  }

  def del = {
    Entity activity = Entity.get(params.id)

    // delete all links to activity
    Link.findAllBySourceOrTarget(activity, activity).each {it.delete()}

    flash.message = message(code: "activity.deleted", args: [activity.profile.fullName])
    activity.delete(flush: true)
    redirect action: 'list'
  }

  def addClient = {
    ClientEvaluation clientEvaluation = new ClientEvaluation(params)
    Entity activity = Entity.get(params.id)

    activity.profile.addToClientEvaluations(clientEvaluation)
    render template: 'clients', model: [activity: activity, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    Entity activity = Entity.get(params.id)
    activity.profile.removeFromClientEvaluations(ClientEvaluation.get(params.clientEvaluation))
    render template: 'clients', model: [activity: activity, entity: entityHelperService.loggedIn]
  }

  /*
   * retrieves all templates matching the search parameter
   */
  def remoteTemplates = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etTemplate)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">Keine Ergebnisse gefunden!</span>'
      return
    }
    else {
      render(template: 'templateresults', model: [results: results])
    }
  }

  def addTemplate = {
    Entity template = Entity.get(params.id)

    render ("<b>Gew&aumlhlte Vorlage:</b> ${template.profile.fullName}")
  }

  /*
   * retrieves all templates matching the search parameter
   */
  def remoteFacilities = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etFacility)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">Keine Ergebnisse gefunden!</span>'
      return
    }
    else {
      render(template: 'facilityresults', model: [results: results])
    }
  }

  def addFacility = {
    Entity facility = Entity.get(params.id)

    render ("<b>Gew&aumlhlte Einrichtung:</b> ${facility.profile.fullName}")
  }
}

/*
* command object to handle validation of theme room activities
*/
class ActivityCommand {
  String fullName
  Date periodStart
  Date periodEnd

  String facility
  String educators

  Boolean monday
  Boolean tuesday
  Boolean wednesday
  Boolean thursday
  Boolean friday
  Boolean saturday
  Boolean sunday
  Boolean weekdays

  String mondayStartHour
  String tuesdayStartHour
  String wednesdayStartHour
  String thursdayStartHour
  String fridayStartHour
  String saturdayStartHour
  String sundayStartHour

  String mondayEndHour
  String tuesdayEndHour
  String wednesdayEndHour
  String thursdayEndHour
  String fridayEndHour
  String saturdayEndHour
  String sundayEndHour

  String mondayStartMinute
  String tuesdayStartMinute
  String wednesdayStartMinute
  String thursdayStartMinute
  String fridayStartMinute
  String saturdayStartMinute
  String sundayStartMinute

  String mondayEndMinute
  String tuesdayEndMinute
  String wednesdayEndMinute
  String thursdayEndMinute
  String fridayEndMinute
  String saturdayEndMinute
  String sundayEndMinute

  static constraints = {
    fullName(blank: false)
    periodStart(nullable: false)
    periodEnd(nullable: false, validator: {pe, ac ->
      return pe >= ac.periodStart
    })
    facility(nullable: false)
    educators(nullable: false)
    mondayEndHour(nullable: true, validator: {pe, ac ->
      return pe.toInteger() >= ac.mondayStartHour.toInteger()
    })
    tuesdayEndHour(nullable: true, validator: {pe, ac ->
      return pe.toInteger() >= ac.tuesdayStartHour.toInteger()
    })
    wednesdayEndHour(nullable: true, validator: {pe, ac ->
      return pe.toInteger() >= ac.wednesdayStartHour.toInteger()
    })
    thursdayEndHour(nullable: true, validator: {pe, ac ->
      return pe.toInteger() >= ac.thursdayStartHour.toInteger()
    })
    fridayEndHour(nullable: true, validator: {pe, ac ->
      return pe.toInteger() >= ac.fridayStartHour.toInteger()
    })
    saturdayEndHour(nullable: true, validator: {pe, ac ->
      return pe.toInteger() >= ac.saturdayStartHour.toInteger()
    })
    sundayEndHour(nullable: true, validator: {pe, ac ->
      return pe.toInteger() >= ac.sundayStartHour.toInteger()
    })
    weekdays(validator: {wd, pc ->
      return !(!pc.monday && !pc.tuesday && !pc.wednesday && !pc.thursday && !pc.friday && !pc.saturday && !pc.sunday)})
  }

}