package at.uenterprise.erp.profiles

import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.Entity
import java.text.SimpleDateFormat

import at.openfactory.ep.EntityType
import at.openfactory.ep.Profile
import at.openfactory.ep.Link
import at.uenterprise.erp.ClientEvaluation
import at.openfactory.ep.Asset
import java.util.regex.Pattern

class ActivityProfileController {

  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FunctionService functionService
  ProfileHelperService profileHelperService

  def beforeInterceptor = [
          action:{
            params.periodStart = params.periodStart ? Date.parse("dd. MM. yy", params.periodStart) : null
            params.periodEnd = params.periodEnd ? Date.parse("dd. MM. yy", params.periodEnd) : null
            params.date = params.date ? Date.parse("dd. MM. yy, HH:mm", params.date) : null},
            only:['save','update']
  ]

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: list
  }

  /*
   * lists either all activities or only activities of a selected date of a given entity
   */
  def list = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = params.max ? params.int('max') : 10
    if (!params.myDate)
      params.myDate = 'all'

    Entity currentEntity = entityHelperService.loggedIn

    // get a list of facilities the current entity is linked to
    List facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking)
    facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator))

    // create empty list for final results
    List activityList = []
    def activityCount

    // get all activities
    if (params.myDate == "all") {

      // show educator only his own activities
      if (currentEntity.type.id == metaDataService.etEducator.id) {
        // get all activities of the facilities the current entity is linked to
        facilities.each { Entity facility ->
          List activities = functionService.findAllByLink(facility, null, metaDataService.ltActFacility)

          activities.each { Entity act ->
            // there are 2 types of activities, we only want theme room activities here
            if (act?.profile?.type && act?.profile?.type == "Themenraum")
              activityList << act
          }
        }
        activityCount = activityList.size()
        def upperBound = params.offset + 10 < activityList.size() ? params.offset + 10 : activityList.size()
        activityList = activityList.subList(params.offset, upperBound)
      }
      else {
        EntityType etActivity = metaDataService.etActivity
        activityList = Entity.createCriteria().list {
          eq("type", etActivity)
          profile {
            eq("type", "Themenraum")
            order("date","desc")
          }
          maxResults(params.max)
          firstResult(params.offset)
        }
        List totalActivityList = Entity.createCriteria().list {
          eq("type", etActivity)
          profile {
            eq("type", "Themenraum")
          }
        }
        activityCount = totalActivityList.size()
      }

      return ['activityList': activityList,
              'activityCount': activityCount]
    }

    // get all activities between a given date range
    else {
      Date inputDate = new Date()
      if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.myDate))
        inputDate = Date.parse("dd. MM. yy", params.myDate)

      // get all activities of the facilities within the timeframe
      if (currentEntity.type.id == metaDataService.etEducator.id) {
        // get all activities of the facilities the current entity is linked to
        facilities.each { Entity facility ->
          List activities = functionService.findAllByLink(facility, null, metaDataService.ltActFacility)

          activities.each {Entity act ->
            // there are 2 types of activities, we only want theme room activities here
            if (act.profile.date > inputDate && act.profile.date < inputDate + 1 && act?.profile?.type == "Themenraum")
              activityList << act
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

        EntityType etActivity = metaDataService.etActivity
        activityList = Entity.createCriteria().list {
          eq("type", etActivity)
          profile {
            eq("type", "Themenraum")
            between("date", inputDate, inputDate + 1)
            order("date","desc")
          }
          maxResults(params.max)
          firstResult(params.offset)
        }
        List totalActivityList = Entity.createCriteria().list {
          eq("type", etActivity)
          profile {
            eq("type", "Themenraum")
            between("date", inputDate, inputDate + 1)
          }
        }
        activityCount = totalActivityList.size()
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

    //List clients = Entity.findAllByType(metaDataService.etClient)

    List allFacilities = Entity.findAllByType(metaDataService.etFacility)

    return [activity: activity,
            entity: entity,
            //clientsOld: clients,
            educators: functionService.findAllByLink(null, activity, metaDataService.ltActEducator),
            clients: functionService.findAllByLink(null, activity, metaDataService.ltActClient),
            facilities: functionService.findAllByLink(null, activity, metaDataService.ltActFacility),
            allFacilities: allFacilities]
  }

  /*
  * shows view to create a theme room activity
  */
  def create = {}

  /*
   * saves a batch of theme room activities between a certain time range
   */
  def save = {ActivityCommand ac ->
    if (ac.hasErrors()) {
      render view:'create', model:['ac':ac]
      return
    }

    EntityType etActivity = metaDataService.etActivity

    Entity template = Entity.get(params.template)

    Date periodStart = params.periodStart
    Date periodEnd = params.periodEnd

    // subtract one minute of the period end for correct calculation
    periodEnd.setHours(23)
    periodEnd.setMinutes(59)

    SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

    Date currentDate = periodStart
    while (currentDate <= periodEnd) {

      if ((params.monday && df.format(currentDate) == 'Monday') ||
              (params.tuesday && df.format(currentDate) == 'Tuesday') ||
              (params.wednesday && df.format(currentDate) == 'Wednesday') ||
              (params.thursday && df.format(currentDate) == 'Thursday') ||
              (params.friday && df.format(currentDate) == 'Friday') ||
              (params.saturday && df.format(currentDate) == 'Saturday') ||
              (params.sunday && df.format(currentDate) == 'Sunday')) {

        Entity entity = entityHelperService.createEntity("activity", etActivity) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.type = "Themenraum"
          ent.profile.date = currentDate
          if (df.format(currentDate) == 'Monday') {
            ent.profile.date.setHours(params.int('mondayStartHour'))
            ent.profile.date.setMinutes(params.int('mondayStartMinute'))
            ent.profile.duration = (params.int('mondayEndHour') - params.int('mondayStartHour')) * 60 + (params.int('mondayEndMinute') - params.int('mondayStartMinute'))
          }
          else if (df.format(currentDate) == 'Tuesday') {
            ent.profile.date.setHours(params.int('tuesdayStartHour'))
            ent.profile.date.setMinutes(params.int('tuesdayStartMinute'))
            ent.profile.duration = (params.int('tuesdayEndHour') - params.int('tuesdayStartHour')) * 60 + (params.int('tuesdayEndMinute') - params.int('tuesdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Wednesday') {
            ent.profile.date.setHours(params.int('wednesdayStartHour'))
            ent.profile.date.setMinutes(params.int('wednesdayStartMinute'))
            ent.profile.duration = (params.int('wednesdayEndHour') - params.int('wednesdayStartHour')) * 60 + (params.int('wednesdayEndMinute') - params.int('wednesdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Thursday') {
            ent.profile.date.setHours(params.int('thursdayStartHour'))
            ent.profile.date.setMinutes(params.int('thursdayStartMinute'))
            ent.profile.duration = (params.int('thursdayEndHour') - params.int('thursdayStartHour')) * 60 + (params.int('thursdayEndMinute') - params.int('thursdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Friday') {
            ent.profile.date.setHours(params.int('fridayStartHour'))
            ent.profile.date.setMinutes(params.int('fridayStartMinute'))
            ent.profile.duration = (params.int('fridayEndHour') - params.int('fridayStartHour')) * 60 + (params.int('fridayEndMinute') - params.int('fridayStartMinute'))
          }
          else if (df.format(currentDate) == 'Saturday') {
            ent.profile.date.setHours(params.int('saturdayStartHour'))
            ent.profile.date.setMinutes(params.int('saturdayStartMinute'))
            ent.profile.duration = (params.int('saturdayEndHour') - params.int('saturdayStartHour')) * 60 + (params.int('saturdayEndMinute') - params.int('saturdayStartMinute'))
          }
          else if (df.format(currentDate) == 'Sunday') {
            ent.profile.date.setHours(params.int('sundayStartHour'))
            ent.profile.date.setMinutes(params.int('sundayStartMinute'))
            ent.profile.duration = (params.int('sundayEndHour') - params.int('sundayStartHour')) * 60 + (params.int('sundayEndMinute') - params.int('sundayStartMinute'))
          }
          ent.profile.fullName = params.fullName
          ent.profile.date = functionService.convertToUTC(ent.profile.date)
        }
        // inherit profile picture: go through each asset of the template, find the asset of type "profile" and assign it to the new entity
        template.assets.each { Asset asset ->
          if (asset.type == "profile") {
            new Asset(entity: entity, storage: asset.storage, type: "profile").save()
          }
        }

        // create links to educators
        params.list('educators').each {
          Entity educator = Entity.get(it)
          new Link(source: educator, target: entity, type: metaDataService.ltActEducator).save()
        }

        // create links to resources
        params.list('resources').each {
          new Link(source: Entity.get(it), target: entity, type: metaDataService.ltResource).save()
        }

        // create link to facility
        new Link(source: Entity.get(params.int('facility')), target: entity, type: metaDataService.ltActFacility).save()

        // create link to template
        new Link(source: template, target: entity, type: metaDataService.ltActTemplate).save()
      }

      currentDate += 1
    }

    flash.message = message(code: "activityInstances.scheduled")
    redirect action: 'list'
  }

  def edit = {
    Entity activity = Entity.get(params.id)

    Entity currentEntity = entityHelperService.loggedIn

    // get a list of facilities the current entity is working in
    /*def facilities = []
    if (currentEntity.type.name == metaDataService.etEducator.name)
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking))
    else
      facilities.addAll(Entity.findAllByType(metaDataService.etFacility))*/
    //def educators = Entity.findAllByType(metaDataService.etEducator)
    //educators.sort {it.profile.firstName}
    //def clients = Entity.findAllByType(metaDataService.etClient)

    //List currentEducators = functionService.findAllByLink(null, activity, metaDataService.ltActEducator)
    //List currentClients = functionService.findAllByLink(null, activity, metaDataService.ltActClient)

    return ['activity': activity,
            //'facilities': facilities,
            //'educators': educators,
            //'clients': clients,
            //'currentEducators': currentEducators,
            //'currentClients': currentClients
            ]
  }

  def update = {
    Entity activity = Entity.get(params.id)

    Entity currentEntity = entityHelperService.loggedIn

    activity.profile.properties = params
    activity.profile.date = functionService.convertToUTC(activity.profile.date)

    if (activity.profile.save() && activity.save()) {
      flash.message = message(code: "activity.updated", args: [activity.profile.fullName])
      redirect action: 'show', id: activity.id, params: [entity: activity.id]
    }
    else {
      // get a list of facilities the current entity is working in
      /*def facilities = []
      if (currentEntity.type.name == metaDataService.etEducator.name)
        facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking))
      else
        facilities.addAll(Entity.findAllByType(metaDataService.etFacility))
      def educators = Entity.findAllByType(metaDataService.etEducator)
      def clients = Entity.findAllByType(metaDataService.etClient)

      List currentEducators = functionService.findAllByLink(null, activity, metaDataService.ltActEducator)
      List currentClients = functionService.findAllByLink(null, activity, metaDataService.ltActClient)*/
      render view: 'edit', model: ['activity': activity,
                                   /*'facilities': facilities,
                                   'educators': educators,
                                   'clients': clients,
                                   'currentEducators': currentEducators,
                                   'currentClients': currentClients*/]
    }

  }

  def delete = {
    Entity activity = Entity.get(params.id)

    // delete all links to activity
    Link.findAllBySourceOrTarget(activity, activity).each {it.delete()}

    flash.message = message(code: "activity.deleted", args: [activity.profile.fullName])
    activity.delete(flush: true)
    redirect action: 'list'
  }

  def addClientOld = {
    ClientEvaluation clientEvaluation = new ClientEvaluation(params)
    Entity activity = Entity.get(params.id)

    activity.profile.addToClientEvaluations(clientEvaluation)
    render template: 'clientsOld', model: [activity: activity, entity: entityHelperService.loggedIn]
  }

  def removeClientOld = {
    Entity activity = Entity.get(params.id)
    activity.profile.removeFromClientEvaluations(ClientEvaluation.get(params.clientEvaluation))
    render template: 'clientsOld', model: [activity: activity, entity: entityHelperService.loggedIn]
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
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'templateresults', model: [results: results])
    }
  }

  def addTemplate = {
    Entity template = Entity.get(params.id)

    // render ("<b>Gewählte Vorlage:</b> ${template.profile.fullName}")
    def msg = message(code: "activityTemplate.selected")
    render ("<b>${msg}</b> ${template.profile.fullName}")
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
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'facilityresults', model: [results: results])
    }
  }

  /*
   * retrieves all educators matching the search parameter
   */
  def remoteEducators = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etEducator)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'educatorresults', model: [results: results, activity: params.id])
    }
  }

  /*
   * retrieves all educators matching the search parameter
   */
  def remoteClients = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', metaDataService.etClient)
      or {
        ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render '<span class="italic">'+message(code:'noResultsFound')+'</span>'
      return
    }
    else {
      render(template: 'clientresults', model: [results: results, activity: params.id])
    }
  }

  def markFacility = {
    Entity facility = Entity.get(params.id)

    // render ("<b>Gewählte Einrichtung:</b> ${facility.profile.fullName}")
    def msg = message(code: "facility.profile.selected")
    render ("<b>${msg}</b> ${facility.profile.fullName}")
  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltActEducator)
    if (linking.duplicate)
      // render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'educators', model: [educators: linking.results, activity: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltActEducator)
    render template: 'educators', model: [educators: breaking.results, activity: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addClient = {
    def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltActClient)
    if (linking.duplicate)
      //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
      render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</span>'

    render template: 'clients', model: [clients: linking.results, activity: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltActClient)
    render template: 'clients', model: [clients: breaking.results, activity: breaking.target, entity: entityHelperService.loggedIn]
  }

  def updateEducators = {
    Entity facility = Entity.get(params.id)

    // find all educators linked to this facility
    def c = Link.createCriteria()
    List educators = c.list {
      eq('target', facility)
      or {
        eq('type', metaDataService.ltWorking)
        eq('type', metaDataService.ltLeadEducator)
      }
      projections {
        distinct('source')
      }
    }
    render template: 'educatorsOld', model:[educators: educators, currentEntity: entityHelperService.loggedIn]
  }

  def addFacility = {
    Entity group = Entity.get(params.id)
    def c = Link.createCriteria()
    def result = c.get {
      eq('source', Entity.get(params.id))
      eq('type', metaDataService.ltActFacility)
    }
    if (!result) {
      def linking = functionService.linkEntities(params.id, params.facility, metaDataService.ltActFacility)
      if (linking.duplicate)
        //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
        render '<span class="red italic">"' + linking.target.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
      render template: 'facilities', model: [facilities: linking.results2, activity: linking.source, entity: entityHelperService.loggedIn]
    }
    else {
      List facilities = functionService.findAllByLink(group, null, metaDataService.ltActFacility)
      // render '<span class="red italic">Es wurde bereits eine Einrichtung zugewiesen!</span>'
      render '<span class="red italic">' +message(code: "alreadyAssignedToFacility")+'</span>'
      render template: 'facilities', model: [facilities: facilities, activity: group, entity: entityHelperService.loggedIn]
    }

  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.id, params.facility, metaDataService.ltActFacility)
    render template: 'facilities', model: [facilities: breaking.results2, group: breaking.source, entity: entityHelperService.loggedIn]
  }
}

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