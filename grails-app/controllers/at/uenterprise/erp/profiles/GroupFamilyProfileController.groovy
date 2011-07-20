package at.uenterprise.erp.profiles

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.openfactory.ep.Profile
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.EntityException

class GroupFamilyProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService

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

    EntityType etGroupFamily = servletContext.etGroupFamily
    def groupFamilies = Entity.createCriteria().list {
      eq("type", etGroupFamily)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalGroupFamilies = Entity.countByType(etGroupFamily)

    return [groups: groupFamilies, totalGroupFamilies: totalGroupFamilies]
  }

  def show = {
    def group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      //flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    int totalLinks = 0

    // find all parents linked to this group
    List parents = functionService.findAllByLink(null, group, servletContext.ltGroupMemberParent)
    totalLinks += parents.size()

    def allClients = Entity.findAllByType(servletContext.etClient)
    // find all clients linked to this group
    List clients = functionService.findAllByLink(null, group, servletContext.ltGroupFamily)
    totalLinks += clients.size()

    def allChilds = Entity.findAllByType(servletContext.etChild)
    // find all childs linked to this group
    List childs = functionService.findAllByLink(null, group, servletContext.ltGroupMemberChild)
    totalLinks += childs.size()

    return [group: group,
            entity: entity,
            parents: parents,
            clients: clients,
            allClients: allClients,
            childs: childs,
            allChilds: allChilds,
            totalLinks: totalLinks]

  }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {
      // delete all links
      Link.findAllBySourceOrTarget(group, group).each {it.delete()}
      try {
        flash.message = message(code: "group.deleted", args: [group.profile.fullName])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "group.notDeleted", args: [group.profile.fullName])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      //flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (!group) {
      //flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect action: 'list'
    }
    else {
      [group: group]
    }
  }

  def update = {
    Entity group = Entity.get(params.id)

    group.profile.properties = params

    if (group.profile.save() && group.save()) {
      flash.message = message(code: "group.updated", args: [group.profile.fullName])
      redirect action: 'show', id: group.id, params: [entity: group.id]
    }
    else {
      render view: 'edit', model: [group: group]
    }
  }

  def create = {
    return [templates: Entity.findAllByType(servletContext.etTemplate)]
  }

  def save = {
    EntityType etGroupFamily = servletContext.etGroupFamily

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupFamily) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (EntityException ee) {
      render(view: "create", model: [group: ee.entity])
    }

  }

  def addParent = {
    // check if the parent hasn't been already added to another family
    def result = Link.findBySourceAndType(Entity.get(params.parent), servletContext.ltGroupMemberParent)
    if (!result) {
      def linking = functionService.linkEntities(params.parent, params.id, servletContext.ltGroupMemberParent)
      if (linking.duplicate)
        //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
        render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</span>'

      render template: 'parents', model: [parents: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
      }
    else {
      //render '<span class="red italic">"' + Entity.get(params.parent).profile.fullName + '" wurde bereits einer anderen Familie zugewiesen!</span>'
      render '<span class="red italic">"' + Entity.get(params.parent).profile.fullName + '" '+message(code: "alreadyAssignedToFamily")+'</span>'
      List parents = functionService.findAllByLink(null, Entity.get(params.id), servletContext.ltGroupMemberParent)
      render template: 'parents', model: [parents: parents, group: Entity.get(params.id), entity: entityHelperService.loggedIn]
    }

  }

  def removeParent = {
    def breaking = functionService.breakEntities(params.parent, params.id, servletContext.ltGroupMemberParent)
    render template: 'parents', model: [parents: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addClient = {
    // check if the client hasn't been already added to another family
    def result = Link.findBySourceAndType(Entity.get(params.client), servletContext.ltGroupFamily)
    if (!result) {
      def linking = functionService.linkEntities(params.client, params.id, servletContext.ltGroupFamily)
      if (linking.duplicate)
        //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
        render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</span>'

      render template: 'clients', model: [clients: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
    }
    else {
      //render '<span class="red italic">"' + Entity.get(params.client).profile.fullName + '" wurde bereits einer anderen Familie zugewiesen!</span>'
      render '<span class="red italic">"' + Entity.get(params.parent).profile.fullName + '" '+message(code: "alreadyAssignedToFamily")+'</span>'
      List clients = functionService.findAllByLink(null, Entity.get(params.id), servletContext.ltGroupFamily)
      render template: 'clients', model: [clients: clients, group: Entity.get(params.id), entity: entityHelperService.loggedIn]
    }
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, servletContext.ltGroupFamily)
    render template: 'clients', model: [clients: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def addChild = {
    // check if the child hasn't been already added to another family
    def result = Link.findBySourceAndType(Entity.get(params.child), servletContext.ltGroupMemberChild)
    if (!result) {
      def linking = functionService.linkEntities(params.child, params.id, servletContext.ltGroupMemberChild)
      if (linking.duplicate)
        //render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
        render '<span class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</span>'

      render template: 'childs', model: [childs: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
    }
    else {
      //render '<span class="red italic">"' + Entity.get(params.child).profile.fullName + '" wurde bereits einer anderen Familie zugewiesen!</span>'
      render '<span class="red italic">"' + Entity.get(params.parent).profile.fullName + '" '+message(code: "alreadyAssignedToFamily")+'</span>'
      List childs = functionService.findAllByLink(null, Entity.get(params.id), servletContext.ltGroupMemberChild)
      render template: 'childs', model: [childs: childs, group: Entity.get(params.id), entity: entityHelperService.loggedIn]
    }
  }

  def removeChild = {
    def breaking = functionService.breakEntities(params.child, params.id, servletContext.ltGroupMemberChild)
    render template: 'childs', model: [childs: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  /*
   * retrieves all parents matching the search parameter
   */
  def remoteParents = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', servletContext.etParent)
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
      render(template: 'parentresults', model: [results: results, group: params.id])
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
      eq('type', servletContext.etClient)
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
      render(template: 'clientresults', model: [results: results, group: params.id])
    }
  }

  /*
   * retrieves all children matching the search parameter
   */
  def remoteChildren = {
    if (!params.value) {
      render ""
      return
    }

    def c = Entity.createCriteria()
    def results = c.list {
      eq('type', servletContext.etChild)
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
      render(template: 'childrenresults', model: [results: results, group: params.id])
    }
  }

  def updateFamilyCount = {
    def group = Entity.get(params.id)

    def c = Link.createCriteria()
    def results = c.list {
      eq("target", group)
      or {
        eq("type", servletContext.ltGroupMemberParent)
        eq("type", servletContext.ltGroupFamily)
        eq("type", servletContext.ltGroupMemberChild)
      }
    }

    int totalLinks = results.size()

    render template: 'familycount', model: [totalLinks: totalLinks]
  }

  def bla = {
    render "two times?"
  }

}
