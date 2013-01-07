package at.uenterprise.erp

import at.uenterprise.erp.base.Entity

import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.LinkType
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.web.multipart.MultipartFile
import at.uenterprise.erp.base.util.HashTools
import at.uenterprise.erp.base.AssetStorage
import at.uenterprise.erp.base.Asset
import at.uenterprise.erp.base.AssetService
import java.text.NumberFormat
import java.text.DecimalFormat

/**
 * This class contains all used service methods
 *
 * @author  Alexander Zeillinger
 */
class FunctionService {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  GrailsApplication grailsApplication
  AssetService assetService

  boolean transactional = true

    List getFolders(Folder f) {
        List folders = []
        f.folders.each {
            List temp = getFolders(it)
            folders.addAll(temp)
            folders.add(it)
        }
        return folders
    }

    /**
     * Updates the status of all educators, clients, pates and parents
     *
     * @author Alexander Zeillinger
     */
    def updateStatus() {
        Date currentDate = new Date()

        List users = Entity.findAllByType(metaDataService.etClient)
        users.addAll(Entity.findAllByType(metaDataService.etEducator))
        users.addAll(Entity.findAllByType(metaDataService.etPate))
        users.addAll(Entity.findAllByType(metaDataService.etParent))

        users?.each { Entity entity ->
            def dates = entity.profile.dates
            dates?.toList()?.reverse()

            //dates?.each {println it.date}
            //println "--"

            for(CDate date : dates) { // this may need some tweaking depending on types
                if (date.date < currentDate) {
                    entity.user.enabled = date.type == 'entry'
                    entity.user.save()
                    break
                }
            }
        }
    }

    /**
     * Updates the status of a single entity
     *
     * @author Alexander Zeillinger
     * @param entity REQUIRED An entity to update the status of
     */
    def updateSingleStatus(Entity entity) {
        Date currentDate = new Date()

        def dates = entity.profile.dates
        dates?.toList()?.reverse()

        //dates?.each {println it.date}
        //println "--"

        for(CDate date : dates) { // this may need some tweaking depending on types
            if (date.date < currentDate) {
                entity.user.enabled = date.type == 'entry'
                entity.user.save()
                break
            }
        }

        /*dates.each { Date date ->
            if (date.date < currentDate) {
                entity.user.enabled = date.type == 'exit'
                entity.user.save()
                return
            }
        }*/

    }

  /**
   * Calculates the duration of a list of project units based on each units group activity templates durations
   *
   * @author Alexander Zeillinger
   * @param projectUnits REQUIRED The project units to calculate the duration from
   */
  int calculateDurationPU(List projectUnits) {
    // find all groupActivityTemplates linked to all projectUnits of this project
    List groupActivityTemplates = []

    projectUnits.each { Entity pu ->
      def links = findAllByLink(null, pu, metaDataService.ltProjectUnitMember)
      if (links.size() > 0)
        groupActivityTemplates.addAll(links)
    }

    def calculatedDuration = 0
    groupActivityTemplates.each {
      calculatedDuration += it.profile.realDuration
    }

    return calculatedDuration
  }

  /**
   * Calculates the duration of a list of project unit templates based on each units activity template durations
   *
   * @author Alexander Zeillinger
   * @param projectUnitTemplates REQUIRED The project unit templates to calculate the duration from
   */
  int calculateDurationPUT(List projectUnitTemplates) {
    List activityTemplates = []

    projectUnitTemplates.each { Entity put ->
      List ats = findAllByLink(null, put, metaDataService.ltGroupMember)
        if (ats.size() > 0)
          activityTemplates.addAll(ats)
    }

    int calculatedDuration = activityTemplates*.profile.duration.sum(0)

    return calculatedDuration
  }

  /**
   * Finds a link matching all 3 parameters
   *
   * @author Alexander Zeillinger
   * @param source REQUIRED The source entity
   * @param target REQUIRED The target entity
   * @param type REQUIRED The link type
   */
  Link findExactLink(Entity source, Entity target, LinkType type) {
    def link = Link.createCriteria().get {
      eq('source', source)
      eq('target', target)
      eq('type', type)
    }
    return link
  }

  /**
   * Creates a default calendar object
   *
   * @author Alexander Zeillinger
   * @param entity REQUIRED The entity to to create the calendar for
   */
  ECalendar createDefaultCalendar(Entity entity) {
    ECalendar eCalendar = new ECalendar()
    CalEntity self = new CalEntity(entity: entity, visible: true, color: '#cccccc').save()
    eCalendar.addToEntities(self)
    eCalendar.save()
    return eCalendar
  }
  
  /**
   * Retrieves all labels in the order they are stored in the static labels property of the Labels class
   *
   * @author Alexander Zeillinger
   */
  List getLabels() {
    List labels = []
    Setup.list()[0].labels.each {
      labels.add(Label.get(it.toInteger()))
    }
    return labels
  }

