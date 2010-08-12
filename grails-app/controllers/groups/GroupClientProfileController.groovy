package groups

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import at.openfactory.ep.Profile
import standard.FunctionService
import standard.FilterService
import at.openfactory.ep.EntityException

class GroupClientProfileController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService
  FunctionService functionService
  FilterService filterService

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
    def groupclients = c.list {
      eq("type", metaDataService.etGroupClient)
      profile {
        order(params.sort, params.order)
      }
      maxResults(params.max)
      firstResult(params.offset)
    }

    return [groups: groupclients,
            groupTotal: Entity.countByType(metaDataService.etGroupClient),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    Entity group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      flash.message = "groupProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      def allClients = Entity.findAllByType(metaDataService.etClient)
      // find all clients linked to this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberClient)
      List clients = links.collect {it.source}

      return [group: group,
              entity: entity,
              clients: clients,
              allClients: allClients]
    }
  }

  def del = {
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
      flash.message = "groupProfile not found with id ${params.id}"
      redirect(action: "list")
    }
  }

  def edit = {
    Entity group = Entity.get(params.id)

    if (!group) {
      flash.message = "groupProfile not found with id ${params.id}"
      redirect action: 'list'
    }
    else {
      [group: group, entity: entityHelperService.loggedIn]
    }
  }

  def update = {
    Entity group = Entity.get(params.id)

    group.profile.properties = params

    if (!group.hasErrors() && group.save()) {
      flash.message = message(code: "group.updated", args: [group.profile.fullName])
      redirect action: 'show', id: group.id
    }
    else {
      render view: 'edit', model: [group: group, entity: entityHelperService.loggedIn]
    }
  }

  def create = {
    return [entity: entityHelperService.loggedIn, templates: Entity.findAllByType(metaDataService.etTemplate)]
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
      render(view: "create", model: [group: ee.entity, entity: entityHelperService.loggedIn])
      return
    }

  }

  def addClient = {
    if (!params.members)
      render '<p class="italic red">Bitte zumindest einen Betreuten ausw�hlen!</p>'
    else {
      def bla = functionService.getParamAsList(params.members)
  
      bla.each {
        def linking = functionService.linkEntities(it.toString(), params.id, metaDataService.ltGroupMemberClient)
        if (linking.duplicate)
          render '<p class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</p>'
      }
    }
    //def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    //if (linking.duplicate)
    //  render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template: 'clients', model: [clients: Link.findAllByTargetAndType(Entity.get(params.id), metaDataService.ltGroupMemberClient).collect {it.source}, group: Entity.get(params.id), entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template: 'clients', model: [clients: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def updateselect = {
    println params
    def allClients = Entity.findAllByType(metaDataService.etClient)
    params.type = metaDataService.etClient

    def c = Entity.createCriteria()
    allClients = c.list {
      if (params.type != 'all')
        eq('type', params.type)
      if (params.name)
        or {
          ilike('name', "%" + params.name + "%")
          profile {
            ilike('fullName', "%" + params.name + "%")
          }
        }
      profile {
        if (params.city)
          ilike('currentCity', "%" + params.city + "%")
        if (params.gender.toInteger() > 0)
          eq('gender', params.gender.toInteger())
        if (params.job.toInteger() > 0) {
          if (params.job.toInteger() == 1)
            eq('job', true)
          if (params.job.toInteger() == 2)
            eq('job', false)
        }
        if (params.schoolLevel != 'all')
          eq('schoolLevel', params.schoolLevel.toInteger())
        if (params.size1 != 'all')
          between('size', params.size1.toInteger(), params.size2.toInteger())
        if (params.weight1 != 'all')
          between('weight', params.weight1.toInteger(), params.weight2.toInteger())
        if (params.birthDate1 != 'all')
          between('birthDate', params.birthDate1, params.birthDate2)
      }
      maxResults(30)
    }

    render(template: 'searchresults', model: [allClients: allClients])
  }

}
