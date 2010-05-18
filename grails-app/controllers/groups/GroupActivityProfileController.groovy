package groups

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.Link
import de.uenterprise.ep.ProfileHelperService
import de.uenterprise.ep.EntityHelperService
import standard.MetaDataService
import de.uenterprise.ep.Profile

class GroupActivityProfileController {
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
        return [groups: Entity.findAllByType(metaDataService.etGroupActivity),
                groupTotal: Entity.countByType(metaDataService.etGroupActivity)]
    }

    def show = {
        def group = Entity.get(params.id)
        Entity entity = params.entity ? group : entityHelperService.loggedIn

        if(!group) {
            flash.message = "groupProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
          List allClientGroups = Entity.findAllByType(metaDataService.etGroupClient)
          // find all clientgroups linked to this group
          def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberClientGroup)
          List clientgroups = links.collect {it.source}

          List allFacilities = Entity.findAllByType(metaDataService.etFacility)
          // find all facilities linked to this group
          links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberFacility)
          List facilities = links.collect {it.source}

          List allPartners = Entity.findAllByType(metaDataService.etPartner)
          // find all partners linked to this group
          links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberPartner)
          List partners = links.collect {it.source}

          List allParents = Entity.findAllByType(metaDataService.etParent)
          // find all parents linked to this group
          links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberParent)
          List parents = links.collect {it.source}

          List allEducators = Entity.findAllByType(metaDataService.etEducator)
          // find all educators linked to this group
          links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberEducator)
          List educators = links.collect {it.source}

          // find all grouptemplates linked to this group
          links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
          List groupTemplates = links.collect {it.source}

          def calculatedDuration = 0
          groupTemplates.each {
            calculatedDuration += it.profile.duration
          }

          return [group: group,
                  entity: entity,
                  templates: groupTemplates,
                  calculatedDuration: calculatedDuration,
                  allEducators: allEducators,
                  educators: educators,
                  allParents: allParents,
                  parents: parents,
                  allPartners: allPartners,
                  partners: partners,
                  allFacilities: allFacilities,
                  facilities: facilities,
                  allClientGroups: allClientGroups,
                  clientgroups: clientgroups]
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

