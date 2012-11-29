package at.uenterprise.erp.profiles

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.ProfileHelperService
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.FunctionService
import at.uenterprise.erp.base.EntityException

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
    int totalGroupFamilies = Entity.countByType(metaDataService.etGroupFamily)

    return [totalGroupFamilies: totalGroupFamilies,
            facilities: Entity.findAllByType(metaDataService.etFacility)]
  }

  def show = {
    def group = Entity.get(params.id)

    if (!group) {
      flash.message = message(code: "object.notFound", args: [message(code: "groupFamily")])
      redirect(action: list)
      return
    }

    return [group: group]

  }

  def management = {
      def group = Entity.get(params.id)

      int totalLinks = 0

      // find all parents linked to this group
      List parents = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberParent)
      totalLinks += parents.size()

      // find all clients linked to this group
      List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupFamily)
      totalLinks += clients.size()

      // find all childs linked to this group
      List childs = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberChild)
      totalLinks += childs.size()

      render template: "management", model: [group: group,
              parents: parents,
              clients: clients,
              childs: childs,
              totalLinks: totalLinks]
  }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {
      functionService.deleteReferences(group)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "groupFamily"), group.profile])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "groupFamily"), group.profile])
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "groupFamily")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (!group) {
       flash.message = message(code: "object.notFound", args: [message(code: "groupFamily")])
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
      flash.message = message(code: "object.updated", args: [message(code: "groupFamily"), group.profile])
      redirect action: 'show', id: group.id
    }
    else {
      render view: 'edit', model: [group: group]
    }
  }

  def create = {
    return [templates: Entity.findAllByType(metaDataService.etTemplate)]
  }

  def save = {
    EntityType etGroupFamily = metaDataService.etGroupFamily

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupFamily) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "object.created", args: [message(code: "groupFamily"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (EntityException ee) {
      render view: "create", model: [group: ee.entity]
    }

  }

  def addParent = {
    // check if the parent hasn't been already added to another family
    def result = Link.findBySourceAndType(Entity.get(params.parent), metaDataService.ltGroupMemberParent)
    if (!result) {
      def linking = functionService.linkEntities(params.parent, params.id, metaDataService.ltGroupMemberParent)
      if (linking.duplicate)
          render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}

      render template: 'parents', model: [parents: linking.sources, group: linking.target]
      }
    else {
      render {span(class: 'red italic', message(code: 'alreadyAssignedToFamily', args: [Entity.get(params.parent).profile]))}
      List parents = functionService.findAllByLink(null, Entity.get(params.id), metaDataService.ltGroupMemberParent)
      render template: 'parents', model: [parents: parents, group: Entity.get(params.id)]
    }

  }

  def removeParent = {
    def breaking = functionService.breakEntities(params.parent, params.id, metaDataService.ltGroupMemberParent)
    render template: 'parents', model: [parents: breaking.sources, group: breaking.target]
  }

  def addClient = {
    // check if the client hasn't been already added to another family
    def result = Link.findBySourceAndType(Entity.get(params.client), metaDataService.ltGroupFamily)
    if (!result) {
      def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltGroupFamily)
      if (linking.duplicate)
          render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}

      render template: 'clients', model: [clients: linking.sources, group: linking.target]
    }
    else {
      render {span(class: 'red italic', message(code: 'alreadyAssignedToFamily', args: [Entity.get(params.client).profile]))}
      List clients = functionService.findAllByLink(null, Entity.get(params.id), metaDataService.ltGroupFamily)
      render template: 'clients', model: [clients: clients, group: Entity.get(params.id)]
    }
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupFamily)
    render template: 'clients', model: [clients: breaking.sources, group: breaking.target]
  }

  def addChild = {
    // check if the child hasn't been already added to another family
    def result = Link.findBySourceAndType(Entity.get(params.child), metaDataService.ltGroupMemberChild)
    if (!result) {
      def linking = functionService.linkEntities(params.child, params.id, metaDataService.ltGroupMemberChild)
      if (linking.duplicate)
          render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}

      render template: 'childs', model: [childs: linking.sources, group: linking.target]
    }
    else {
      render {span(class: 'red italic', message(code: 'alreadyAssignedToFamily', args: [Entity.get(params.child).profile]))}
      List childs = functionService.findAllByLink(null, Entity.get(params.id), metaDataService.ltGroupMemberChild)
      render template: 'childs', model: [childs: childs, group: Entity.get(params.id)]
    }
  }

  def removeChild = {
    def breaking = functionService.breakEntities(params.child, params.id, metaDataService.ltGroupMemberChild)
    render template: 'childs', model: [childs: breaking.sources, group: breaking.target]
  }

  /*
   * retrieves all parents matching the search parameter
   */
  def remoteParents = {
    if (!params.value) {
      render ""
      return
    }
    else if (params.value.size() < 2) {
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().list {
      eq('type', metaDataService.etParent)
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
      render template: 'parentresults', model: [results: results, group: params.id]
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
    else if (params.value.size() < 2) {
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().list {
      eq('type', metaDataService.etClient)
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
      render template: 'clientresults', model: [results: results, group: params.id]
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
    else if (params.value.size() < 2) {
      render {span(class: 'gray', message(code: 'minChars'))}
      return
    }

    def results = Entity.createCriteria().list {
      eq('type', metaDataService.etChild)
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
      render template: 'childrenresults', model: [results: results, group: params.id]
    }
  }

  def updateFamilyCount = {
    def group = Entity.get(params.id)

    def results = Link.createCriteria().list {
      eq("target", group)
      or {
        eq("type", metaDataService.ltGroupMemberParent)
        eq("type", metaDataService.ltGroupFamily)
        eq("type", metaDataService.ltGroupMemberChild)
      }
    }

    int totalLinks = results.size()

    render template: 'familycount', model: [totalLinks: totalLinks]
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().list  {
      eq('type', metaDataService.etGroupFamily)
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        if (params.familyIncomeFrom)
          ge("familyIncome", params.int('familyIncomeFrom'))
        if (params.familyIncomeTo)
          le("familyIncome", params.int('familyIncomeTo'))
        if (params.amountHouseholdFrom)
          ge("amountHousehold", params.int('amountHouseholdFrom'))
        if (params.amountHouseholdTo)
          le("amountHousehold", params.int('amountHouseholdTo'))
        order(params.sort, params.order)
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'groupFamily', params: params]
  }

}
