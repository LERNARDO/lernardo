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
               projectTotal: Entity.countByType(metaDataService.etProject),
               entity: entityHelperService.loggedIn]
    }

    def show = {
        Entity project = Entity.get( params.id )
        Entity entity = params.entity ? project : entityHelperService.loggedIn

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
             entity: entity,
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
      log.info params
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

          if ((params.monday && (df.format(currentDate) == 'Montag' || df.format(currentDate) == 'Monday')) ||
              (params.tuesday && (df.format(currentDate) == 'Dienstag' || df.format(currentDate) == 'Tuesday')) ||
              (params.wednesday && (df.format(currentDate) == 'Mittwoch' || df.format(currentDate) == 'Wednesday')) ||
              (params.thursday && (df.format(currentDate) == 'Donnerstag' || df.format(currentDate) == 'Thursday')) ||
              (params.friday && (df.format(currentDate) == 'Freitag' || df.format(currentDate) == 'Friday')) ||
              (params.saturday && (df.format(currentDate) == 'Samstag' || df.format(currentDate) == 'Saturday')) ||
              (params.sunday && (df.format(currentDate) == 'Sonntag' || df.format(currentDate) == 'Sunday'))) {
              //log.info "found"

            if (df.format(currentDate) == 'Montag' || df.format(currentDate) == 'Monday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.int('mondayStartHour'))
                calendarStart.set(Calendar.MINUTE, params.int('mondayStartMinute'))
                //projectDay.profile.date.setHours(params.int('mondayStartHour'))
                //projectDay.profile.date.setMinutes(params.int('mondayStartMinute'))
              }
              else if (df.format(currentDate) == 'Dienstag' || df.format(currentDate) == 'Tuesday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.int('tuesdayStartHour'))
                calendarStart.set(Calendar.MINUTE, params.int('tuesdayStartMinute'))
              }
              else if (df.format(currentDate) == 'Mittwoch' || df.format(currentDate) == 'Wednesday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.int('wednesdayStartHour'))
                calendarStart.set(Calendar.MINUTE, params.int('wednesdayStartMinute'))
              }
              else if (df.format(currentDate) == 'Donnerstag' || df.format(currentDate) == 'Thursday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.int('thursdayStartHour'))
                calendarStart.set(Calendar.MINUTE, params.int('thursdayStartMinute'))
              }
              else if (df.format(currentDate) == 'Freitag' || df.format(currentDate) == 'Friday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.int('fridayStartHour'))
                calendarStart.set(Calendar.MINUTE, params.int('fridayStartMinute'))
              }
              else if (df.format(currentDate) == 'Samstag' || df.format(currentDate) == 'Saturday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.int('saturdayStartHour'))
                calendarStart.set(Calendar.MINUTE, params.int('saturdayStartMinute'))
              }
              else if (df.format(currentDate) == 'Sonntag' || df.format(currentDate) == 'Sunday') {
                calendarStart.set(Calendar.HOUR_OF_DAY, params.int('sundayStartHour'))
                calendarStart.set(Calendar.MINUTE, params.int('sundayStartMinute'))
              }
            
              // create project day
              EntityType etProjectDay = metaDataService.etProjectDay
              Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.date = calendarStart.getTime();
                ent.profile.fullName = params.fullName
              }

              log.info projectDay.profile.date

              /*if (df.format(currentDate) == 'Montag' || df.format(currentDate) == 'Monday') {
                projectDay.profile.date.setHours(params.int('mondayStartHour'))
                projectDay.profile.date.setMinutes(params.int('mondayStartMinute'))
              }
              else if (df.format(currentDate) == 'Dienstag' || df.format(currentDate) == 'Tuesday') {
                projectDay.profile.date.setHours(params.int('tuesdayStartHour'))
                projectDay.profile.date.setMinutes(params.int('tuesdayStartMinute'))
              }
              else if (df.format(currentDate) == 'Mittwoch' || df.format(currentDate) == 'Wednesday') {
                projectDay.profile.date.setHours(params.int('wednesdayStartHour'))
                projectDay.profile.date.setMinutes(params.int('wednesdayStartMinute'))
              }
              else if (df.format(currentDate) == 'Donnerstag' || df.format(currentDate) == 'Thursday') {
                projectDay.profile.date.setHours(params.int('thursdayStartHour'))
                projectDay.profile.date.setMinutes(params.int('thursdayStartMinute'))
              }
              else if (df.format(currentDate) == 'Freitag' || df.format(currentDate) == 'Friday') {
                projectDay.profile.date.setHours(params.int('fridayStartHour'))
                projectDay.profile.date.setMinutes(params.int('fridayStartMinute'))
              }
              else if (df.format(currentDate) == 'Samstag' || df.format(currentDate) == 'Saturday') {
                projectDay.profile.date.setHours(params.int('saturdayStartHour'))
                projectDay.profile.date.setMinutes(params.int('saturdayStartMinute'))
              }
              else if (df.format(currentDate) == 'Sonntag' || df.format(currentDate) == 'Sunday') {
                projectDay.profile.date.setHours(params.int('sundayStartHour'))
                projectDay.profile.date.setMinutes(params.int('sundayStartMinute'))
              }*/
              log.info projectDay.profile.date

              // TODO: figure out why hours and minutes are saved but later on not saved anymore?!

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

      // link each group to the project unit
      groups.each {
        new Link(source: it, target: projectUnit, type: metaDataService.ltProjectUnit).save()
      }
/*      List activitytemplates = []

      // then find all activity templates linked to the groups
      groups.each {
        results = Link.findAllByTargetAndType(it, metaDataService.ltGroupMember)

        results.each { bla ->
          activitytemplates << bla.source
        }
      }*/

      // DO THIS AT A LATER POINT WITH THE SUBMIT BUTTON
      // create an activity instance of each activity template
     /* activitytemplates.each {
        EntityType etActivity = metaDataService.etActivity
        Entity activity = entityHelperService.createEntity("activity", etActivity) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.date = new Date()
          ent.profile.fullName = it.profile.fullName
          ent.profile.duration = it.profile.duration
        }*/
        /*if (df.format(currentDate) == 'Montag') {
          ent.profile.date.setHours(params.int('mondayStartHour'))
          ent.profile.date.setMinutes(params.int('mondayStartMinute'))
          ent.profile.duration = (params.int('mondayEndHour') - params.int('mondayStartHour')) * 60 + (params.int('mondayEndMinute') - params.int('mondayStartMinute'))
        }*/

        // link it to the project unit
        //new Link(source: activity, target: projectUnit, type: metaDataService.ltProjectUnit).save()
      //}

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

      render template:'units', model: [units: units, projectDay: projectDay, entity: entityHelperService.loggedIn, j: params.j]

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
      /*activities.each {
        links = Link.findAllBySourceOrTarget(it, it)
        links.each {it.delete()}
        it.delete()
      }*/
             
      // delete projectUnit
      Entity.get(params.unit).delete()

      // find all projectunits of this project
      links = Link.findAllByTargetAndType(projectDay, metaDataService.ltProjectDayUnit)
      List units = links.collect {it.source}

      render template:'units', model: [units: units, projectDay: projectDay, entity: entityHelperService.loggedIn, j: params.j]
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

      render template:'resources', model: [resources: resources, projectDay: projectDay, entity: entityHelperService.loggedIn, j: params.j]
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

      render template:'educators', model: [educators: educators, projectDay: projectDay, entity: entityHelperService.loggedIn, j: params.j]
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

      render template:'parents', model: [parents: parents, unit: projectUnit, entity: entityHelperService.loggedIn, i: params.i, j:params.j]
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

      render template:'partners', model: [partners: partners, unit: projectUnit, entity: entityHelperService.loggedIn, i: params.i, j:params.j]
    }

    // this action takes a project and creates all activities
    def execute = {
      render "<span class='red'>Bitte warten.. Aktivitäten werden instanziert!</span><br/>"
      Entity project = Entity.get(params.id)

      // make sure the project has clients and a facility
      /*def links = Link.findAllByTargetAndType(project,metaDataService.ltGroupMemberFacility)
      def links2 = Link.findAllByTargetAndType(project,metaDataService.ltGroupMemberClient)
      if (!links || links2) {
        redirect action: 'show', id: project.id
        return
      }*/

      // make sure each unit in each project day has activity template groups added, otherwise there
      // would be nothing to instantiate

      // 1. find all projectDays belonging to the project
      def links = Link.findAllByTargetAndType(project,metaDataService.ltProjectMember)
      List projectDays = links.collect {it.source}
      log.info "Projekttage: " + projectDays.size()

      // 2. loop through each projectDay and find all projectUnits

      List projectUnits = []
      projectDays.each {
        links = Link.findAllByTargetAndType(it,metaDataService.ltProjectDayUnit)
        if (links.size() == 0) {
          render "<span class='red'>Projekt konnte nicht instanziert werden, es fehlen Projekteinheiten</span>"

          // figure out why this won't "return"
          return
        }
        links.each {
          projectUnits << it.source 
        }
      }
      //log.info "Projekteinheiten: " + projectUnits.size()

      // now we know that every projectDay has projectUnits and templates so we continue

      // delete all current project activities that have not started yet
      links = Link.findAllByTargetAndType(project, metaDataService.ltActProject)
      List activities = links.collect {it.source}

      log.info "Found " + activities.size() + " existing activities"
      render "Es werden " + activities.size() + " vorhande Aktivitäten aktualisiert!<br/>"

      if (activities) {
        activities.each {
          if (new Date() < it.profile.date) {
            links = Link.findAllBySourceOrTarget(it,it)
            links.each {it.delete()}
          }
          it.delete()
        }
      }

      // then do the big loop
      log.info "Starting big loop"
      projectDays.each { pd ->
        links = Link.findAllByTargetAndType(pd,metaDataService.ltProjectDayUnit)
        projectUnits = links.collect {it.source}

        log.info "Projekteinheiten: " + projectUnits.size()

        // 3. loop through each projectUnit and find all activity template groups
        projectUnits.each { pu ->
          links = Link.findAllByTargetAndType(pu,metaDataService.ltProjectUnit)
          List groups = links.collect {it.source}

          Date currentDate = pd.profile.date
          Calendar calendar = new GregorianCalendar()
          calendar.setTime( currentDate )

          // 4. find all activity templates of each group
          groups.each { pg ->
            links = Link.findAllByTargetAndType(pg,metaDataService.ltGroupMember)
            List templates = links.collect {it.source}

            // 5. instantiate all activities from the list of templates
            templates.each {
              EntityType etActivity = metaDataService.etActivity
              Entity activity = entityHelperService.createEntity("activity", etActivity) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                ent.profile.type = "Projekt"
                ent.profile.date = calendar.getTime()
                ent.profile.fullName = it.profile.fullName
                ent.profile.duration = it.profile.duration
              }

              // TODO: create links here!!
              // link this project activity to the project
              new Link(source: activity, target: project, type: metaDataService.ltActProject).save()

              // link facility to activity
              def link = Link.findByTargetAndType(project, metaDataService.ltGroupMemberFacility)
              if (link) {
                Entity facility = link.source
                new Link(source: facility, target: activity, type: metaDataService.ltActFacility).save()
                log.info "Facility linked to activity"
              }                

              // link clients to activity
              links = Link.findAllByTargetAndType(project, metaDataService.ltGroupMemberClient)
              if (links) {
                List clients = links.collect {it.source}
                clients.each {
                  new Link(source: it, target: activity, type: metaDataService.ltActClient).save()
                  log.info "Client linked to activity"
                }
              }

              // link resources to activity
              links = Link.findAllByTargetAndType(pd, metaDataService.ltProjectDayResource)
              if (links) {
                List resources = links.collect {it.source}
                resources.each {
                  new Link(source: it, target: activity, type: metaDataService.ltResource).save()
                  log.info "Resource linked to activity"
                }
              }

              // link educators to activity
              links = Link.findAllByTargetAndType(pd, metaDataService.ltProjectDayEducator)
              if (links) {
                List educators = links.collect {it.source}
                educators.each {
                  new Link(source: it, target: activity, type: metaDataService.ltActEducator).save()
                  log.info "Educator linked to activity"
                }
              }

              // link partners to activity
              links = Link.findAllByTargetAndType(pu, metaDataService.ltProjectUnitPartner)
              if (links) {
                List partners = links.collect {it.source}
                partners.each {
                  new Link(source: it, target: activity, type: metaDataService.ltActPartner).save()
                  log.info "Partner linked to activity"
                }
              }

              // link parents to activity
              links = Link.findAllByTargetAndType(pu, metaDataService.ltProjectUnitParent)
              if (links) {
                List parents = links.collect {it.source}
                parents.each {
                  new Link(source: it, target: activity, type: metaDataService.ltActParent).save()
                  log.info "Parent linked to activity"
                }
              }

              log.info "Activity instantiated!"

              render "Aktivität '" + activity.profile.fullName + "' instanziert am " + calendar.getTime() + "<br/>"
              // get new time for next activity
              calendar.add(Calendar.MINUTE, activity.profile.duration)
            }

          }
        }
      }

      render "<span class='green'>Projekt wurde instanziert!</span><br/>"
      
    }
}