  /**
   * Deletes all references to an entity (used before deleting an entity)
   *
   * @author Alexander Zeillinger
   * @param entity REQUIRED The entity to delete all links to and from
   */
  def deleteReferences(Entity entity) {
    Link.findAllBySourceOrTarget(entity, entity).each {it.delete()}
    Event.findAllByWhoOrWhat(entity.id.toInteger(), entity.id.toInteger()).each {it.delete()}
    Msg.findAllBySender(entity).each {it.delete()}
    def messages = Msg.createCriteria().list {
       receivers {
          idEq(entity.id)
       }
    }
    messages?.each {it.delete()}
    Publication.findAllByEntity(entity).each {it.delete()}
    Evaluation.findByOwnerOrWriter(entity, entity).each {it.delete()}
    News.findAllByAuthor(entity).each {it.delete()}

    Comment.findAllByCreator(entity.id.toInteger()).each { Comment comment ->
      // find the profile the comment belongs to and delete it from there
      List entities = Entity.createCriteria().list {
          or {
            eq("type", metaDataService.etActivity)
            eq("type", metaDataService.etGroupActivity)
            eq("type", metaDataService.etProject)
            eq("type", metaDataService.etProjectTemplate)
            eq("type", metaDataService.etTemplate)
          }
      }
      entities.each { Entity ent ->
          Comment profileComment = ent?.profile?.comments?.find {it.id == comment.id} as Comment
          if (profileComment)
            ent.profile.removeFromComments(profileComment)
      }
    }
  }

