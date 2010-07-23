package standard

import at.openfactory.ep.Entity
import lernardo.Event
import at.openfactory.ep.Link
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.LinkType
import lernardo.Msg

class FunctionService {
  MetaDataService metaDataService
  EntityHelperService entityHelperService

  boolean transactional = true

  /*
   * links two entities and returns all entities linked to the target
   */
  def linkEntities(String s, String t, LinkType linktype) {
    Entity source = Entity.get(s)
    Entity target = Entity.get(t)
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
      new Link(source: source, target: target, type: linktype).save()

    List results = Link.findAllByTargetAndType(target, linktype).collect {it.source}

    return [results: results, source: source, target: target, duplicate: duplicate]
  }

  /*
   * breaks two entities and returns all entities linked to the target
   */
  def breakEntities(String s, String t, LinkType linktype) {
    Entity source = Entity.get(s)
    Entity target = Entity.get(t)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', source)
      eq('target', target)
      eq('type', linktype)
    }
    link.delete()

    List results = Link.findAllByTargetAndType(target, linktype).collect {it.source}

    return [results: results, source: source, target: target]
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
   * the return type of a multiple select box is inconsistent (string when a single entry was selected, or a list when
   * multiple entries were selected) so this helper method takes the parameter and returns it as a list either way
   */
  def getParamAsList(param) {
    def paramList = []
    if (param && param != 'null') {
      (param?.class?.isArray()) ? paramList << (param as List) : paramList << (param)
      paramList = paramList.flatten()
    }
    return paramList
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

}
