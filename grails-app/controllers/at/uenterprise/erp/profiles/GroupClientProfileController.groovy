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
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    EntityType etGroupClient = metaDataService.etGroupClient
    def groupClients = Entity.createCriteria().list {
      eq("type", etGroupClient)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }
    int totalGroupClients = Entity.countByType(etGroupClient)

    return [groups: groupClients, totalGroupClients: totalGroupClients]
  }

  def show = {
    Entity group = Entity.get(params.id)

    if (!group) {
      flash.message = message(code: "object.notFound", args: [message(code: "groupClient")])
      redirect(action: list)
      return
    }

    def allClients = Entity.findAllByType(metaDataService.etClient)
    // find all clients linked to this group
    List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberClient)

    List allColonies = Entity.findAllByType(metaDataService.etGroupColony)
    List allFacilities = Entity.findAllByType(metaDataService.etFacility)

    return [group: group,
            clients: clients,
            allClients: allClients,
            allColonies: allColonies,
            allFacilities: allFacilities]

  }

  def delete = {
    Entity group = Entity.get(params.id)
    if (group) {
      functionService.deleteReferences(group)
      try {
        flash.message = message(code: "object.deleted", args: [message(code: "groupClient"), group.profile.fullName])
        group.delete(flush: true)
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = message(code: "object.notDeleted", args: [message(code: "groupClient"), group.profile.fullName])
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
      flash.message = message(code: "object.updated", args: [message(code: "groupClient"), group.profile.fullName])
      redirect action: 'show', id: group.id, params: [entity: group.id]
    }
    else {
      render view: 'edit', model: [group: group]
    }
  }

  def create = {
    return [templates: Entity.findAllByType(metaDataService.etTemplate)]
  }

  def save = {
    EntityType etGroupClient = metaDataService.etGroupClient

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupClient) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "object.created", args: [message(code: "groupClient"), entity.profile.fullName])
      redirect action: 'show', id: entity.id, params: [entity: entity.id]
    } catch (EntityException ee) {
      render(view: "create", model: [group: ee.entity])
    }

  }

  def addClient = {
    if (!params.members)
      render '<p class="italic red">'+message(code: "groupClient.clients.select.least")+'</p>'
    else {
      def bla = params.list('members')
  
      bla.each {
        def linking = functionService.linkEntities(it.toString(), params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
          render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
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

    def c = Entity.createCriteria()
    def allClients = c.list {
      if (params.type != "all")
        eq('type', params.type)
      if (params.name)
        or {
          ilike('name', "%" + params.name + "%")
          profile {
            ilike('fullName', "%" + params.name + "%")
          }
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

        def d = Link.createCriteria()
        def result = d.get {
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

        def d = Link.createCriteria()
        def result = d.get {
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

    render(template: 'searchresults', model: [allClients: finalClients2])
  }

  def createpdf = {
    Entity group = Entity.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn
    List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberClient)
    renderPdf template: 'createpdf', model: [pageformat: params.pageformat,
        entity: currentEntity,
        group: group,
        clients: clients],
        filename: message(code: 'groupClient') + '_' + group.profile.fullName + '.pdf'
  }

}
