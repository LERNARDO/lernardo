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
            params.mondayStart = params.date('mondayStart', 'HH:mm')
            params.mondayEnd = params.date('mondayEnd', 'HH:mm')
            params.tuesdayStart = params.date('tuesdayStart', 'HH:mm')
            params.tuesdayEnd = params.date('tuesdayEnd', 'HH:mm')
            params.wednesdayStart = params.date('wednesdayStart', 'HH:mm')
            params.wednesdayEnd = params.date('wednesdayEnd', 'HH:mm')
            params.thursdayStart = params.date('thursdayStart', 'HH:mm')
            params.thursdayEnd = params.date('thursdayEnd', 'HH:mm')
            params.fridayStart = params.date('fridayStart', 'HH:mm')
            params.fridayEnd = params.date('fridayEnd', 'HH:mm')
            params.saturdayStart = params.date('saturdayStart', 'HH:mm')
            params.saturdayEnd = params.date('saturdayEnd', 'HH:mm')
            params.sundayStart = params.date('sundayStart', 'HH:mm')
            params.sundayEnd = params.date('sundayEnd', 'HH:mm')

            params.periodStart = params.date('periodStart', 'dd. MM. yy')
            params.periodEnd = params.date('periodEnd', 'dd. MM. yy')
            params.date = params.date('date', 'dd. MM. yy, HH:mm')},
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
    params.offset = params.int('offset') ?: 0
    params.max = params.int('max') ?: 10
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
      Date inputDate = params.date('myDate', 'dd. MM. yy')

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

    List allFacilities = Entity.findAllByType(metaDataService.etFacility)

    return [activity: activity,
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
      render view: 'create', model:['ac':ac]
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

        // create links to clients
        params.list('clients').each {
          Entity client = Entity.get(it)
          new Link(source: client, target: entity, type: metaDataService.ltActClient).save()
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

    if (activity) {
      functionService.deleteReferences(activity)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "activity"), activity.profile.fullName])
        activity.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "activity"), activity.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "activity")])
      redirect(action: "list")
    }
  }

  def addClientOld = {
    ClientEvaluation clientEvaluation = new ClientEvaluation(params)
    Entity activity = Entity.get(params.id)

    activity.profile.addToClientEvaluations(clientEvaluation)
    render template: 'clientsOLD', model: [activity: activity]
  }

  def removeClientOld = {
    Entity activity = Entity.get(params.id)
    activity.profile.removeFromClientEvaluations(ClientEvaluation.get(params.clientEvaluation))
    render template: 'clientsOLD', model: [activity: activity]
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
      //or {
        //ilike('name', "%" + params.value + "%")
        profile {
          ilike('fullName', "%" + params.value + "%")
        }
      //}
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
    
    Entity currentEntity = entityHelperService.loggedIn
    List results
    if (currentEntity.type.id == metaDataService.etEducator.id) {
      results = functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking)
      results.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator))
      results = results.findAll {it.profile.fullName.contains(params.value)}
    }
    else {
      def c = Entity.createCriteria()
      results = c.list {
        eq('type', metaDataService.etFacility)
        or {
          ilike('name', "%" + params.value + "%")
          profile {
            ilike('fullName', "%" + params.value + "%")
          }
        }
        maxResults(15)
      }
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
      user {
        eq("enabled", true)
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
      render(template: 'educatorresults', model: [results: results, activity: params.id])
    }
  }

  /*
   * retrieves all clients matching the search parameter
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

    def msg = message(code: "facility.profile.selected")
    render ("<b>${msg}</b> ${facility.profile.fullName}")
  }

  def addEducator = {
    def linking = functionService.linkEntities(params.educator, params.id, metaDataService.ltActEducator)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName+'" '+message(code: "alreadyAssignedTo")+'</span>'
    render template: 'educators', model: [educators: linking.results, activity: linking.target]
  }

  def removeEducator = {
    def breaking = functionService.breakEntities(params.educator, params.id, metaDataService.ltActEducator)
    render template: 'educators', model: [educators: breaking.results, activity: breaking.target]
  }

  def addClient = {
    /*def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltActClient)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</span>'

    render template: 'clients', model: [clients: linking.results, activity: linking.target]*/

    Entity activity = Entity.get(params.id)
    Entity clientgroup = Entity.get(params.client)

    // if the entity is a client add it
    if (clientgroup.type.id == metaDataService.etClient.id) {
      def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltActClient)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" ' + message(code: "alreadyAssignedTo") + '</span>'
      render template: 'clients', model: [clients: linking.results, activity: linking.target]
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
      render template: 'clients', model: [clients: clients2, activity: activity]
    }
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltActClient)
    render template: 'clients', model: [clients: breaking.results, activity: breaking.target]
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
    render template: 'educatorsFound', model:[educators: educators, currentEntity: entityHelperService.loggedIn]
  }

  def updateClients = {
    Entity facility = Entity.get(params.id)

    // find all clients linked to this facility
    def c = Link.createCriteria()
    List clients = c.list {
      eq('target', facility)
      eq('type', metaDataService.ltGroupMemberClient)
      projections {
        distinct('source')
      }
    }
    render template: 'clientsFound', model:[clients: clients, currentEntity: entityHelperService.loggedIn]
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
      render template: 'facilities', model: [facilities: linking.results2, activity: linking.source]
    }
    else {
      List facilities = functionService.findAllByLink(group, null, metaDataService.ltActFacility)
      render '<span class="red italic">' +message(code: "alreadyAssignedToFacility")+'</span>'
      render template: 'facilities', model: [facilities: facilities, activity: group]
    }

  }

  def removeFacility = {
    def breaking = functionService.breakEntities(params.id, params.facility, metaDataService.ltActFacility)
    render template: 'facilities', model: [facilities: breaking.results2, group: breaking.source]
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
  String clients

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
    clients       nullable: false
    periodEnd     nullable: false, validator: {val, obj ->
                    return val >= obj.periodStart
                  }
    mondayEnd     nullable: true, validator: {val, obj ->
                    return val >= obj.mondayStart
                  }
    tuesdayEnd    nullable: true, validator: {val, obj ->
                    return val >= obj.tuesdayStart
                  }
    wednesdayEnd  nullable: true, validator: {val, obj ->
                    return val >= obj.wednesdayStart
                  }
    thursdayEnd   nullable: true, validator: {val, obj ->
                    return val >= obj.thursdayStart
                  }
    fridayEnd     nullable: true, validator: {val, obj ->
                    return val >= obj.fridayStart
                  }
    saturdayEnd   nullable: true, validator: {val, obj ->
                    return val >= obj.saturdayStart
                  }
    sundayEnd     nullable: true, validator: {val, obj ->
                    return val >= obj.sundayStart
                  }
    /*
    // removed since 2.0.1 as this boolean check is suddenly broken, FIXME
    weekdays      validator: {val, obj ->
                    return !(!obj.monday && !obj.tuesday && !obj.wednesday && !obj.thursday && !obj.friday && !obj.saturday && !obj.sunday)
                  }*/
  }

}