package at.uenterprise.erp

import at.openfactory.ep.Entity

import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.LinkType

class FunctionService {
  MetaDataService metaDataService
  EntityHelperService entityHelperService

  boolean transactional = true

  /* TIP
   * - Spread operator instead of collect method -
   * def results = links*.target
   * def results = links.collect {it.target}
   */

  /*
   * returns a single entity
   */
  Entity findByLink(Entity source, Entity target, LinkType type) {

    def c = Link.createCriteria()
    Entity result = c.get {
      if (source) eq("source", source)
      if (target) eq("target", target)
      eq("type", type)
      // the link property that is not supplied (i.e. NULL) is the one we are probably looking for so use it as projection value
      projections {
        if (!source) distinct("source")
        if (!target) distinct("target")
      }
    }
    return result

  }

  /*
   * returns multiple entities as list
   */
  List findAllByLink(Entity source, Entity target, LinkType type) {

    def c = Link.createCriteria()
    List results = c.list {
      if (source) eq("source", source)
      if (target) eq("target", target)
      eq("type", type)
      // the link property that is not supplied (i.e. NULL) is the one we are probably looking for so use it as projection value
      projections {
        if (!source) distinct("source")
        if (!target) distinct("target")
      }
    }
    return results

  }
  
  /*
   * links two entities and returns all entities linked to the target
   */
  def linkEntities(String s, String t, LinkType linktype) {
    Entity source = Entity.get(s.toInteger())
    Entity target = Entity.get(t.toInteger())
    Boolean duplicate = false

    // check if the source isn't already linked to the target
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', source)
      eq('target', target)
      eq('type', linktype)
    }
    if (link)
      duplicate = true
    else
      new Link(source: source, target: target, type: linktype).save(flush:true)

    List results = findAllByLink(null, target, linktype)
    List results2 = findAllByLink(source, null, linktype)

    return [results: results, results2: results2, source: source, target: target, duplicate: duplicate]
  }

  /*
   * breaks two entities and returns all entities linked to the target
   */
  def breakEntities(String s, String t, LinkType linktype) {
    Entity source = Entity.get(s.toInteger())
    Entity target = Entity.get(t.toInteger())

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', source)
      eq('target', target)
      eq('type', linktype)
    }
    link?.delete(flush:true)

    List results = findAllByLink(null, target, linktype)
    List results2 = findAllByLink(source, null, linktype)

    return [results: results, results2: results2, source: source, target: target]
  }

  /*
   * creates a new event on the dashboard
   */
  def createEvent(Entity entity, String content, Date date = new Date()) {
    new Event(entity: entity, content: content, date: date).save()
  }

  /*
   * constructs a nickname from a first name and a last name
   */
  def createNick(String firstName, String fullName) {
    def nickname = (firstName + fullName).toLowerCase()
    def matcher = (nickname =~ /[^a-z0-9]+/)
    def newname = matcher.replaceAll("-")
    return newname
  }

  /*
   * constructs a nickname from a full name
   */
  def createNick(String fullName) {
    def nickname = fullName.toLowerCase()
    def matcher = (nickname =~ /[^a-z0-9]+/)
    def newname = matcher.replaceAll("-")
    return newname
  }

  /*
   * creates a private message
   */
  boolean createMessage(Entity sender, Entity receiver, Entity entity, String subject, String content, Boolean read = false) {
    Msg msg = new Msg()
    msg.read = read
    msg.sender = sender
    msg.receiver = receiver
    msg.entity = entity
    msg.subject = subject
    msg.content = content
    if (msg.save(flush: true))
      return true
    else
      return false
  }

  /*
   * receives an activity group, finds all clients linked to it, finds all families linked to the client and returns all parents linked to the families
   */
  def findParents(Entity group) {

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

  /*
   * receives an activity group, find the facility linked to it and returns all educators linked to the facility
   */
  def findEducators(Entity group) {

    // 1. find facility linked to the group
    Entity facility = findByLink(null, group, metaDataService.ltGroupMemberFacility)

    // 2. find all educators linked to the facility
    def c = Link.createCriteria()
    def allEducators = c.list {
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

  /*
   * returns all clients of a given entity (facility)
   */
  def findClientsOf(Entity entity, def params = []) {

    // 1. find facility the entity is working in
    def facility = findByLink(entity, null, metaDataService.ltWorking)

    // 2. find clients linked to the facility
    def clients = []
    if (facility) {
      clients = findAllByLink(null, facility, metaDataService.ltClientship)
    }

    return clients
  }

  List findPublicationsOfEntity(Entity owner) {
    return Publication.findAllByEntity(owner)
  }

}
