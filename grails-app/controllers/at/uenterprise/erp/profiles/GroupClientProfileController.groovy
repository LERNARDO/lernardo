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

class GroupClientProfileController {
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
    int totalGroupClients = Entity.countByType(metaDataService.etGroupClient)

    return [totalGroupClients: totalGroupClients]
  }

  def show = {
    Entity group = Entity.get(params.id)

    if (!group) {
      flash.message = message(code: "object.notFound", args: [message(code: "groupClient")])
      redirect(action: list)
      return
    }

    return [group: group]
  }

    def management = {
        Entity group = Entity.get(params.id)

        // find all clients linked to this group
        List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberClient)

        List allClients = Entity.findAllByType(metaDataService.etClient)
        List allColonies = Entity.findAllByType(metaDataService.etGroupColony)
        List allFacilities = Entity.findAllByType(metaDataService.etFacility)

        // find lead educators
        List leadEducators = functionService.findAllByLink(null, group, metaDataService.ltLeadEducator)

        render template: "management", model: [group: group,
                clients: clients,
                allClients: allClients,
                allColonies: allColonies,
                allFacilities: allFacilities,
                leadeducators: leadEducators]
    }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {
      functionService.deleteReferences(group)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "groupClient"), group.profile])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException ignore) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "groupClient"), group.profile])
        redirect(action: "show", id: params.id, params: [exception: e])
      }
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "groupClient")])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (!group) {
      flash.message = message(code: "object.notFound", args: [message(code: "groupClient")])
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
      flash.message = message(code: "object.updated", args: [message(code: "groupClient"), group.profile])
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
    Entity currentEntity = entityHelperService.loggedIn
    EntityType etGroupClient = metaDataService.etGroupClient

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupClient) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      // save creator
      new Link(source: currentEntity, target: entity, type: metaDataService.ltCreator).save()

      flash.message = message(code: "object.created", args: [message(code: "groupClient"), entity.profile])
      redirect action: 'show', id: entity.id
    } catch (EntityException ee) {
      render view: "create", model: [group: ee.entity]
    }

  }

  def addClient = {
    if (!params.members)
      render {p(class: 'italic red', message(code: "groupClient.clients.select.least"))}
    else {
      def bla = params.list('members')
  
      bla.each {
        def linking = functionService.linkEntities(it.toString(), params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
            render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
      }
    }

    render template: 'clients', model: [clients: functionService.findAllByLink(null, Entity.get(params.id), metaDataService.ltGroupMemberClient), group: Entity.get(params.id)]
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template: 'clients', model: [clients: breaking.sources, group: breaking.target]
  }

  def updateselect = {

    // set second date always to the last day of the year
    if (params.birthDate1) {
      params.birthDate2.setDate(31)
      params.birthDate2.setMonth(11)
    }
    
    //def allClients = Entity.findAllByType(metaDataService.etClient)
    params.type = metaDataService.etClient

    def allClients = Entity.createCriteria().listDistinct {
      if (params.type != "all")
        eq('type', params.type)
      if (params.name)
        profile {
          ilike('fullName', "%" + params.name + "%")
        }
        user {
            eq('enabled', true)
        }
      profile {
        if (params.gender != "0")
          eq('gender', params.gender.toInteger())
        if (params.job && params.job != "0") {
          if (params.job == "1")
            eq('job', true)
          if (params.job == "2")
            eq('job', false)
        }
        if (params.school)
          ilike('school', "%" + params.school + "%")
        if (params.schoolLevel != "all")
          eq('schoolLevel', params.schoolLevel)
        if (params.birthDate1)
          between('birthDate', params.birthDate1, params.birthDate2)
      }
      //maxResults(30)
    }

    // perform colony check
    List finalClients = []

    if (params.colony != "all") {
      allClients.each { Entity client ->

        def result = Link.createCriteria().get {
          eq("source", Entity.get(params.colony))
          eq("target", client)
          eq("type", metaDataService.ltColonia)
        }

        if (result)
          finalClients << client
      }
    }
    else
      finalClients = allClients

    // perform facility check
    List finalClients2 = []

    if (params.facility != "all") {
      finalClients.each { Entity client ->

        def result = Link.createCriteria().get {
          eq("source", client)
          eq("target", Entity.get(params.facility))
          eq("type", metaDataService.ltGroupMemberClient)
        }

        if (result)
          finalClients2 << client
      }
    }
    else
      finalClients2 = finalClients

    render template: 'searchresults', model: [allClients: finalClients2]
  }

  def createpdf = {
    Entity group = Entity.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn
    List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberClient)
    renderPdf template: 'createpdf', model: [pageformat: params.pageformat,
        entity: currentEntity,
        group: group,
        clients: clients],
        filename: message(code: 'groupClient') + '_' + group.profile + '.pdf'
  }

  def define = {
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 20, 40)

    // 1. pass - filter by object properties
    def results = Entity.createCriteria().list  {
      eq('type', metaDataService.etGroupClient)
      profile {
        if (params.name)
          ilike('fullName', "%" + params.name + "%")
        order(params.sort, params.order)
      }
    }

    // 2. pass - filter by creator
    if (params.creator != "") {
      results = results.findAll { Entity entity ->
        Link.createCriteria().get {
          eq('source', Entity.get(params.int('creator')))
          eq('target', entity)
          eq('type', metaDataService.ltCreator)
        }
      }
    }

    int totalResults = results.size()
    int upperBound = params.offset + params.max < totalResults ? params.offset + params.max : totalResults
    results = results.subList(params.offset, upperBound)

    render template: '/templates/searchresults', model: [results: results, totalResults: totalResults, type: 'groupClient', params: params]
  }

    def addLeadEducator = {
        def linking = functionService.linkEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
        if (linking.duplicate)
            render {p(class: 'red italic', message(code: "alreadyAssignedTo", args: [linking.source.profile]))}
        render template: 'leadeducators', model: [leadeducators: linking.sources, group: linking.target]
    }

    def removeLeadEducator = {
        def breaking = functionService.breakEntities(params.leadeducator, params.id, metaDataService.ltLeadEducator)
        render template: 'leadeducators', model: [leadeducators: breaking.sources, group: breaking.target]
    }

    /*
    * retrieves all educators matching the search parameter
    */
    def remoteLeadEducators = {
        if (!params.value) {
            render ""
            return
        }
        else if (params.value.size() < 2) {
            render {span(class: 'gray', message(code: 'minChars'))}
            return
        }

        def results = Entity.createCriteria().listDistinct {
            eq('type', metaDataService.etEducator)
            user {
                eq("enabled", true)
            }
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
            render template: 'leadeducatorresults', model: [results: results, group: params.id]
        }
    }

}
