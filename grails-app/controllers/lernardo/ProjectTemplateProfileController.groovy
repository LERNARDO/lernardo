package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.EntityHelperService
import de.uenterprise.ep.ProfileHelperService
import standard.MetaDataService
import de.uenterprise.ep.Profile
import de.uenterprise.ep.Link

class ProjectTemplateProfileController {
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    ProfileHelperService profileHelperService
    
    def index = {
        redirect action:"list", params:params 
    }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.int('max') : 20,  100)
        return[projectTemplateList: Entity.findAllByType(metaDataService.etProjectTemplate),
               projectTemplateTotal: Entity.countByType(metaDataService.etProjectTemplate),
               entity: entityHelperService.loggedIn]
    }

    def show = {
        Entity projectTemplate = Entity.get( params.id )
        Entity entity = params.entity ? projectTemplate : entityHelperService.loggedIn

        if(!projectTemplate) {
            flash.message = "projectTemplateProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            // find all projectUnits linked to this projectTemplate
            def links = Link.findAllByTargetAndType(projectTemplate, metaDataService.ltProjectUnit)
            List projectUnits = links.collect {it.source}

            //List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

            // get all groupactivitytemplates that are set to completed
            def c = Entity.createCriteria()
            def allGroupActivityTemplates = c.list {
               eq("type", metaDataService.etGroupActivityTemplate)
               profile {
                  eq("status", "fertig")
               }
            }

            // calculate realDuration
            Integer calculatedDuration = calculateDuration(projectUnits)

            [projectTemplate: projectTemplate,
             entity: entity,
             projectUnits: projectUnits,
             allGroupActivityTemplates: allGroupActivityTemplates,
             calculatedDuration: calculatedDuration]
        }
    }

    def del = {
        Entity projectTemplate = Entity.get(params.id)
        if(projectTemplate) {
            try {
                flash.message = message(code:"projectTemplate.deleted", args:[projectTemplate.profile.fullName])
                projectTemplate.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"projectTemplate.notDeleted", args:[projectTemplate.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "projectTemplateProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity projectTemplate = Entity.get(params.id)

        if(!projectTemplate) {
            flash.message = "projectTemplateProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            [projectTemplate: projectTemplate, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity projectTemplate = Entity.get(params.id)

      projectTemplate.profile.properties = params
      
      if(!projectTemplate.profile.hasErrors() && projectTemplate.profile.save()) {
          flash.message = message(code:"projectTemplate.updated", args:[projectTemplate.profile.fullName])
          redirect action:'show', id: projectTemplate.id
      }
      else {
          render view:'edit', model:[projectTemplate: projectTemplate, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
      Entity projectTemplate = Entity.get(params.id)
      return [entity: entityHelperService.loggedIn,
              projectTemplate: projectTemplate]
    }

    def save = {
      EntityType etProjectTemplate = metaDataService.etProjectTemplate

      try {
        Entity entity = entityHelperService.createEntity("projectTemplate", etProjectTemplate) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
        }
        flash.message = message(code:"projectTemplate.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[projectTemplate: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addProjectUnit = {
      Entity projectTemplate = Entity.get(params.id)

      try {
        // create projectUnit
        EntityType etProjectUnit = metaDataService.etProjectUnit
        Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
        }

        // link projectUnit and projectTemplate
        new Link(source: projectUnit, target: projectTemplate, type:metaDataService.ltProjectUnit).save()

        // find all projectunits of this projectTemplate
        def links = Link.findAllByTargetAndType(projectTemplate, metaDataService.ltProjectUnit)
        List projectUnits = links.collect {it.source}

        List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

        render template:'projectUnits', model: [allGroupActivityTemplates: allGroupActivityTemplates, projectUnits: projectUnits, projectTemplate: projectTemplate, entity: entityHelperService.loggedIn]        
      } catch (de.uenterprise.ep.EntityException ee) {
      render "Projekteinheit konnte nicht gespeichert werden!"
      return
    }
}

    def removeProjectUnit = {
      Entity projectTemplate = Entity.get(params.id)

      // delete link
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.projectUnit))
        eq('target', projectTemplate)
        eq('type', metaDataService.ltProjectUnit)
      }
      link.delete()

      def blocks = Link.findAllByTargetAndType(Entity.get(params.projectUnit), metaDataService.ltProjectUnitMember)
      if (blocks)
        blocks.each {it.delete()}

      // delete projectUnit
      Entity.get(params.projectUnit).delete()

      // find all projectunits of this projectTemplate
      def links = Link.findAllByTargetAndType(projectTemplate, metaDataService.ltProjectUnit)
      List projectUnits = links.collect {it.source}

      render template:'projectUnits', model: [projectUnits: projectUnits, projectTemplate: projectTemplate, entity: entityHelperService.loggedIn]
    }

    def addGroupActivityTemplate = {
      Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
      Entity projectUnit = Entity.get(params.id)
      //Entity projectTemplate = Entity.get(params.id)

      // check if the groupActivityTemplate isn't already linked to the projectUnit
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', groupActivityTemplate)
        eq('target', projectUnit)
        eq('type', metaDataService.ltProjectUnitMember)
      }
      if (!link)
        // link groupActivityTemplate to projectUnit
        new Link(source: groupActivityTemplate, target: projectUnit, type:metaDataService.ltProjectUnitMember).save()

      // find all groupActivityTemplates linked to the unit
      def links = Link.findAllByTargetAndType(projectUnit, metaDataService.ltProjectUnitMember)
      List groupActivityTemplates = links.collect {it.source}

      // find all projectunits of this projectTemplate
      //def links = Link.findAllByTargetAndType(projectTemplate, metaDataService.ltProjectUnit)
     // List projectUnits = links.collect {it.source}

      // calculate realDuration
       //Integer calculatedDuration = calculateDuration(projectUnits)

      render template:'groupActivityTemplates', model: [groupActivityTemplates: groupActivityTemplates, unit: projectUnit, entity: entityHelperService.loggedIn, i: params.i]
    }

    def removeGroupActivityTemplate = {
      Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
      Entity projectUnit = Entity.get(params.id)
      //Entity projectTemplate = Entity.get(params.id)

      // delete link
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', groupActivityTemplate)
        eq('target', projectUnit)
        eq('type', metaDataService.ltProjectUnitMember)
      }
      link.delete()

      // find all groupActivityTemplates linked to the unit
      def links = Link.findAllByTargetAndType(projectUnit, metaDataService.ltProjectUnitMember)
      List groupActivityTemplates = links.collect {it.source}

      // find all projectunits of this projectTemplate
      //def links = Link.findAllByTargetAndType(projectTemplate, metaDataService.ltProjectUnit)
      //List projectUnits = links.collect {it.source}

      // calculate realDuration
      //Integer calculatedDuration = calculateDuration(projectUnits)

      render template:'groupActivityTemplates', model: [groupActivityTemplates: groupActivityTemplates, unit: projectUnit, entity: entityHelperService.loggedIn, i: params.i]
    }

    Integer calculateDuration(List projectUnits) {
      // find all groupActivityTemplates linked to all projectUnits of this projectTemplate
      List groupActivityTemplates = []

      projectUnits.each {
          def links = Link.findAllByTargetAndType (it, metaDataService.ltProjectUnitMember)
          if (links.size > 0)
            groupActivityTemplates.addAll(links.collect {bla -> bla.source})
      }

      def calculatedDuration = 0
      groupActivityTemplates.each {
        calculatedDuration += it.profile.realDuration
      }

      return calculatedDuration
    }
}


