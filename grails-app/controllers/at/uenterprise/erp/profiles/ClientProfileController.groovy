package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.Materials
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.CDate
import at.uenterprise.erp.Performances
import at.uenterprise.erp.Healths
import at.openfactory.ep.EntityException
import at.uenterprise.erp.Msg
import at.uenterprise.erp.Event
import at.uenterprise.erp.Post
import at.uenterprise.erp.Publication
import at.uenterprise.erp.Collector
import at.uenterprise.erp.Contact
import java.util.regex.Pattern
import at.uenterprise.erp.ECalendar
import at.uenterprise.erp.Comment
import at.uenterprise.erp.Evaluation

class ClientProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService

  /*
  def beforeInterceptor = [
          action:{
            params.date = params.date ? Date.parse("dd. MM. yy", params.date) : null
            params.schoolDropoutDate = params.schoolDropoutDate ? Date.parse("dd. MM. yy", params.schoolDropoutDate) : null
            params.schoolRestartDate = params.schoolRestartDate ? Date.parse("dd. MM. yy", params.schoolRestartDate) : null
            },
            only:['save','update','addDate']
  ]
   */

  def index = {
    redirect action: "list", params: params
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def list = {
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def clients = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etClient)
      profile {
        order(params.sort, params.order)
      }
    }

    return [clients: clients]
  }

  def show = {
    Entity client = Entity.get(params.id)
    Entity entity = params.entity ? client : entityHelperService.loggedIn

    if (!client) {
      //flash.message = "ClientProfile not found with id ${params.id}"
      flash.message = message(code: "client.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    Entity colonia = functionService.findByLink(null, client, metaDataService.ltColonia)
    //Entity school = functionService.findByLink(null, client, metaDataService.ltFacility)
    Entity family = functionService.findByLink(client, null, metaDataService.ltGroupFamily)
    List pates = functionService.findAllByLink(client, null,  metaDataService.ltPate)

    return [client: client, entity: entity, colonia: colonia, family: family, pates: pates]

  }

  def delete = {
    Entity client = Entity.get(params.id)
    if (client) {
      // delete all links
      Link.findAllBySourceOrTarget(client, client).each {it.delete()}
      Msg.findAllBySenderOrReceiver(client, client).each {it.delete()}
      Event.findAllByEntity(client).each {it.delete()}
      Post.findAllByAuthor(client).each {it.delete()}
      Publication.findAllByEntity(client).each {it.delete()}
      Evaluation.findByOwnerOrWriter(client, client).each {it.delete()}
      Comment.findAllByCreator(client.id.toInteger()).each { Comment comment ->
          // find the profile the comment belongs to and delete it from there
          def c = Entity.createCriteria()
          List entities = c.list {
              or {
                eq("type", metaDataService.etActivity)
                eq("type", metaDataService.etGroupActivity)
                eq("type", metaDataService.etGroupActivityTemplate)
                eq("type", metaDataService.etProject)
                eq("type", metaDataService.etProjectTemplate)
                eq("type", metaDataService.etTemplate)
              }
          }
          entities.each { Entity entity ->
              Comment profileComment = entity?.profile?.comments?.find {it.id == comment.id} as Comment
              if (profileComment)
                entity.profile.removeFromComments(profileComment)
          }
      }
      try {
        flash.message = message(code: "client.deleted", args: [client.profile.fullName])
        client.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "client.notDeleted", args: [client.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      // flash.message = "ClientProfile not found with id ${params.id}"
      flash.message = message(code: "client.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    Entity client = Entity.get(params.id)

    if (!client) {
      // flash.message = "ClientProfile not found with id ${params.id}"
      flash.message = message(code: "client.idNotFound", args: [params.id])
      redirect action: 'list'
      return
    }

    Entity colonia = functionService.findByLink(null, client, metaDataService.ltColonia)
    //Entity school = functionService.findByLink(null, client, metaDataService.ltFacility)

    def c = Entity.createCriteria()
    def allColonies = c.list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    def d = Entity.createCriteria()
    def allFacilities = d.list {
      eq("type", metaDataService.etFacility)
      profile {
        order(params.sort, params.order)
      }
    }

    return [client: client,
            colonia: colonia,
            allColonies: allColonies,
            allFacilities: allFacilities,
            //school: school
            ]
  }

  def update = {
    if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
      params.birthDate = Date.parse("dd. MM. yy", params.birthDate)
    else
      params.birthDate = null

    if ( params.schoolDropoutDate ) {
      if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.schoolDropoutDate))
        params.schoolDropoutDate = Date.parse("dd. MM. yy", params.schoolDropoutDate)
      else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.schoolDropoutDate))
        params.schoolDropoutDate = Date.parse("dd.MM.yy", params.schoolDropoutDate)
    }

    if ( params.schoolRestartDate ) {
      if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.schoolRestartDate))
        params.schoolRestartDate = Date.parse("dd. MM. yy", params.schoolRestartDate)
      else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.schoolRestartDate))
        params.schoolRestartDate = Date.parse("dd.MM.yy", params.schoolRestartDate)
    }

    Entity client = Entity.get(params.id)

    client.profile.properties = params