  /**
   * Converts a date from UTC
   *
   * @author Alexander Zeillinger
   * @param date REQUIRED The date to convert
   * @return a date
   */
  Date convertFromUTC(Date date) {
    if ( !date ) return date
    Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))
    calendar.setTime(date)
    calendar.add(Calendar.MINUTE, ((calendar.get(Calendar.ZONE_OFFSET) + calendar.get(Calendar.DST_OFFSET)) / (60 * 1000)).toInteger())
    return calendar.getTime()
  }

  /**
   * Converts a date to UTC
   *
   * @author Alexander Zeillinger
   * @param date REQUIRED The date to convert
   * @return a date
   */
  Date convertToUTC(Date date) {
    if ( !date ) return date
    Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))
    calendar.setTime(date)
    // FIXME: DST seems to get ignored, checked on 11.10.2012
    calendar.add(Calendar.MINUTE, -((calendar.get(Calendar.ZONE_OFFSET) + calendar.get(Calendar.DST_OFFSET)) / (60 * 1000)).toInteger())
    return calendar.getTime()
  }

  /**
   * Returns an entity of a link
   *
   * @author Alexander Zeillinger
   * @author Rainer Oppel
   * @param source REQUIRED an entity
   * @param target REQUIRED an entity
   * @param type REQUIRED a link type
   * @return an entity
   */
  Entity findByLink(Entity source, Entity target, LinkType type) {
    /*
    Link.createCriteria().get {
      if (source) eq('source', source)
      if (target) eq('target', target)
      eq('type', type)
      // the link property that is not supplied (i.e. NULL) is the one we are looking for so use it as projection value
      projections {
        if (!source) property('source')
        if (!target) property('target')
      }
    } as Entity
    */
    def aSourceId
    def aTargetId
    def aTypeId = type.id
    def entA = null
    if (target) {
      aTargetId = target.id
      entA = Entity.find(
            'from Entity as ent '+
            'where ent.id in '+
             '(select li.source.id from Link as li  '+
                  'where li.target.id = :targid and li.type.id = :typid) ',
            [targid: aTargetId, typid: aTypeId]  )
    }
    if (source) {
      aSourceId = source.id
      entA = Entity.find(
            'from Entity as ent '+
            'where ent.id in '+
             '(select li.target.id from Link as li  '+
                  'where li.source.id = :sourid and li.type.id = :typid) ',
            [sourid: aSourceId, typid: aTypeId]  )
    }

    return entA
  }

  /**
   * Returns entities of a link
   *
   * @author Alexander Zeillinger
   * @author Rainer Oppel
   * @param source REQUIRED an entity
   * @param target REQUIRED an entity
   * @param type REQUIRED a link type
   * @return a list of entities
   */
  List findAllByLink(Entity source, Entity target, LinkType type) {
    /*
    Link.createCriteria().list {
      if (source) eq('source', source)
      if (target) eq('target', target)
      eq('type', type)
      // the link property that is not supplied (i.e. NULL) is the one we are looking for so use it as projection value
      projections {
        if (!source) property('source')
        if (!target) property('target')
      }
    }
    */
    def aSourceId
    def aTargetId
    def aTypeId = type.id
    def entA = []
    if (target) {
      aTargetId = target.id
      entA = Entity.findAll(
            'from Entity as ent '+
            'where ent.id in '+
             '(select li.source.id from Link as li  '+
                  'where li.target.id = :targid and li.type.id = :typid) ',
            [targid: aTargetId, typid: aTypeId]  )
    }
    if (source) {
      aSourceId = source.id
      entA = Entity.findAll(
            'from Entity as ent '+
            'where ent.id in '+
             '(select li.target.id from Link as li  '+
                  'where li.source.id = :sourid and li.type.id = :typid) ',
            [sourid: aSourceId, typid: aTypeId]  )
    }

    return entA
  }
  
  /**
   * Links two entities and returns a map with all entities linked to the target, all entities linked to the source,
   * the source, the target and whether or not the link already existed
   *
   * @author Alexander Zeillinger
   * @param s REQUIRED the ID of an entity
   * @param t REQUIRED the ID of an entity
   * @param type REQUIRED a link type
   * @return a map
   */
  def linkEntities(String s, String t, LinkType type) {
    Entity source = Entity.get(s.toInteger())
    Entity target = Entity.get(t.toInteger())
    Boolean duplicate = false

    // check if the entities aren't already linked together with the given type
    def link = Link.createCriteria().get {
      eq('source', source)
      eq('target', target)
      eq('type', type)
    }
    if (link)
      duplicate = true
    else
      new Link(source: source, target: target, type: type).save(flush: true)

    List sources = findAllByLink(null, target, type)
    List targets = findAllByLink(source, null, type)

    return [sources: sources, targets: targets, source: source, target: target, duplicate: duplicate]
  }

  /**
   * Breaks two entities and returns a map with all entities linked to the target, all entities linked to the source,
   * the source and the target
   *
   * @author Alexander Zeillinger
   * @param s REQUIRED the ID of an entity
   * @param t REQUIRED the ID of an entity
   * @param type REQUIRED a link type
   * @return a map
   */
  def breakEntities(String s, String t, LinkType type) {
    Entity source = Entity.get(s.toInteger())
    Entity target = Entity.get(t.toInteger())

    Link.createCriteria().get {
      eq('source', source)
      eq('target', target)
      eq('type', type)
    }?.delete(flush: true)

    List sources = findAllByLink(null, target, type)
    List targets = findAllByLink(source, null, type)

    return [sources: sources, targets: targets, source: source, target: target]
  }

  /**
   * Creates an event on the dashboard
   *
   * @author Alexander Zeillinger
   * @param type REQUIRED the event type
   * @param who REQUIRED entity id
   * @param what REQUIRED entity id
   * @param date
   * @return the event
   */
  Event createEvent(EVENT_TYPE type, Integer who, Integer what, Date date = new Date()) {
    new Event(type: type, who: who, what: what, date: date).save()
  }

  /**
   * Constructs a nickname from a first name and a last name
   *
   * @author Alexander Zeillinger
   * @param firstName REQUIRED the first name
   * @param lastName REQUIRED the last name
   * @return the constructed nickname
   */
  String createNick(String firstName, String lastName) {
    def temp = (firstName + lastName).toLowerCase()
    def matcher = (temp =~ /[^a-z0-9]+/)
    def nickName = matcher.replaceAll("-")
    nickName = nickName.substring(0, nickName.length() > 49 ? 49 : nickName.length())
    return nickName
  }

  /**
   * Constructs a nickname from a full name
   *
   * @author Alexander Zeillinger
   * @param fullName REQUIRED the full name
   * @return the constructed nickname
   */
  String createNick(String fullName) {
    def temp = fullName.toLowerCase()
    def matcher = (temp =~ /[^a-z0-9]+/)
    def nickName = matcher.replaceAll("-")
    nickName = nickName.substring(0, nickName.length() > 49 ? 49 : nickName.length())
    return nickName
  }

  /**
   * Creates a private message
   *
   * @author Alexander Zeillinger
   * @param sender REQUIRED the sender
   * @param receiver REQUIRED the receiver
   * @param entity REQUIRED the entity the message belongs to
   * @param subject REQUIRED the subject
   * @param content REQUIRED the content
   * @param read
   * @return the message
   */
  def createMessage(Entity sender, List receivers, Entity entity, String subject, String content, Boolean read = false) {
    def message = new Msg(read: read, sender: sender, entity: entity, subject: subject, content: content)//.save()
      receivers?.each { String receiver ->
          Entity rec = Entity.get(receiver.toInteger())
        message.addToReceivers(rec)
      }
    return message
  }

  /**
   * Receives an activity group, finds all clients linked to it, finds all families linked to the clients and returns all parents linked to the families
   *
   * @author Alexander Zeillinger
   * @param group REQUIRED an entity
   * @return a list of parents
   */
  List findParents(Entity group) {

    // 1. find all clients linked to the group
    List clients = findAllByLink(null, group, metaDataService.ltGroupMemberClient)

    // 2. find all families of the clients
    List families = []
    clients.each { Entity client ->
      List links = findAllByLink(client, null, metaDataService.ltGroupFamily)
      links.each {
        if (!families.contains(it))
          families << it
      }
    }

    // 3. find all parents of the families
    List allParents = []
    families.each { Entity family ->
      List parents = findAllByLink(null, family, metaDataService.ltGroupMemberParent)
      parents.each {
        allParents.add(it)
      }
    }

    return allParents
  }

  /**
   * Receives an activity group, finds the facility linked to it and returns all educators linked to the facility
   *
   * @author Alexander Zeillinger
   * @param group REQUIRED an entity
   * @return a list of educators
   */
  List findEducators(Entity group) {

    // 1. find facility linked to the group
    Entity facility = findByLink(group, null, metaDataService.ltGroupMemberFacility)

    // 2. find all educators linked to the facility
    def allEducators = Link.createCriteria().list {
      eq('target', facility)
      or {
        eq('type', metaDataService.ltWorking)
        eq('type', metaDataService.ltLeadEducator)
      }
      projections {
        distinct('source')        
      }
    }

    return allEducators
  }

  /**
   * Returns all clients of a facility
   *
   * @author Alexander Zeillinger
   * @param entity REQUIRED the facility
   * @return a list of clients
   */
  List findClientsOf(Entity entity, def params = []) {

    // 1. find facility the entity is working in
    def facility = findByLink(entity, null, metaDataService.ltWorking)

    // 2. find clients linked to the facility
    def clients = []
    if (facility) {
      clients = findAllByLink(null, facility, metaDataService.ltClientship)
    }

    return clients
  }

  /**
   * Returns all publications of an entity
   *
   * @author Alexander Zeillinger
   * @param entity REQUIRED the entity
   * @return a list of publications
   */
  List findPublicationsOfEntity(Entity owner) {
    return Publication.findAllByEntity(owner)
  }

  /**
   * convenient shortcut to be used by controller
   */
  def storeAsset(Entity ent, String type, MultipartFile mfile) {
    storeAsset(ent, type, mfile.contentType, mfile.getBytes())
  }

  /**
   * creates and if necessary stores an asset from the given data.
   * The corresponding storage is identified by a SHA hash (of the content) and re-used if already
   * exists. This will avoid duplicate storage and has other interesting usages
   */
  def storeAsset(Entity ent, String type, String contentType, byte[] content) {

    def sid = HashTools.SHA(content)

    // create a unique asset storage if it does not exist already ...
    def store = assetService.findStorage(sid)
    if (!store) {
      store = new AssetStorage (storageId: sid, contentType: contentType)
      assetService.assetStore.put (sid, content)
      store = store.save()
    }

    // check if there is already an asset with this entity, type and asset storage
    def asset = Asset.createCriteria().get {
      and {
        eq ('entity', ent)
        eq ('type', type)
        eq ('storage', store)
      }
    }

    // if the new asset is of type "profile" delete the existing (if any) asset of this type
    if (type == "profile") {
      Asset toDelete = Asset.findByEntityAndType(ent, "profile")
      toDelete?.delete()
    }

    // only if it's not there, create a new one and link it with the storage
    if (!asset) {
      asset = new Asset(entity: ent, storage: store, type: type)
      store.addToAssets(asset)
      if (!asset.save()) {
        asset.errors.allErrors.each {
          log.error ("create asset $asset: field: '$it.field' code: $it.code, rejectedValue: $it.rejectedValue")
        }
        return null
      }
    } else {
      // update the timestamp so it comes out first with selection 'latest' and such
      asset.lastUpdated = new Date()
      asset.save()
    }

    // also delete unreferenced asset storages
    List ast = AssetStorage.list()

    ast.each { AssetStorage assetStorage ->
      if (assetStorage.assets.size() == 0)
        assetStorage.delete()
    }

    log.debug ("asset for $ent.name of type $type is stored as $sid")
    return asset
  }

  /** WIP
   * Calculates the number of hours an educator has worked in a given category
   *
   * @author Alexander Zeillinger
   * @attr category REQUIRED The category to check
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getHoursForCategory(category, educator, date1, date2) {
    /*Date date1
    Date date2
    if (attrs.date1 != "" && attrs.date2 != "") {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator
    WorkdayCategory workdayCategory = attrs.category*/

    date2 = date2 + 1

    BigDecimal hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      if (workdayUnit.category == category.name) {

        // check if the date of the workdayunit is between date1 and date2
        if (date1 != "" && date2 != "") {
          if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
            hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
      }
    }

    return hours
  }

}
