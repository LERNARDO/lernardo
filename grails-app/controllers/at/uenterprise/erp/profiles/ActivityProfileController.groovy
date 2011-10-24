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
            params.mondayStart = params.mondayStart ? Date.parse("HH:mm", params.mondayStart) : null
            params.mondayEnd = params.mondayEnd ? Date.parse("HH:mm", params.mondayEnd) : null
            params.tuesdayStart = params.tuesdayStart ? Date.parse("HH:mm", params.tuesdayStart) : null
            params.tuesdayEnd = params.tuesdayEnd ? Date.parse("HH:mm", params.tuesdayEnd) : null
            params.wednesdayStart = params.wednesdayStart ? Date.parse("HH:mm", params.wednesdayStart) : null
            params.wednesdayEnd = params.wednesdayEnd ? Date.parse("HH:mm", params.wednesdayEnd) : null
            params.thursdayStart = params.thursdayStart ? Date.parse("HH:mm", params.thursdayStart) : null
            params.thursdayEnd = params.thursdayEnd ? Date.parse("HH:mm", params.thursdayEnd) : null
            params.fridayStart = params.fridayStart ? Date.parse("HH:mm", params.fridayStart) : null
            params.fridayEnd = params.fridayEnd ? Date.parse("HH:mm", params.fridayEnd) : null
            params.saturdayStart = params.saturdayStart ? Date.parse("HH:mm", params.saturdayStart) : null
            params.saturdayEnd = params.saturdayEnd ? Date.parse("HH:mm", params.saturdayEnd) : null
            params.sundayStart = params.sundayStart ? Date.parse("HH:mm", params.sundayStart) : null
            params.sundayEnd = params.sundayEnd ? Date.parse("HH:mm", params.sundayEnd) : null

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
            ent.profile.date.setHours(params.mondayStart.getHours())
            ent.profile.date.setMinutes(params.mondayStart.getMinutes())
            ent.profile.duration = (params.mondayEnd.getTime() - params.mondayStart.getTime()) / 1000 / 60
          }
          else if (df.format(currentDate) == 'Tuesday') {
            ent.profile.date.setHours(params.tuesdayStart.getHours())
            ent.profile.date.setMinutes(params.tuesdayStart.getMinutes())
            ent.profile.duration = (params.tuesdayEnd.getTime() - params.tuesdayStart.getTime()) / 1000 / 60
          }
          else if (df.format(currentDate) == 'Wednesday') {
            ent.profile.date.setHours(params.wednesdayStart.getHours())
            ent.profile.date.setMinutes(params.wednesdayStart.getMinutes())
            ent.profile.duration = (params.wednesdayEnd.getTime() - params.wednesdayStart.getTime()) / 1000 / 60
          }
          else if (df.format(currentDate) == 'Thursday') {
            ent.profile.date.setHours(params.thursdayStart.getHours())
            ent.profile.date.setMinutes(params.thursdayStart.getMinutes())
            ent.profile.duration = (params.thursdayEnd.getTime() - params.thursdayStart.getTime()) / 1000 / 60
          }
          else if (df.format(currentDate) == 'Friday') {
            ent.profile.date.setHours(params.fridayStart.getHours())
            ent.profile.date.setMinutes(params.fridayStart.getMinutes())
            ent.profile.duration = (params.fridayEnd.getTime() - params.fridayStart.getTime()) / 1000 / 60
          }
          else if (df.format(currentDate) == 'Saturday') {
            ent.profile.date.setHours(params.saturdayStart.getHours())
            ent.profile.date.setMinutes(params.saturdayStart.getMinutes())
            ent.profile.duration = (params.saturdayEnd.getTime() - params.saturdayStart.getTime()) / 1000 / 60
          }
          else if (df.format(currentDate) == 'Sunday') {
            ent.profile.date.setHours(params.sundayStart.getHours())
            ent.profile.date.setMinutes(params.sundayStart.getMinutes())
            ent.profile.duration = (params.sundayEnd.getTime() - params.sundayStart.getTime()) / 1000 / 60
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
    return ['activity': activity]
  }

  def update = {
    Entity activity = Entity.get(params.id)

    activity.profile.properties = params
    activity.profile.date = functionService.convertToUTC(activity.profile.date)

    if (activity.profile.save() && activity.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "activity"), activity.profile.fullName])
      redirect action: 'show', id: activity.id, params: [entity: activity.id]
    }
    else {
      render view: 'edit', model: ['activity': activity]
    }

  }

  def delete = {
    Entity activity = Entity.get(params.id)

    // delete all links to activity
    Link.findAllBySourceOrTarget(activity, activity).each {it.delete()}

    flash.message = message(code: "object.deleted", args: [message(code: "activity"), activity.profile.fullName])
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
      or {
        eq('type', metaDataService.etClient)
        eq('type', metaDataService.etGroupClient)
      }
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
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'educators', model: [educators: linking.results, activity: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltActEducator)
    render template: 'educators', model: [educators: breaking.results, activity: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addClient = {
    /*def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltActClient)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</span>'

    render template: 'clients', model: [clients: linking.results, activity: linking.target, entity: entityHelperService.loggedIn]*/

    Entity activity = Entity.get(params.id)
    Entity clientgroup = Entity.get(params.client)

    // if the entity is a client add it
    if (clientgroup.type.id == metaDataService.etClient.id) {
      def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltActClient)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" ' + message(code: "alreadyAssignedTo") + '</span>'
      render template: 'clients', model: [clients: linking.results, activity: linking.target, entity: entityHelperService.loggedIn]
    }
    // if the entity is a client group get all clients and add them
    else if (clientgroup.type.id == metaDataService.etGroupClient.id) {
      // find all clients of the group
      List clients = functionService.findAllByLink(null, clientgroup, metaDataService.ltGroupMemberClient)

      clients.each { Entity client ->
        def linking = functionService.linkEntities(client.id.toString(), params.id, metaDataService.ltActClient)
        if (linking.duplicate)
          render '<div class="red italic">"' + linking.source.profile.fullName + '" ' + message(code: "alreadyAssignedTo") + '</div>'
      }

      List clients2 = functionService.findAllByLink(null, activity, metaDataService.ltActClient)
      render template: 'clients', model: [clients: clients2, activity: activity, entity: entityHelperService.loggedIn]
    }
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
        render '<span class="red italic">"' + linking.target.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
      render template: 'facilities', model: [facilities: linking.results2, activity: linking.source, entity: entityHelperService.loggedIn]
    }
    else {
      List facilities = functionService.findAllByLink(group, null, metaDataService.ltActFacility)
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

  Date mondayStart
  Date tuesdayStart
  Date wednesdayStart
  Date thursdayStart
  Date fridayStart
  Date saturdayStart
  Date sundayStart

  Date mondayEnd
  Date tuesdayEnd
  Date wednesdayEnd
  Date thursdayEnd
  Date fridayEnd
  Date saturdayEnd
  Date sundayEnd

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

  static constraints = {
    fullName      blank: false
    periodStart   nullable: false
    facility      nullable: false
    educators     nullable: false
    periodEnd     nullable: false, validator: {pe, ac ->
                    return pe >= ac.periodStart
                  }
    mondayEnd     nullable: true, validator: {pe, ac ->
                    return pe >= ac.mondayStart
                  }
    tuesdayEnd    nullable: true, validator: {pe, ac ->
                    return pe >= ac.tuesdayStart
                  }
    wednesdayEnd  nullable: true, validator: {pe, ac ->
                    return pe >= ac.wednesdayStart
                  }
    thursdayEnd   nullable: true, validator: {pe, ac ->
                    return pe >= ac.thursdayStart
                  }
    fridayEnd     nullable: true, validator: {pe, ac ->
                    return pe >= ac.fridayStart
                  }
    saturdayEnd   nullable: true, validator: {pe, ac ->
                    return pe >= ac.saturdayStart
                  }
    sundayEnd     nullable: true, validator: {pe, ac ->
                    return pe >= ac.sundayStart
                  }
    weekdays      validator: {wd, pc ->
                    return !(!pc.monday && !pc.tuesday && !pc.wednesday && !pc.thursday && !pc.friday && !pc.saturday && !pc.sunday)
                  }
  }

}