//    client.profile.birthDate = functionService.convertToUTC(client.profile.birthDate)
//    if (client.profile.schoolDropoutDate)
//        client.profile.schoolDropoutDate = functionService.convertToUTC(client.profile.schoolDropoutDate)
//    if (client.profile.schoolRestartDate)
//        client.profile.schoolRestartDate = functionService.convertToUTC(client.profile.schoolRestartDate)
    client.profile.fullName = params.lastName + " " + params.firstName
    if (!client.profile.calendar) client.profile.calendar = new ECalendar().save()

    client.user.properties = params
    if (client.id == entityHelperService.loggedIn.id)
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, client.user.locale)

    // update link to colonia
    Link.findByTargetAndType(client, metaDataService.ltColonia)?.delete()
    new Link(source: Entity.get(params.currentColonia), target: client, type: metaDataService.ltColonia).save()

    // update link to school
    //Link.findByTargetAndType(client, metaDataService.ltFacility)?.delete()
    //new Link(source: Entity.get(params.school), target: client, type: metaDataService.ltFacility).save()

    if (client.profile.save() && client.user.save() && client.save()) {
      flash.message = message(code: "client.updated", args: [client.profile.fullName])
      redirect action: 'show', id: client.id, params: [entity: client.id]
    }
    else {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"
      Entity colonia = functionService.findByLink(null, client, metaDataService.ltColonia)
      //Entity school = functionService.findByLink(null, client, metaDataService.ltFacility)

      def c = Entity.createCriteria()
      def allColonies = c.list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }

      def d = Entity.createCriteria()
      def allFacilities = d.list {
        eq("type", metaDataService.etFacility)
        profile {
          order(params.sort, params.order)
        }
      }
      render view: 'edit', model: [client: client, colonia: colonia, allColonies: allColonies, allFacilities: allFacilities, school: school]
    }
  }

  def create = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def allColonies = c.list {
      eq("type", metaDataService.etGroupColony)
      profile {
        order(params.sort, params.order)
      }
    }

    def d = Entity.createCriteria()
    def allFacilities = d.list {
      eq("type", metaDataService.etFacility)
      profile {
        order(params.sort, params.order)
      }
    }

    return [allColonies: allColonies,
            allFacilities: allFacilities]
  }

  def save = {
    EntityType etClient = metaDataService.etClient

    try {
      Entity entity = entityHelperService.createEntityWithUserAndProfile(functionService.createNick(params.firstName, params.lastName), etClient, params.email, params.lastName + " " + params.firstName) {Entity ent ->

        ent.profile.properties = params
        ent.user.properties = params
        if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd. MM. yy", params.birthDate)
        else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.birthDate))
          ent.profile.birthDate = Date.parse("dd.MM.yy", params.birthDate)
        ent.user.password = securityManager.encodePassword(grailsApplication.config.defaultpass)
        ent.profile.calendar = new ECalendar().save()
        // ent.profile.birthDate = functionService.convertToUTC(ent.profile.birthDate)
        if ( params.schoolDropoutDate ) {
          if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.schoolDropoutDate))
            ent.profile.schoolDropoutDate = Date.parse("dd. MM. yy", params.schoolDropoutDate)
          else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.schoolDropoutDate))
            ent.profile.schoolDropoutDate = Date.parse("dd.MM.yy", params.schoolDropoutDate)
        }
