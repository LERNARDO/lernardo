package groups

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.ProfileHelperService
import de.uenterprise.ep.EntityHelperService
import standard.MetaDataService
import de.uenterprise.ep.Profile

class GroupFamilyProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    ProfileHelperService profileHelperService

    def index = {
        redirect action:"list", params:params
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 10,  100)
        return [groups: Entity.findAllByType(metaDataService.etGroupFamily),
                groupTotal: Entity.countByType(metaDataService.etGroupFamily),
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
          Integer totalLinks = 0
          def allParents = Entity.findAllByType(metaDataService.etParent)
          // find all parents linked to this group
          def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberParent)
          List parents = links.collect {it.source}
          totalLinks += links.size()

          def allClients = Entity.findAllByType(metaDataService.etClient)
          // find all clients linked to this group
          links = Link.findAllByTargetAndType(group, metaDataService.ltGroupFamily)
          List clients = links.collect {it.source}
          totalLinks += links.size()

          def allChilds = Entity.findAllByType(metaDataService.etChild)
          // find all childs linked to this group
          links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberChild)
          List childs = links.collect {it.source}
          totalLinks += links.size()

          return [group: group,
                  entity: entity,
                  parents: parents,
                  allParents: allParents,
                  clients: clients,
                  allClients: allClients,
                  childs: childs,
                  allChilds: allChilds,
                  totalLinks: totalLinks]
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

      if(!group.profile.hasErrors() && group.profile.save()) {
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
      EntityType etGroupFamily = metaDataService.etGroupFamily

      try {
        Entity entity = entityHelperService.createEntity("group", etGroupFamily) {Entity ent ->
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

    def addParent = {
      Entity group = Entity.get(params.id)

      // check if the parent isn't already linked to the group
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.parent))
        eq('target', group)
        eq('type', metaDataService.ltGroupMemberParent)
      }
      if (!link)
        new Link(source:Entity.get(params.parent), target: group, type:metaDataService.ltGroupMemberParent).save()

      // find all parents linked to this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberParent)
      List parents = links.collect {it.source}

      render template:'parents', model: [parents: parents, group: group, entity: entityHelperService.loggedIn]
    }

    def removeParent = {
      Entity group = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.parent))
        eq('target', group)
        eq('type', metaDataService.ltGroupMemberParent)
      }
      link.delete()

      // find all parents linked to this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberParent)
      List parents = links.collect {it.source}

      render template:'parents', model: [parents: parents, group: group, entity: entityHelperService.loggedIn]
    }

  def addClient = {
    Entity group = Entity.get(params.id)

    // check if the client isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.client))
      eq('target', group)
      eq('type', metaDataService.ltGroupFamily)
    }
    if (!link)
      new Link(source:Entity.get(params.client), target: group, type:metaDataService.ltGroupFamily).save()

    // find all clients linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupFamily)
    List clients = links.collect {it.source}

    render template:'clients', model: [clients: clients, group: group, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    Entity group = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.client))
      eq('target', group)
      eq('type', metaDataService.ltGroupFamily)
    }
    link.delete()

    // find all clients linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupFamily)
    List clients = links.collect {it.source}

    render template:'clients', model: [clients: clients, group: group, entity: entityHelperService.loggedIn]
  }

  def addChild = {
    Entity group = Entity.get(params.id)

    // check if the child isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.child))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberChild)
    }
    if (!link)
      new Link(source:Entity.get(params.child), target: group, type:metaDataService.ltGroupMemberChild).save()

    // find all childs linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberChild)
    List childs = links.collect {it.source}

    render template:'childs', model: [childs: childs, group: group, entity: entityHelperService.loggedIn]
  }

  def removeChild = {
    Entity group = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.child))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberChild)
    }
    link.delete()

    // find all child linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberChild)
    List childs = links.collect {it.source}

    render template:'childs', model: [childs: childs, group: group, entity: entityHelperService.loggedIn]
  }

}
