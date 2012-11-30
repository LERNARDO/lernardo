package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.Materials
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.CDate
import at.uenterprise.erp.Performances
import at.uenterprise.erp.Healths
import at.uenterprise.erp.base.EntityException
import at.uenterprise.erp.Collector
import at.uenterprise.erp.Contact
import at.uenterprise.erp.SDate
import at.uenterprise.erp.logbook.Attendance
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType
import at.uenterprise.erp.Setup
import at.uenterprise.erp.EntityDataService
import at.uenterprise.erp.LinkDataService

class ClientProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService
  EntityDataService entityDataService
  LinkDataService linkDataService

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = {
    redirect action: "list", params: params
  }

  def list = {
    int totalClients = Entity.countByType(metaDataService.etClient)
    List colonies = Entity.findAllByType(metaDataService.etGroupColony)
    List facilities = Entity.findAllByType(metaDataService.etFacility)
    List schoolLevels = Setup.list()[0]?.schoolLevels

    return [totalClients: totalClients, colonies: colonies, facilities: facilities, schoolLevels: schoolLevels]
  }

  def show = {
    Entity client = Entity.get(params.id)

    if (!client) {
      flash.message = message(code: "object.notFound", args: [message(code: "client")])
      redirect(action: list)
      return
    }

    Entity colony = linkDataService.getColony(client)
    Entity family = linkDataService.getFamily(client)
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    return [client: client, colony: colony, family: family, facilities: facilities, ajax: params.ajax]

  }

    def management = {
        Entity client = Entity.get(params.id)

        List pates = functionService.findAllByLink(client, null,  metaDataService.ltPate)
        List facilities = functionService.findAllByLink(client, null, metaDataService.ltGroupMemberClient).findAll {it.type == metaDataService.etFacility}

        render template: "management", model: [client: client, pates: pates, facilities: facilities]
    }

  def delete = {
    Entity client = Entity.get(params.id)
    if (client) {
      functionService.deleteReferences(client)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "client"), client.profile])
        client.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "client"), client.profile])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "client")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity client = Entity.get(params.id)

    if (!client) {
      flash.message = message(code: "object.notFound", args: [message(code: "client")])
      redirect action: 'list'
      return
    }

    Entity colony = linkDataService.getColony(client)

    def allColonies = entityDataService.getAllColonies()
    def allFacilities = entityDataService.getAllFacilities()

    return [client: client,
            colony: colony,
            allColonies: allColonies,
            allFacilities: allFacilities]
  }

  def update = {
    params.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
    //params.schoolDropoutDate = params.date('schoolDropoutDate', 'dd. MM. yy') ?: params.date('schoolDropoutDate', 'dd.MM.yy')
    //params.schoolRestartDate = params.date('schoolRestartDate', 'dd. MM. yy') ?: params.date('schoolRestartDate', 'dd.MM.yy')

    Entity client = Entity.get(params.id)

    client.profile.properties = params
    client.profile.fullName = params.lastName + " " + params.firstName
    client.user.properties = params

    // update link to colony
    Link.findByTargetAndType(client, metaDataService.ltColonia)?.delete()
    if (params.currentColony) {
        new Link(source: Entity.get(params.currentColony), target: client, type: metaDataService.ltColonia).save()
    }

    // update link to school
    //Link.findByTargetAndType(client, metaDataService.ltFacility)?.delete()
    //new Link(source: Entity.get(params.school), target: client, type: metaDataService.ltFacility).save()

    if (client.profile.save() && client.user.save() && client.save()) {
      flash.message = message(code: "object.updated", args: [message(code: "client"), client.profile])
      redirect action: 'show', id: client.id
    }
    else {
      Entity colony = linkDataService.getColony(client)

      def allColonies = entityDataService.getAllColonies()
      def allFacilities = entityDataService.getAllFacilities()

      render view: 'edit', model: [client: client, colony: colony, allColonies: allColonies, allFacilities: allFacilities]
    }
  }

  def create = {
    def allColonies = entityDataService.getAllColonies()
    def allFacilities = entityDataService.getAllFacilities()

    return [allColonies: allColonies,
            allFacilities: allFacilities]
  }

  def save = {
    EntityType etClient = metaDataService.etClient

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etClient, params.email, params.lastName + " " + params.firstName) {Entity ent ->
        ent.profile.properties = params
        ent.user.properties = params
        ent.profile.birthDate = params.date('birthDate', 'dd. MM. yy') ?: params.date('birthDate', 'dd.MM.yy')
        //ent.profile.schoolDropoutDate = params.date('schoolDropoutDate', 'dd. MM. yy') ?: params.date('schoolDropoutDate', 'dd.MM.yy')
        //ent.profile.schoolRestartDate = params.date('schoolRestartDate', 'dd. MM. yy') ?: params.date('schoolRestartDate', 'dd.MM.yy')
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save()
      }

      // create link to colony
      if (params.currentColony)
        new Link(source: Entity.get(params.currentColony), target: entity, type: metaDataService.ltColonia).save()

      // create link to school
      //new Link(source: Entity.get(params.school), target: entity, type: metaDataService.ltFacility).save()

      // create entry date
        params.entryDate = params.date('entryDate', 'dd. MM. yy') ?: params.date('entryDate', 'dd.MM.yy')

        CDate date = new CDate()
        date.date = params.entryDate
        date.type = 'entry'
        entity.profile.addToDates(date)

        // change active/inactive status
        functionService.updateSingleStatus(entity)

      flash.message = message(code: "object.created", args: [message(code: "client"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (EntityException ee) {
      def allColonies = entityDataService.getAllColonies()
      def allFacilities = entityDataService.getAllFacilities()

      render view: "create", model: [client: ee.entity, allColonies: allColonies, allFacilities: allFacilities]
    }
  }

  def addPerformance = {
    Performances performance = new Performances(params)
    Entity client = Entity.get(params.id)
    client.profile.addToPerformances(performance)
    render template: 'performances', model: [client: client]
  }

  def removePerformance = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromPerformances(Performances.get(params.performance))
    render template: 'performances', model: [client: client]
  }

  def addHealth = {
    Healths health = new Healths(params)
    Entity client = Entity.get(params.id)
    client.profile.addToHealths(health)
    render template: 'healths', model: [client: client]
  }

  def removeHealth = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromHealths(Healths.get(params.health))
    render template: 'healths', model: [client: client]
  }

  def addMaterial = {
    Materials material = new Materials(params)
    Entity client = Entity.get(params.id)
    client.profile.addToMaterials(material)
    render template: 'materials', model: [client: client]
  }

  def removeMaterial = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromMaterials(Materials.get(params.material))
    render template: 'materials', model: [client: client]
  }

  def addDate = {
    Entity client = Entity.get(params.id)

    params.date = params.date('date', 'dd. MM. yy') ?: params.date('date', 'dd.MM.yy')

    if (params.date) {
      CDate date = new CDate(params)
      date.type = client.profile.dates.size() % 2 == 0 ? 'entry' : 'exit'
      client.profile.addToDates(date)

      // change active/inactive status
      functionService.updateSingleStatus(client)
    }
    render template: 'dates', model: [client: client]
  }

  def removeDate = {
    Entity client = Entity.get(params.id)
    CDate date = CDate.get(params.date)
    client.profile.removeFromDates(date)

    // change active/inactive status
    functionService.updateSingleStatus(client)

    render template: 'dates', model: [client: client]
  }

  def addCollector = {
    Collector collector = new Collector(params)
    Entity client = Entity.get(params.id)
    client.profile.addToCollectors(collector)
    render template: 'collectors', model: [client: client]
  }

  def removeCollector = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromCollectors(Collector.get(params.collector))
    render template: 'collectors', model: [client: client]
  }

  def addContact = {ContactCommand cc ->
    Entity client = Entity.get(params.id)
    if (cc.hasErrors()) {
      render {p(class: 'italic red', message(code: 'client.profile.name.insert'))}
      render template: 'contacts', model: [client: client]
      return
    }
    Contact contact = new Contact(params)
    client.profile.addToContacts(contact)

    List facilities = functionService.findAllByLink(client, null, metaDataService.ltGroupMemberClient).findAll {it.type == metaDataService.etFacility}

    render template: 'contacts', model: [client: client, facilities: facilities]
  }

  def removeContact = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromContacts(Contact.get(params.contact))
    Contact.get(params.contact).delete()

    List facilities = functionService.findAllByLink(client, null, metaDataService.ltGroupMemberClient).findAll {it.type == metaDataService.etFacility}

    render template: 'contacts', model: [client: client, facilities: facilities]
  }

  def addSchoolDate = {
    Entity client = Entity.get(params.id)

    params.date = params.date('date', 'dd. MM. yy') ?: params.date('date', 'dd.MM.yy')

    if (params.date) {
      SDate date = new SDate(params)
      date.type = client.profile.schooldates.size() % 2 == 0 ? 'entry' : 'exit'
      client.profile.addToSchooldates(date)

      // change active/inactive status
      client.user.enabled = date.type == 'exit'
      client.user.save()
    }
    render template: 'schooldates', model: [client: client]
  }

  def removeSchoolDate = {
    Entity client = Entity.get(params.id)
    SDate date = SDate.get(params.date)
    client.profile.removeFromSchooldates(date)

    // change active/inactive status
    client.user.enabled = date.type == 'exit'
    client.user.save()

    render template: 'schooldates', model: [client: client]
  }

  /*
  * retrieves all facilities matching the search parameter
  */
  def remoteFacilities = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().list {
      eq('type', metaDataService.etFacility)
      profile {
        ilike('fullName', "%" + params.value + "%")
        order('fullName','asc')
      }
      maxResults(15)
    }

    if (results.size() == 0) {
      render {span(class: 'italic', message(code: 'noResultsFound'))}
      return
    }
    else {
      render template: 'facilityresults', model: [results: results, client: params.id]
    }
  }

  def addFacility = {
    Entity facility = Entity.get(params.facility)
    Entity client = Entity.get(params.id)

    def linking = functionService.linkEntities(params.id, params.facility, metaDataService.ltGroupMemberClient)
    if (linking.duplicate)
      render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
    else
      new Attendance(client: client, facility: facility).save(failOnError: true)

    List facilities = functionService.findAllByLink(client, null, metaDataService.ltGroupMemberClient).findAll {it.type == metaDataService.etFacility}

    render template: 'facilities', model: [facilities: facilities, client: linking.source]
  }

  def removeFacility = {
    Entity facility = Entity.get(params.facility)
    Entity client = Entity.get(params.id)

    def link = Link.createCriteria().get {
      eq('source', client)
      eq('target', facility)
      eq('type', metaDataService.ltGroupMemberClient)
    }
    link?.delete()

    Attendance.findByClientAndFacility(client, facility)?.delete()

    // find all facilities of this client
    List facilities = functionService.findAllByLink(client, null, metaDataService.ltGroupMemberClient).findAll {it.type == metaDataService.etFacility}

    render template: 'facilities', model: [facilities: facilities, client: client]
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    Date birthDateFrom = params.date('birthDateFrom', 'dd. MM. yy')
    Date birthDateTo = params.date('birthDateTo', 'dd. MM. yy')

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().listDistinct  {
      eq('type', metaDataService.etClient)
      user {
        eq('enabled', params.active ? true : false)
      }
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        if (params.gender != "0")
          eq('gender', params.int('gender'))
        if (birthDateFrom)
          ge("birthDate", birthDateFrom)
        if (birthDateTo)
          le("birthDate", birthDateTo)
        if (params.school)
          ilike('school', "%" + params.school + "%")
        if (params.schoolLevel)
          eq('schoolLevel', params.schoolLevel)
        order(params.sort, params.order)
      }
    }

    // 2. pass - filter by colony
    if (params.colony != "") {
      results = results.findAll { Entity entity ->
        Link.createCriteria().get {
          eq('source', Entity.get(params.colony))
          eq('target', entity)
          eq('type', metaDataService.ltColonia)
        }
      }
    }

    // 3. pass - filter by facility
    if (params.facility != "") {
      results = results.findAll { Entity entity ->
        Link.createCriteria().get {
          eq('source', entity)
          eq('target', Entity.get(params.facility))
          eq('type', metaDataService.ltGroupMemberClient)
        }
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'client', params: params]
  }

}
