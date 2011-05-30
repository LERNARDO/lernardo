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
    params.offset = params.offset ? params.int('offset') : 0
    params.max = Math.min(params.max ? params.int('max') : 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    def c = Entity.createCriteria()
    def groupclients = c.list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etGroupClient)
      profile {
        order(params.sort, params.order)
      }
    }

    return [groups: groupclients]
  }

  def show = {
    Entity group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      //flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: list)
      return
    }

    def allClients = Entity.findAllByType(metaDataService.etClient)
    // find all clients linked to this group
    List clients = functionService.findAllByLink(null, group, metaDataService.ltGroupMemberClient)

    List allColonias = Entity.findAllByType(metaDataService.etGroupColony)

    return [group: group,
            entity: entity,
            clients: clients,
            allClients: allClients,
            allColonias: allColonias]

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
      // flash.message = "groupProfile not found with id ${params.id}"
      flash.message = message(code: "group.idNotFound", args: [params.id])
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (!group) {
      // flash.message = "groupProfile not found with id ${params.id}"
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
    EntityType etGroupClient = metaDataService.etGroupClient

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupClient) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'show', id: entity.id
    } catch (EntityException ee) {
      render(view: "create", model: [group: ee.entity])
    }

  }

  def addClient = {
    if (!params.members)
      //render '<p class="italic red">Bitte zumindest einen Betreuten auswählen!</p>'
      render '<p class="italic red">'+message(code: "groupClient.clients.select.least")+'</p>'
    else {
      def bla = params.list('members')
  
      bla.each {
        def linking = functionService.linkEntities(it.toString(), params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
          //render '<p class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</p>'
          render '<p class="red italic">"' + linking.source.profile.fullName + '" '+message(code: "alreadyAssignedTo")+'</p>'
      }
    }
    //def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    //if (linking.duplicate)
    //  render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'clients', model: [clients: functionService.findAllByLink(null, Entity.get(params.id), metaDataService.ltGroupMemberClient), group: Entity.get(params.id), entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template: 'clients', model: [clients: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
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

    if (params.colonia != "all") {
      allClients.each { client ->

        def d = Link.createCriteria()
        def result = d.get {
          eq("source", Entity.get(params.colonia))
          eq("target", client as Entity)
          eq("type", metaDataService.ltColonia)
        }

        if (result)
          finalClients << client
      }
    }
    else
      finalClients = allClients

    render(template: 'searchresults', model: [allClients: finalClients])
  }

}
