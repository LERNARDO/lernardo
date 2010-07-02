package groups

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.ProfileHelperService
import de.uenterprise.ep.EntityHelperService
import standard.MetaDataService
import de.uenterprise.ep.Profile
import standard.FunctionService
import standard.FilterService

class GroupClientProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    ProfileHelperService profileHelperService
    FunctionService functionService
    FilterService filterService

    def index = {
        redirect action:"list", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [groups: Entity.findAllByType(metaDataService.etGroupClient),
                groupTotal: Entity.countByType(metaDataService.etGroupClient),
                entity: entityHelperService.loggedIn]
    }

    def show = {
        def group = Entity.get(params.id)
        Entity entity = params.entity ? group : entityHelperService.loggedIn

        if(!group) {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect(action:list)
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
        if(group) {
            // delete all links
            Link.findAllBySourceOrTarget(group, group).each {it.delete()}
            try {
                flash.message = message(code:"group.deleted", args:[group.profile.fullName])
                group.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"group.notDeleted", args:[group.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity group = Entity.get(params.id)

        if(!group) {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            [group: group, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity group = Entity.get(params.id)

      group.profile.properties = params

      if(!group.hasErrors() && group.save()) {
          flash.message = message(code:"group.updated", args:[group.profile.fullName])
          redirect action:'show', id: group.id
      }
      else {
          render view:'edit', model:[group: group, entity: entityHelperService.loggedIn]
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

        flash.message = message(code:"group.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[group: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

  def addClient = {
    def linking = functionService.linkEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    if (linking.duplicate)
      render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    render template:'clients', model: [clients: linking.results, group: linking.target, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    def breaking = functionService.breakEntities(params.client, params.id, metaDataService.ltGroupMemberClient)
    render template:'clients', model: [clients: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn]
  }

  def updateselect = {
    def allClients = Entity.findAllByType(metaDataService.etClient)
    if (params.name) {
      allClients = filterService.findUsers(params.name, metaDataService.etClient)
    }
    render(template:'searchbox', model:[allClients: allClients])
  }

}