/*      // create links
      def oldEditor = Link.findByTargetAndType(group, metaDataService.ltEditor)
      if (oldEditor)
        oldEditor.delete()
      new Link(source: entityHelperService.loggedIn, target: group, type: metaDataService.ltEditor).save()

      Link.findAllByTargetAndType(group, metaDataService.ltGroupMember).each {
      log.info "group member deleted: "+it
      it.delete()}
      
      def templates = params.templates
      if (templates.class.isArray()) {
        templates.each {
          new Link(source: Entity.get(it), target: group, type: metaDataService.ltGroupMember).save()
        }
      }
      else {
        new Link(source: Entity.get(templates), target: group, type: metaDataService.ltGroupMember).save()
      }*/

      if(!group.hasErrors() && group.save()) {
          flash.message = message(code:"group.updated", args:[group.profile.fullName])
          redirect action:'show', id: group.id
      }
      else {
          render view:'edit', model:[group: group, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
        Entity groupActivityTemplate = Entity.get(params.id)
        return [entity: entityHelperService.loggedIn, template: groupActivityTemplate]
    }

    def save = {
      Entity groupActivityTemplate = Entity.get(params.template)
      EntityType etGroupActivity = metaDataService.etGroupActivity

      try {
        Entity entity = entityHelperService.createEntity("group", etGroupActivity) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
          ent.profile.educationalObjective = ""
          ent.profile.educationalObjectiveText = ""
        }

        // find all templates of this linked to the groupActivityTemplate
        def links = Link.findAllByTargetAndType(groupActivityTemplate, metaDataService.ltGroupMember)
        List templates = links.collect {it.source}

        // and link them to the new groupActivity
        templates.each {
          new Link(source: it, target: entity, type: metaDataService.ltGroupMember).save()
        }
        
/*        // create links
        new Link(source: entityHelperService.loggedIn, target: entity, type: metaDataService.ltCreator).save()
        def templates = params.templates
        if (templates.class.isArray()) {
          templates.each {
            new Link(source: Entity.get(it), target: entity, type: metaDataService.ltGroupMember).save()
          }
        }
        else {
          new Link(source: Entity.get(templates), target: entity, type: metaDataService.ltGroupMember).save()
        }*/

        flash.message = message(code:"group.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[group: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addTemplate = {
      Entity group = Entity.get(params.id)

      // check if the template isn't already linked to the group
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.template))
        eq('target', group)
        eq('type', metaDataService.ltGroupMember)
      }
      if (!link)
        new Link(source:Entity.get(params.template), target: group, type:metaDataService.ltGroupMember).save()

      // find all templates of this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
      List templates = links.collect {it.source}

      def calculatedDuration = 0
      templates.each {
        calculatedDuration += it.profile.duration
      }

      render template:'templates', model: [group: group, templates: templates, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }

    def removeTemplate = {
      Entity group = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.template))
        eq('target', group)
        eq('type', metaDataService.ltGroupMember)
      }
      link.delete()

      // find all templates of this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
      List templates = links.collect {it.source}

      def calculatedDuration = 0
      templates.each {
        calculatedDuration += it.profile.duration
      }

      render template:'templates', model: [group: group, templates: templates, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }

  def addEducator = {
    Entity group = Entity.get(params.id)

    // check if the educator isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.educator))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberEducator)
    }
    if (!link)
      new Link(source:Entity.get(params.educator), target: group, type:metaDataService.ltGroupMemberEducator).save()

    // find all educators linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberEducator)
    List educators = links.collect {it.source}

    render template:'educators', model: [educators: educators, group: group, entity: entityHelperService.loggedIn]
  }

  def removeEducator = {
    Entity group = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.educator))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberEducator)
    }
    link.delete()

    // find all educators linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberEducator)
    List educators = links.collect {it.source}

    render template:'educators', model: [educators: educators, group: group, entity: entityHelperService.loggedIn]
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

  def addPartner = {
    Entity group = Entity.get(params.id)

    // check if the partner isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.partner))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberPartner)
    }
    if (!link)
      new Link(source:Entity.get(params.partner), target: group, type:metaDataService.ltGroupMemberPartner).save()

    // find all partners linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberPartner)
    List partners = links.collect {it.source}

    render template:'partners', model: [partners: partners, group: group, entity: entityHelperService.loggedIn]
  }

  def removePartner = {
    Entity group = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.partner))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberPartner)
    }
    link.delete()

    // find all partners linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberPartner)
    List partners = links.collect {it.source}

    render template:'partners', model: [partners: partners, group: group, entity: entityHelperService.loggedIn]
  }

  def addFacility = {
    Entity group = Entity.get(params.id)

    // check if the facility isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.facility))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberFacility)
    }
    if (!link)
      new Link(source:Entity.get(params.facility), target: group, type:metaDataService.ltGroupMemberFacility).save()

    // find all facilities linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberFacility)
    List facilities = links.collect {it.source}

    render template:'facilities', model: [facilities: facilities, group: group, entity: entityHelperService.loggedIn]
  }

  def removeFacility = {
    Entity group = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.facility))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberFacility)
    }
    link.delete()

    // find all facilities linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberFacility)
    List facilities = links.collect {it.source}

    render template:'facilities', model: [facilities: facilities, group: group, entity: entityHelperService.loggedIn]
  }

  def addClientGroup = {
    Entity group = Entity.get(params.id)

    // check if the clientgroup isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.clientgroup))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberClientGroup)
    }
    if (!link)
      new Link(source:Entity.get(params.clientgroup), target: group, type:metaDataService.ltGroupMemberClientGroup).save()

    // find all clientgroups linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberClientGroup)
    List clientgroups = links.collect {it.source}

    render template:'clientgroups', model: [clientgroups: clientgroups, group: group, entity: entityHelperService.loggedIn]
  }

  def removeClientGroup = {
    Entity group = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.clientgroup))
      eq('target', group)
      eq('type', metaDataService.ltGroupMemberClientGroup)
    }
    link.delete()

    // find all clientgroups linked to this group
    def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMemberClientGroup)
    List clientgroups = links.collect {it.source}

    render template:'clientgroups', model: [clientgroups: clientgroups, group: group, entity: entityHelperService.loggedIn]
  }
}