//        if (ent.profile.schoolDropoutDate)
//            ent.profile.schoolDropoutDate = functionService.convertToUTC(ent.profile.schoolDropoutDate)

        if ( params.schoolRestartDate ) {
          if (Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.schoolRestartDate))
            ent.profile.schoolRestartDate = Date.parse("dd. MM. yy", params.schoolRestartDate)
          else if (Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.schoolRestartDate))
            ent.profile.schoolRestartDate = Date.parse("dd.MM.yy", params.schoolRestartDate)
        }
        //if (ent.profile.schoolRestartDate)
        //    ent.profile.schoolRestartDate = functionService.convertToUTC(ent.profile.schoolRestartDate)
      }
      //RequestContextUtils.getLocaleResolver(request).setLocale(request, response, entity.user.locale)

      // create link to colonia
      new Link(source: Entity.get(params.currentColonia), target: entity, type: metaDataService.ltColonia).save()

      // create link to school
      //new Link(source: Entity.get(params.school), target: entity, type: metaDataService.ltFacility).save()

      flash.message = message(code: "client.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (EntityException ee) {
      params.sort = params.sort ?: "fullName"
      params.order = params.order ?: "asc"

      def c = Entity.createCriteria()
      def allColonies = c.list {
        eq("type", metaDataService.etGroupColony)
        profile {
          order(params.sort, params.order)
        }
      }

      def d = Entity.createCriteria()
      def allFacilities = d.list {
        eq("type", metaDataService.etFacility)
        profile {
          order(params.sort, params.order)
        }
      }

      render(view: "create", model: [client: ee.entity, allColonies: allColonies, allFacilities: allFacilities])
    }
  }

  def addPerformance = {
    Performances performance = new Performances(params)
    //performance.date = functionService.convertToUTC(performance.date)
    Entity client = Entity.get(params.id)
    client.profile.addToPerformances(performance)
    render template: 'performances', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def removePerformance = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromPerformances(Performances.get(params.performance))
    render template: 'performances', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def addHealth = {
    Healths health = new Healths(params)
    // health.date = functionService.convertToUTC(health.date)
    Entity client = Entity.get(params.id)
    client.profile.addToHealths(health)
    render template: 'healths', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def removeHealth = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromHealths(Healths.get(params.health))
    render template: 'healths', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def addMaterial = {
    Materials material = new Materials(params)
    // material.date = functionService.convertToUTC(material.date)
    Entity client = Entity.get(params.id)
    client.profile.addToMaterials(material)
    render template: 'materials', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def removeMaterial = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromMaterials(Materials.get(params.material))
    render template: 'materials', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def addDate = {
    Entity client = Entity.get(params.id)

    if (params.date && Pattern.matches( "\\d{2}\\.\\s\\d{2}\\.\\s\\d{4}", params.date))
      params.date = Date.parse("dd. MM. yy", params.date)
    else if (params.date && Pattern.matches( "\\d{2}\\.\\d{2}\\.\\d{4}", params.date))
      params.date = Date.parse("dd.MM.yy", params.date)
    else
      params.date = null

    if ( params.date ) {
      CDate date = new CDate(params)
      // date.date = functionService.convertToUTC(date.date)
      date.type = client.profile.dates.size() % 2 == 0 ? 'entry' : 'exit'
      client.profile.addToDates(date)
    }
    render template: 'dates', model: [client: client, entity: entityHelperService.loggedIn]
  }

  def removeDate = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromDates(CDate.get(params.date))
    render template: 'dates', model: [client: client, entity: entityHelperService.loggedIn]
  }

  def addCollector = {
    Collector collector = new Collector(params)
    Entity client = Entity.get(params.id)
    client.profile.addToCollectors(collector)
    render template: 'collectors', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def removeCollector = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromCollectors(Collector.get(params.collector))
    render template: 'collectors', model: [client: client, currentEntity: entityHelperService.loggedIn]
  }

  def addContact = {ContactCommand cc ->
    Entity client = Entity.get(params.id)
    if (cc.hasErrors()) {
      // render '<p class="italic red">Bitte Vor- und Nachname angeben!</p>'
      render '<p class="italic red">'+message(code: "client.profile.name.insert")+'</p>'
      render template: 'contacts', model: [client: client, entity: entityHelperService.loggedIn]
      return
    }
    Contact contact = new Contact(params)
    client.profile.addToContacts(contact)
    render template: 'contacts', model: [client: client, entity: entityHelperService.loggedIn]
  }

  def removeContact = {
    Entity client = Entity.get(params.id)
    client.profile.removeFromContacts(Contact.get(params.contact))
    Contact.get(params.contact).delete()
    render template: 'contacts', model: [client: client, entity: entityHelperService.loggedIn]
  }
}
