package at.uenterprise.erp

import at.openfactory.ep.Entity

import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.LinkType
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.web.multipart.MultipartFile
import at.openfactory.ep.util.HashTools
import at.openfactory.ep.AssetStorage
import at.openfactory.ep.Asset
import at.openfactory.ep.AssetService

class FunctionService {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  GrailsApplication grailsApplication
  AssetService assetService

  boolean transactional = true

  /**
   * Converts a date from UTC
   *
   * @author Alexander Zeillinger
   * @param date the date to convert
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
   * @param date the date to convert
   * @return a date
   */
  Date convertToUTC(Date date) {
    if ( !date ) return date
    Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))
    calendar.setTime(date)
    calendar.add(Calendar.MINUTE, -((calendar.get(Calendar.ZONE_OFFSET) + calendar.get(Calendar.DST_OFFSET)) / (60 * 1000)).toInteger())
    return calendar.getTime()
  }

  /**
   * Returns an entity of a link
   *
   * @author Alexander Zeillinger
   * @param source an entity
   * @param target an entity
   * @param type a link type
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
    def entA
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
   * @param source an entity
   * @param target an entity
   * @param type a link type
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
   * @param s the ID of an entity
   * @param t the ID of an entity
   * @param type a link type
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

    List results = findAllByLink(null, target, type)
    List results2 = findAllByLink(source, null, type)

    return [results: results, results2: results2, source: source, target: target, duplicate: duplicate]
  }

  /**
   * Breaks two entities and returns a map with all entities linked to the target, all entities linked to the source,
   * the source and the target
   *
   * @author Alexander Zeillinger
   * @param s the ID of an entity
   * @param t the ID of an entity
   * @param type a link type
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

    List results = findAllByLink(null, target, type)
    List results2 = findAllByLink(source, null, type)

    return [results: results, results2: results2, source: source, target: target]
  }

  /**
   * Creates an event on the dashboard
   *
   * @author Alexander Zeillinger
   * @param entity the entity the event belongs to
   * @param content
   * @param date
   * @return the event
   */
  Event createEvent(String name, Integer who, Integer what, Date date = new Date()) {
    new Event(name: name, who: who, what: what, date: date).save()
  }

  /**
   * Constructs a nickname from a first name and a last name
   *
   * @author Alexander Zeillinger
   * @param firstName
   * @param lastName
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
   * @param fullName
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
   * @param sender
   * @param receiver
   * @param entity the entity the message belongs to
   * @param subject
   * @param content
   * @param read
   * @return the message
   */
  Msg createMessage(Entity sender, Entity receiver, Entity entity, String subject, String content, Boolean read = false) {
    new Msg(read: read, sender: sender, receiver: receiver, entity: entity, subject: subject, content: content).save()
  }

  /**
   * Receives an activity group, finds all clients linked to it, finds all families linked to the clients and returns all parents linked to the families
   *
   * @author Alexander Zeillinger
   * @param group an entity
   * @return a list of parents
   */
  List findParents(Entity group) {

    // 1. find all clients linked to the group
    List clients = findAllByLink(null, group, metaDataService.ltGroupMemberClient)

    // 2. find all families of the clients
    List families = []
    clients.each {
      List links = findAllByLink(it as Entity, null, metaDataService.ltGroupFamily)
      links.each {
        if (!families.contains(it))
          families << it
      }
    }

    // 3. find all parents of the families
    List allParents = []
    families.each {
      List parents = findAllByLink(null, it as Entity, metaDataService.ltGroupMemberParent)
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
   * @param group an entity
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
   * @param entity the facility
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
   * @param entity
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

      // see if we have it already stored somehow ...
      def store = assetService.findStorage(sid)
      if (!store) {
        store = new AssetStorage (storageId:sid, contentType:contentType)
        assetService.assetStore.put (sid, content)
        store = store.save()
      }

      // now see if we have a linked asset for this user type and storage
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
        asset = new Asset(entity:ent, storage:store, type:type)
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
      //println "assetStorage list: " + ast

      ast.each { AssetStorage assetStorage ->
        //println "assets: " + assetStorage.assets
        if (assetStorage.assets.size() == 0)
          assetStorage.delete()
      }

      //println "assetStorage list: " + ast

      log.debug ("asset for $ent.name of type $type is stored as $sid")
      return asset
    }

}
