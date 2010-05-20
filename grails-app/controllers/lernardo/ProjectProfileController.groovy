package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.EntityHelperService
import de.uenterprise.ep.ProfileHelperService
import standard.MetaDataService
import de.uenterprise.ep.Profile
import de.uenterprise.ep.Link
import java.text.SimpleDateFormat

class ProjectProfileController {
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
        return[projectList: Entity.findAllByType(metaDataService.etProject),
               projectTotal: Entity.countByType(metaDataService.etProject)]
    }

    def show = {
        Entity project = Entity.get( params.id )

        if(!project) {
            flash.message = "projectProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            // find projectTemplate of this project
            Entity template = Link.findByTargetAndType(project, metaDataService.ltProjectTemplate).source

            // find all units linked to the template
            def links = Link.findAllByTargetAndType(template, metaDataService.ltProjectUnit)
            List units = links.collect {it.source}

            def allFacilities = Entity.findAllByType(metaDataService.etFacility)
            // find all facilities linked to this group
            links = Link.findAllByTargetAndType(project, metaDataService.ltGroupMemberFacility)
            List facilities = links.collect {it.source}

            def allClients = Entity.findAllByType(metaDataService.etClient)
            // find all clients linked to this group
            links = Link.findAllByTargetAndType(project, metaDataService.ltGroupMemberClient)
            List clients = links.collect {it.source}

            // get all resources
            def allResources = Entity.findAllByType(metaDataService.etResource)

             // get all educators
            def allEducators = Entity.findAllByType(metaDataService.etEducator)

             // get all parents
            def allParents = Entity.findAllByType(metaDataService.etParent)

             // get all partners
            def allPartners = Entity.findAllByType(metaDataService.etPartner)

            // find all projectdays linked to this project
            links = Link.findAllByTargetAndType(project, metaDataService.ltProjectMember)
            List projectDays = links.collect {it.source}

            // find all projectUnits linked to this project
            links = Link.findAllByTargetAndType(project, metaDataService.ltProjectUnit)
            List projectUnits = links.collect {it.source}

            List allGroupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

            // calculate realDuration
            Integer calculatedDuration = calculateDuration(projectUnits)

            [project: project,
             entity: entityHelperService.loggedIn,
             projectUnits: projectUnits,
             allGroupActivityTemplates: allGroupActivityTemplates,
             calculatedDuration: calculatedDuration,
             clients: clients,
             allClients: allClients,
             projectDays: projectDays,
             template: template,
             allFacilities: allFacilities,
             facilities: facilities,
             allResources: allResources,
             allEducators: allEducators,
             units: units,
             allParents: allParents,
             allPartners: allPartners]
        }
    }

    def del = {
        Entity project = Entity.get(params.id)
        if(project) {
            try {
                flash.message = message(code:"project.deleted", args:[project.profile.fullName])
                project.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"project.notDeleted", args:[project.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "projectProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity project = Entity.get(params.id)

        if(!project) {
            flash.message = "projectProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            [project: project, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity project = Entity.get(params.id)

      project.profile.properties = params
      
      if(!project.profile.hasErrors() && project.profile.save()) {
          flash.message = message(code:"project.updated", args:[project.profile.fullName])
          redirect action:'show', id: project.id
      }
      else {
          render view:'edit', model:[project: project, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
      Entity projectTemplate = Entity.get(params.id)
      return [entity: entityHelperService.loggedIn, template: projectTemplate]
    }

    def save = {
      EntityType etProject = metaDataService.etProject

      try {
        Entity entity = entityHelperService.createEntity("project", etProject) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
        }
        flash.message = message(code:"project.created", args:[entity.profile.fullName])

        // create link to template
        new Link(source:Entity.get(params.id), target: entity, type: metaDataService.ltProjectTemplate).save()

        // create project days
        Date periodStart = params.startDate
        Date periodEnd = params.endDate

        Calendar calendarStart = new GregorianCalendar();
        calendarStart.setTime( periodStart );

        Calendar calendarEnd = new GregorianCalendar();
        calendarEnd.setTime( periodEnd );

        SimpleDateFormat df = new SimpleDateFormat("EEEE")

        // loop through the date range and compare the dates day with the params
        while (calendarStart <= calendarEnd) {
          Date currentDate = calendarStart.getTime();
          //log.info df.format(currentDate)

          if ((params.monday && df.format(currentDate) == 'Montag') ||
              (params.tuesday && df.format(currentDate) == 'Dienstag') ||
              (params.wednesday && df.format(currentDate) == 'Mittwoch') ||
              (params.thursday && df.format(currentDate) == 'Donnerstag') ||
              (params.friday && df.format(currentDate) == 'Freitag') ||
              (params.saturday && df.format(currentDate) == 'Samstag') ||
              (params.sunday && df.format(currentDate) == 'Sonntag')) {
              //log.info "found"

              EntityType etProjectDay = metaDataService.etProjectDay
              Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.date = currentDate
                ent.profile.fullName = params.fullName
              }

              if (df.format(currentDate) == 'Montag') {
                projectDay.profile.date.setHours(params.int('mondayStartHour'))
                projectDay.profile.date.setMinutes(params.int('mondayStartMinute'))
              }
              if (df.format(currentDate) == 'Dienstag') {
                projectDay.profile.date.setHours(params.int('tuesdayStartHour'))
                projectDay.profile.date.setMinutes(params.int('tuesdayStartMinute'))
              }
              if (df.format(currentDate) == 'Mittwoch') {
                projectDay.profile.date.setHours(params.int('wednesdayStartHour'))
                projectDay.profile.date.setMinutes(params.int('wednesdayStartMinute'))
              }
              if (df.format(currentDate) == 'Donnerstag') {
                projectDay.profile.date.setHours(params.int('thursdayStartHour'))
                projectDay.profile.date.setMinutes(params.int('thursdayStartMinute'))
              }
               if (df.format(currentDate) == 'Freitag') {
                projectDay.profile.date.setHours(params.int('fridayStartHour'))
                projectDay.profile.date.setMinutes(params.int('fridayStartMinute'))
              }
              if (df.format(currentDate) == 'Samstag') {
                projectDay.profile.date.setHours(params.int('saturdayStartHour'))
                projectDay.profile.date.setMinutes(params.int('saturdayStartMinute'))
              }
              if (df.format(currentDate) == 'Sonntag') {
                projectDay.profile.date.setHours(params.int('sundayStartHour'))
                projectDay.profile.date.setMinutes(params.int('sundayStartMinute'))
              }

              new Link(source: projectDay, target: entity, type: metaDataService.ltProjectMember).save()

          }

          // increment calendar
          calendarStart.add(Calendar.DATE, 1)
        }
        
        redirect action:'list'
        
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[project: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addUnit = {
      Entity projectDay = Entity.get(params.id)

      // create a new unit and copy the properties from the unit template
      EntityType etProjectUnit = metaDataService.etProjectUnit
      Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.fullName = "Einheit"
      }

      Entity projectUnitTemplate = Entity.get(params.unit)
      //projectUnit.properties = projectUnitTemplate.properties

      // link the new unit to the project
      new Link(source: projectUnit, target: projectDay, type:metaDataService.ltProjectDayUnit).save()

      // create activity instances that are linked to the projectUnit that are created from activitytemplates
      // linked to the projectUnitTemplates

      // first find all activity template groups linked to the project unit template
      def results = Link.findAllByTargetAndType(projectUnitTemplate, metaDataService.ltProjectUnitMember)
      List groups = results.collect {it.source}

      List activitytemplates = []

      // then find all activity templates linked to the groups
      groups.each {
        results = Link.findAllByTargetAndType(it, metaDataService.ltGroupMember)

        results.each { bla ->
          activitytemplates << bla.source
        }
      }

      // create an activity instance of each activity template
      activitytemplates.each {
        EntityType etActivity = metaDataService.etActivity
        Entity activity = entityHelperService.createEntity("activity", etActivity) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.date = new Date()
          ent.profile.fullName = it.profile.fullName
          ent.profile.duration = it.profile.duration
        }
        /*if (df.format(currentDate) == 'Montag') {
          ent.profile.date.setHours(params.int('mondayStartHour'))
          ent.profile.date.setMinutes(params.int('mondayStartMinute'))
          ent.profile.duration = (params.int('mondayEndHour') - params.int('mondayStartHour')) * 60 + (params.int('mondayEndMinute') - params.int('mondayStartMinute'))
        }*/

        // link it to the project unit
        new Link(source: activity, target: projectUnit, type: metaDataService.ltProjectUnit).save()
      }

      // previous stuff
      // check if the unit isn't already linked to the projectDay
      /*def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.unit))
        eq('target', projectDay)
        eq('type', metaDataService.ltProjectDayUnit)
      }
      if (!link)
        new Link(source:Entity.get(params.unit), target: projectDay, type:metaDataService.ltProjectDayUnit).save()*/

      // find all units linked to this projectDay
      def links = Link.findAllByTargetAndType(projectDay, metaDataService.ltProjectDayUnit)
      List units = links.collect {it.source}

      render template:'units', model: [units: units, projectDay: projectDay, entity: entityHelperService.loggedIn]

    }

    def removeUnit = {
      Entity projectDay = Entity.get(params.id)

      // delete link
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.unit))
        eq('target', projectDay)
        eq('type', metaDataService.ltProjectDayUnit)
      }
      link.delete()

      // find all activities linking to this unit
      def links = Link.findAllByTargetAndType(Entity.get(params.unit), metaDataService.ltProjectUnit)
      List activities = links.collect {it.source}

      // delete all links to the unit
      links.each {
        it.delete()
      }

      // delete all links to the activities and the activities themselves
      activities.each {
        links = Link.findAllBySourceOrTarget(it, it)
        links.each {it.delete()}
        it.delete()
      }
             
      // delete projectUnit
      Entity.get(params.unit).delete()

      // find all projectunits of this project
      links = Link.findAllByTargetAndType(projectDay, metaDataService.ltProjectDayUnit)
      List units = links.collect {it.source}

      render template:'units', model: [units: units, projectDay: projectDay, entity: entityHelperService.loggedIn]
    }

    def addGroupActivityTemplate = {
      Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
      Entity projectUnit = Entity.get(params.projectUnit)
      Entity project = Entity.get(params.id)

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

      // find all projectunits of this project
      def links = Link.findAllByTargetAndType(project, metaDataService.ltProjectUnit)
      List projectUnits = links.collect {it.source}

      // calculate realDuration
       Integer calculatedDuration = calculateDuration(projectUnits)

      render template:'projectUnits', model: [projectUnits: projectUnits, project: project, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }

    def removeGroupActivityTemplate = {
      Entity groupActivityTemplate = Entity.get(params.groupActivityTemplate)
      Entity projectUnit = Entity.get(params.projectUnit)
      Entity project = Entity.get(params.id)

      // delete link
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', groupActivityTemplate)
        eq('target', projectUnit)
        eq('type', metaDataService.ltProjectUnitMember)
      }
      link.delete()

      // find all projectunits of this project
      def links = Link.findAllByTargetAndType(project, metaDataService.ltProjectUnit)
      List projectUnits = links.collect {it.source}

      // calculate realDuration
      Integer calculatedDuration = calculateDuration(projectUnits)

      render template:'projectUnits', model: [projectUnits: projectUnits, project: project, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
    }

    Integer calculateDuration(List projectUnits) {
      // find all groupActivityTemplates linked to all projectUnits of this project
      List groupActivityTemplates = []

      projectUnits.each {
          def links = Link.findAllByTargetAndType (it, metaDataService.ltProjectUnitMember)
          if (links.size > 0)
            groupActivityTemplates << links.collect { bla -> bla.source}
      }

      def calculatedDuration = 0
      groupActivityTemplates.each {
        calculatedDuration += it.profile.realDuration
      }

      return calculatedDuration
    }

  def addClient = {
    Entity project = Entity.get(params.id)

    // check if the client isn't already linked to the group
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.client))
      eq('target', project)
      eq('type', metaDataService.ltGroupMemberClient)
    }
    if (!link)
      new Link(source:Entity.get(params.client), target: project, type:metaDataService.ltGroupMemberClient).save()

    // find all clients linked to this project
    def links = Link.findAllByTargetAndType(project, metaDataService.ltGroupMemberClient)
    List clients = links.collect {it.source}

    render template:'clients', model: [clients: clients, project: project, entity: entityHelperService.loggedIn]
  }

  def removeClient = {
    Entity project = Entity.get(params.id)

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', Entity.get(params.client))
      eq('target', project)
      eq('type', metaDataService.ltGroupMemberClient)
    }
    link.delete()

    // find all clients linked to this project
    def links = Link.findAllByTargetAndType(project, metaDataService.ltGroupMemberClient)
    List clients = links.collect {it.source}

    render template:'clients', model: [clients: clients, project: project, entity: entityHelperService.loggedIn]
  }

    def addFacility = {
      Entity project = Entity.get(params.id)

      // check if the facility isn't already linked to the project
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.facility))
        eq('target', project)
        eq('type', metaDataService.ltGroupMemberFacility)
      }
      if (!link)
        new Link(source:Entity.get(params.facility), target: project, type:metaDataService.ltGroupMemberFacility).save()

      // find all facilities linked to this project
      def links = Link.findAllByTargetAndType(project, metaDataService.ltGroupMemberFacility)
      List facilities = links.collect {it.source}

      render template:'facilities', model: [facilities: facilities, project: project, entity: entityHelperService.loggedIn]
    }

    def removeFacility = {
      Entity project = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.facility))
        eq('target', project)
        eq('type', metaDataService.ltGroupMemberFacility)
      }
      link.delete()

      // find all facilities linked to this project
      def links = Link.findAllByTargetAndType(project, metaDataService.ltGroupMemberFacility)
      List facilities = links.collect {it.source}

      render template:'facilities', model: [facilities: facilities, project: project, entity: entityHelperService.loggedIn]
    }

    def addResource = {
      Entity projectDay = Entity.get(params.id)

      // check if the facility isn't already linked to the project
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.resource))
        eq('target', projectDay)
        eq('type', metaDataService.ltProjectDayResource)
      }
      if (!link)
        new Link(source:Entity.get(params.resource), target: projectDay, type:metaDataService.ltProjectDayResource).save()

      // find all resources linked to this project
      def links = Link.findAllByTargetAndType(projectDay, metaDataService.ltProjectDayResource)
      List resources = links.collect {it.source}

      render template:'resources', model: [resources: resources, projectDay: projectDay, entity: entityHelperService.loggedIn, j: params.j]
    }

    def removeResource = {
      Entity projectDay = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.resource))
        eq('target', projectDay)
        eq('type', metaDataService.ltProjectDayResource)
      }
      link.delete()

      // find all resources linked to this project
      def links = Link.findAllByTargetAndType(projectDay, metaDataService.ltProjectDayResource)
      List resources = links.collect {it.source}

      render template:'resources', model: [resources: resources, projectDay: projectDay, entity: entityHelperService.loggedIn]
    }

    def addEducator = {
      Entity projectDay = Entity.get(params.id)

      // check if the facility isn't already linked to the project
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.educator))
        eq('target', projectDay)
        eq('type', metaDataService.ltProjectDayEducator)
      }
      if (!link)
        new Link(source:Entity.get(params.educator), target: projectDay, type:metaDataService.ltProjectDayEducator).save()

      // find all resources linked to this project
      def links = Link.findAllByTargetAndType(projectDay, metaDataService.ltProjectDayEducator)
      List educators = links.collect {it.source}

      render template:'educators', model: [educators: educators, projectDay: projectDay, entity: entityHelperService.loggedIn, j: params.j]
    }

    def removeEducator = {
      Entity projectDay = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.educator))
        eq('target', projectDay)
        eq('type', metaDataService.ltProjectDayEducator)
      }
      link.delete()

      // find all resources linked to this project
      def links = Link.findAllByTargetAndType(projectDay, metaDataService.ltProjectDayEducator)
      List educators = links.collect {it.source}

      render template:'educators', model: [educators: educators, projectDay: projectDay, entity: entityHelperService.loggedIn]
    }

    def addParent = {
      Entity projectUnit = Entity.get(params.id)

      // check if the parent isn't already linked to the project
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.parent))
        eq('target', projectUnit)
        eq('type', metaDataService.ltProjectUnitParent)
      }
      if (!link)
        new Link(source:Entity.get(params.parent), target: projectUnit, type:metaDataService.ltProjectUnitParent).save()

      // find all parents linked to this project
      def links = Link.findAllByTargetAndType(projectUnit, metaDataService.ltProjectUnitParent)
      List parents = links.collect {it.source}

      render template:'parents', model: [parents: parents, unit: projectUnit, entity: entityHelperService.loggedIn, i: params.i, j:params.j]
    }

    def removeParent = {
      Entity projectUnit = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.parent))
        eq('target', projectUnit)
        eq('type', metaDataService.ltProjectUnitParent)
      }
      link.delete()

      // find all parents linked to this project
      def links = Link.findAllByTargetAndType(projectUnit, metaDataService.ltProjectUnitParent)
      List parents = links.collect {it.source}

      render template:'parents', model: [parents: parents, unit: projectUnit, entity: entityHelperService.loggedIn]
    }

    def addPartner = {
      Entity projectUnit = Entity.get(params.id)

      // check if the partner isn't already linked to the project
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.partner))
        eq('target', projectUnit)
        eq('type', metaDataService.ltProjectUnitPartner)
      }
      if (!link)
        new Link(source:Entity.get(params.partner), target: projectUnit, type:metaDataService.ltProjectUnitPartner).save()

      // find all partners linked to this project
      def links = Link.findAllByTargetAndType(projectUnit, metaDataService.ltProjectUnitPartner)
      List partners = links.collect {it.source}

      render template:'partners', model: [partners: partners, unit: projectUnit, entity: entityHelperService.loggedIn, i: params.i, j:params.j]
    }

    def removePartner = {
      Entity projectUnit = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.partner))
        eq('target', projectUnit)
        eq('type', metaDataService.ltProjectUnitPartner)
      }
      link.delete()

      // find all resources linked to this project
      def links = Link.findAllByTargetAndType(projectUnit, metaDataService.ltProjectUnitPartner)
      List partners = links.collect {it.source}

      render template:'partners', model: [partners: partners, unit: projectUnit, entity: entityHelperService.loggedIn]
    }
}


