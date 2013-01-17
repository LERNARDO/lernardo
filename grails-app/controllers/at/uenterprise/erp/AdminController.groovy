package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Link
import at.uenterprise.erp.base.AssetStorage
import at.uenterprise.erp.base.Asset
import at.uenterprise.erp.logbook.Attendance
import at.uenterprise.erp.base.EntityType
import at.uenterprise.erp.base.Profile
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.ProfileHelperService

/**
 * This controller contains only actions for various admin related things
 *
 * @author  Alexander Zeillinger
 */
class AdminController {
  FunctionService functionService
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  ProfileHelperService profileHelperService

  def index = {
    redirect action: "stuff"
  }

  def stuff = {
      //List entities = Entity.list()
      //return [entities: entities]
  }

  def linksresults = {
      if (params.id != 'null') {
          Entity entity = Entity.get(params.id)

          List targets = Link.findAllBySource(entity)
          List sources = Link.findAllByTarget(entity)

          render template: 'linksresults', model: [entity: entity, targets: targets, sources: sources]
      }
      else
        render ""
  }

  def removeroguecomments = {
    List comments = Comment.list()
    def total = comments.size()
    def deleted = 0
    comments.each { comment ->
      if (!Entity.get(comment.creator)) {
        log.info "no entity found with id: ${comment.creator}"
        comment.delete()
        deleted++
      }
    }
    render "Deleted ${deleted} of a total of ${total} comments<br/>"
    render "-Done-"
  }

  /*
   * populates helper tables for sorting links
   * check if a linked entity is in the according helper table, if not add it
   */
  def createtables = {
    // facilities and colonies
    List entities = Entity.findAllByTypeOrType(metaDataService.etFacility, metaDataService.etGroupColony)
    int number = 0
    entities.each { entity ->
      List resources = functionService.findAllByLink(null, entity, metaDataService.ltResource)
      resources.each { resource ->
        if (!entity.profile.resources.contains(resource.id.toString())) {
          entity.profile.addToResources(resource.id.toString())
          number++
        }
      }
    }
    render "Created ${number} table entries in ${entities.size()} facilities and colonies<br/>"

    // group activity templates
    List groups = Entity.findAllByType(metaDataService.etGroupActivityTemplate)
    number = 0
    groups.each { group ->
      List activityTemplates = functionService.findAllByLink(null, group, metaDataService.ltGroupMember)
      activityTemplates.each { activityTemplate ->
        if (!group.profile.templates.contains(activityTemplate.id.toString())) {
          group.profile.addToTemplates(activityTemplate.id.toString())
          number++
        }
      }
    }
    render "Created ${number} table entries in ${groups.size()} group activity templates<br/>"

    // project templates
    groups = Entity.findAllByType(metaDataService.etProjectTemplate)
    number = 0
    groups.each { group ->
      List projectUnitTemplates = functionService.findAllByLink(null, group, metaDataService.ltProjectUnitTemplate)
      projectUnitTemplates.each { projectUnitTemplate ->
        if (!group.profile.templates.contains(projectUnitTemplate.id.toString())) {
          group.profile.addToTemplates(projectUnitTemplate.id.toString())
          number++
        }
      }
    }
    render "Created ${number} table entries in ${groups.size()} project templates<br/>"

    // project days
    groups = Entity.findAllByType(metaDataService.etProjectDay)
    number = 0
    groups.each { group ->
      List units = functionService.findAllByLink(null, group, metaDataService.ltProjectDayUnit)
      units.each { unit ->
        if (!group.profile.units.contains(unit.id.toString())) {
          group.profile.addToUnits(unit.id.toString())
          number++
        }
      }
    }
    render "Created ${number} table entries in ${groups.size()} project days<br/>"

    render "-Done-"
  }


    /*
   * some speed testing of the DB
   */
  def checkDB = {
    render "Reading all entities of type facility<br/>"

    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "fullName"
    params.order = params.order ?: "asc"

    render "First method:<br/>"
    Date begin = new Date()
    List facilities = Entity.createCriteria().list (max: params.max, offset: params.offset) {
      eq("type", metaDataService.etFacility)
      profile {
        order(params.sort, params.order)
      }
    }
    Date end = new Date()
    int time = (end.getTime() - begin.getTime())
    render "Done reading ${facilities.size()} facilities, time: ${time} milliseconds<br/>"

    render "----<br/>"

    render "Second method:<br/>"

    begin = new Date()
    facilities = Entity.createCriteria().list {
      eq("type", metaDataService.etFacility)
      profile {
        order(params.sort, params.order)
      }
      firstResult (params.offset)
      maxResults (params.max)
    }
    end = new Date()
    time = (end.getTime() - begin.getTime())
    render "Done reading ${facilities.size()} facilities, time: ${time} milliseconds<br/>"

    render "----<br/>"

    render "-Done-"

  }

  def removeAssets = {

    List entities = Entity.list()

    // delete duplicate profile assets
    int counter = 0
    entities.each { Entity entity ->
      List assets = Asset.findAllByEntityAndType(entity, "profile", [sort: "dateCreated", order: "desc"])
      //println "assets of entity: " + entity.profile + ": " + assets
      if (assets && assets.size() > 1) {
        for (int i = 1; i < assets.size(); i++) {
          counter++
          assets[i].delete(flush: true)
        }
      }
    }

    render "Deleted " + counter + " unused assets<br/>"

    counter = 0
    // delete unused asset storages
    List ast = AssetStorage.list()
    ast.each { AssetStorage assetStorage ->
      //println "assets: " + assetStorage.assets
      if (assetStorage.assets.size() == 0) {
        counter++
        assetStorage.delete(flush: true)
      }
    }

    render "Deleted " + counter + " unused asset storages<br/>"

    render "-Done-"

  }

  def createAttendences = {
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    def counter = 0
    facilities.each { Entity facility ->
      List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)
      clients.each { Entity client ->
        if (!Attendance.findByClientAndFacility(client, facility)) {
          new Attendance(client: client, facility: facility).save()
          counter++
        }
      }
    }

    render "Created " + counter + " attendances<br/>"
    render "-Done-"
  }

  def checktables = {
    // group activity templates
    List groups = Entity.findAllByType(metaDataService.etGroupActivityTemplate)
    render "Found ${groups?.size()} group activity templates<br/>"

    int counter = 0
    int number = 0
    groups.each { group ->
      number++
      //log.info "group activity templates: Entity-No:"+number+" Entity-Id:"+group.id
      List activityTemplates = functionService.findAllByLink(null, group, metaDataService.ltGroupMember)
      //log.info "group activity templates: activityTemplates-Size:"+activityTemplates?.size()
      activityTemplates.each { activityTemplate ->
        //log.info "group activity templates: Activity-Template_Id:"+activityTemplate.id
        if (!group.profile.templates.contains(activityTemplate.id.toString())) {
          counter++
          //log.info "group activity templates: activityTemplate: "+activityTemplate.id+" for Entity: "+group.id+ " (profile-id: "+group.profile.id+") not in Sort-Table"
        }
      }
      group.profile.templates.each { templ ->
        def aLink = Link.createCriteria().get {
          eq('source', Entity.get(Integer.parseInt(templ)))
          eq('target', group)
          eq ('type', metaDataService.ltGroupMember)
        }
        if (!aLink) {
          log.info "group activity templates: Entity-Id: "+templ+" for group.profile-ID "+group.profile.id+" not found!!!!!!!!!!!!!!"
        }
      }
    }

    render "Found ${counter} activity templates without table entry<br/>"

    // project templates
    counter = 0
    groups = Entity.findAllByType(metaDataService.etProjectTemplate)
    log.info "project templates size: " + groups?.size()
    number = 0
    groups.each { group ->
      number++
      log.info "project templates: Entity-No:"+number+" Entity-Id:"+group.id
      List projectUnitTemplates = functionService.findAllByLink(null, group, metaDataService.ltProjectUnitTemplate)
      log.info "project templates: projectUnits-Size:"+projectUnitTemplates?.size()
      projectUnitTemplates.each { projectUnitTemplate ->
        log.info "project templates: projectUnitTemplate_Id:"+projectUnitTemplate.id
        if (!group.profile.templates.contains(projectUnitTemplate.id.toString())) {
          log.info "project templates: projectUnitTemplate: "+projectUnitTemplate.id+" for Entity "+group.id+" (profile-id: "+group.profile.id+") not in Sort-Table"
        }
      }
      group.profile.templates.each { templ ->
        def aLink = Link.createCriteria().get {
          eq('source', Entity.get(Integer.parseInt(templ)))
          eq('target', group)
          eq ('type', metaDataService.ltProjectUnitTemplate)
        }
        if (!aLink) {
          log.info "project templates: Entity-Id: "+templ+" for group.profile-ID "+group.profile.id+" not found!!!!!!!!!!!!!!"
        }
      }
    }

    // project days
    groups = Entity.findAllByType(metaDataService.etProjectDay)
    log.info "project days size: " + groups?.size()
    number = 0
    groups.each { group ->
      number++
      log.info "project days: Entity-No:"+number+" Entity-Id:"+group.id
      List units = functionService.findAllByLink(null, group, metaDataService.ltProjectDayUnit)
      log.info "project days: Units-Size:"+units?.size()
      units.each { unit ->
        log.info "project days: Unit_Id"+unit.id
        if (!group.profile.units.contains(unit.id.toString())) {
         log.info "project days: unit: "+unit.id+" for Entity: "+group.id+" (profile-id: "+group.profile.id+") not in Sort-Table"
        }
      }
    }
    render "-Done-"

  }
  
  def createLabels = {
    if (Label.labels)
      Label.labels.clear()
    else
       Label.labels = []
    
    List labels = Label.findAllByType('template')
    labels.each {
      Label.labels.add(it.id.toString())
    }
    render "-Done-"
  }

  def favorites = {

    if (!FolderType.findByName("favorite"))
      new FolderType(name: "favorite").save()

    List entities = Entity.createCriteria().list {
      or {
        eq("type", metaDataService.etUser)
        eq("type", metaDataService.etPate)
        eq("type", metaDataService.etPartner)
        eq("type", metaDataService.etParent)
        eq("type", metaDataService.etOperator)
        eq("type", metaDataService.etEducator)
        eq("type", metaDataService.etClient)
        eq("type", metaDataService.etChild)
      }
    }

    entities?.each { Entity entity ->
      if (!entity.profile.favoritesFolder)
        entity.profile.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
      if (entity.profile.favorites) {
        entity.profile.favorites.each { String favid ->
          Entity fav = Entity.get(favid.toInteger())
          Favorite newFav = new Favorite(entity: fav, folder: Folder.findByName("root")).save(failOnError: true)
          entity.profile.favoritesFolder.addToFavorites(newFav)
        }
      }
      entity.profile.favorites.clear()
    }
    render "-Done-"
  }

    def convertGATtoPT = {

        List groupActivityTemplates = Entity.findAllByType(metaDataService.etGroupActivityTemplate)

        EntityType etProjectTemplate = metaDataService.etProjectTemplate
        EntityType etProjectUnitTemplate = metaDataService.etProjectUnitTemplate

        groupActivityTemplates?.each { Entity gat ->

            Entity entity = entityHelperService.createEntity("projectTemplate", etProjectTemplate) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile

                    ent.profile.fullName = gat.profile.fullName
                    ent.profile.description = gat.profile.description
                    ent.profile.status = gat.profile.status
                    ent.profile.educationalObjectiveText = gat.profile.educationalObjectiveText
                    ent.profile.ageFrom = gat.profile.ageFrom
                    ent.profile.ageTo = gat.profile.ageTo
            }

            // publications
            List publications = Publication.findAllByEntity(gat)
            publications?.each { Publication pub ->
                pub.entity = entity
                pub.save()
            }

            // profile picture
            gat.assets.each { Asset asset ->
                if (asset.type == "profile") {
                    new Asset(entity: entity, storage: asset.storage, type: "profile").save()
                }
            }

            // favorites
            List favorites = Favorite.findAllByEntity(gat)
            favorites?.each { Favorite fav ->
                fav.entity = entity
                fav.save()
            }

            // comments
            gat.profile.comments.each { Comment gatcomment ->
                Comment comment = new Comment(content: gatcomment.content, creator: gatcomment.creator, dateCreated: gatcomment.dateCreated).save()
                entity.profile.addToComments(comment)
            }

            // labels
            gat.profile.labels.each { Label gatlabel ->
                Label label = new Label(name: gatlabel.name, description: gatlabel.description, type: "instance").save()
                entity.profile.addToLabels(label)
            }

            // resources
            gat.profile.resources.each { Resource gatresource ->
                Resource resource = new Resource(name: gatresource.name, description: gatresource.description, amount: gatresource.amount)
                entity.profile.addToResources(resource)
            }

            // add a project unit and add the activities from the group activity template
            Entity projectUnitTemplate = entityHelperService.createEntity("projectUnitTemplate", etProjectUnitTemplate) {Entity ent2 ->
                ent2.profile = profileHelperService.createProfileFor(ent2) as Profile
                ent2.profile.fullName = message(code: "unit")+ " 1"
                ent2.profile.duration = 0
            }
            // link project unit to project template
            new Link(source: projectUnitTemplate, target: entity, type: metaDataService.ltProjectUnitTemplate).save()
            entity.profile.addToTemplates(projectUnitTemplate.id.toString())

            gat.profile.templates.each { String gattemplate ->
                // link activity template to project unit
                new Link(source: Entity.get(gattemplate), target: projectUnitTemplate, type: metaDataService.ltGroupMember).save()
            }

            // save creator
            def gatCreator = functionService.findByLink(null, gat, metaDataService.ltCreator)
            new Link(source: gatCreator, target: entity, type: metaDataService.ltCreator).save()
        }
        render "Done"
    }

    def convertGAtoP = {
        List groupActivities = Entity.findAllByType(metaDataService.etGroupActivity)

        EntityType etProject = metaDataService.etProject
        EntityType etProjectDay = metaDataService.etProjectDay
        EntityType etProjectUnit = metaDataService.etProjectUnit

        groupActivities?.each { Entity ga ->

            Entity entity = entityHelperService.createEntity("project", etProject) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile

                ent.profile.fullName = ga.profile.fullName
                ent.profile.description = ga.profile.description ?: ""
                ent.profile.educationalObjectiveText = ga.profile.educationalObjectiveText ?: ""
                ent.profile.startDate = ga.profile.date
                ent.profile.endDate = ga.profile.date + 1
            }

            // publications
            List publications = Publication.findAllByEntity(ga)
            publications?.each { Publication pub ->
                pub.entity = entity
                pub.save()
            }

            // profile picture
            ga.assets.each { Asset asset ->
                if (asset.type == "profile") {
                    new Asset(entity: entity, storage: asset.storage, type: "profile").save()
                }
            }

            // favorites
            List favorites = Favorite.findAllByEntity(ga)
            favorites?.each { Favorite fav ->
                fav.entity = entity
                fav.save()
            }

            // comments
            ga.profile.comments.each { Comment gacomment ->
                Comment comment = new Comment(content: gacomment.content, creator: gacomment.creator, dateCreated: gacomment.dateCreated).save()
                entity.profile.addToComments(comment)
            }

            // labels
            ga.profile.labels.each { Label galabel ->
                Label label = new Label(name: galabel.name, description: galabel.description, type: "instance").save()
                entity.profile.addToLabels(label)
            }

            // save creator
            def gaCreator = functionService.findByLink(null, ga, metaDataService.ltCreator)
            new Link(source: gaCreator, target: entity, type: metaDataService.ltCreator).save()

            // responsibles
            List gaResponsibles = functionService.findAllByLink(null, ga, metaDataService.ltResponsible)
            gaResponsibles?.each { Entity gaResponsible ->
                new Link(source: gaResponsible, target: entity, type: metaDataService.ltResponsible).save()
            }

            // themes
            List gaThemes = functionService.findAllByLink(ga, null, metaDataService.ltGroupMemberActivityGroup)
            gaThemes?.each { Entity gaTheme ->
                new Link(source: entity, target: gaTheme, type: metaDataService.ltGroupMember).save()
            }

            // facilities
            List gaFacilities = functionService.findAllByLink(ga, null, metaDataService.ltGroupMemberFacility)
            gaFacilities?.each { Entity gaFacility ->
                new Link(source: entity, target: gaFacility, type: metaDataService.ltGroupMemberFacility).save()
            }

                    // create project day
                    Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
                        ent.profile = profileHelperService.createProfileFor(ent) as Profile
                        ent.profile.fullName = ga.profile.fullName
                        ent.profile.date = ga.profile.date
                        ent.profile.endDate = ga.profile.date + 1
                    }

                    // link project day to project
                    new Link(source: projectDay, target: entity, type: metaDataService.ltProjectMember).save()

                    // educators
                    List gaEducators = functionService.findAllByLink(null, ga, metaDataService.ltGroupMemberEducator)
                    gaEducators?.each { Entity gaEducator ->
                        new Link(source: gaEducator, target: projectDay, type: metaDataService.ltProjectDayEducator).save()
                    }

                    // substitutes
                    List gaSubstitutes = functionService.findAllByLink(null, ga, metaDataService.ltGroupMemberSubstitute)
                    gaSubstitutes?.each { Entity gaSubstitute ->
                        new Link(source: gaSubstitute, target: projectDay, type: metaDataService.ltProjectDaySubstitute).save()
                    }

                    // clients
                    List gaClients = functionService.findAllByLink(null, ga, metaDataService.ltGroupMemberClient)
                    gaClients?.each { Entity gaClient ->
                        new Link(source: gaClient, target: projectDay, type: metaDataService.ltGroupMemberClient).save()
                    }

                            // get activities of group activity
                            List activities = functionService.findAllByLink(null, ga, metaDataService.ltGroupMember)

                            def duration = 0
                            activities.each {
                                duration += it.profile.duration
                            }

                            // create unit
                            Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
                                ent.profile = profileHelperService.createProfileFor(ent) as Profile
                                ent.profile.fullName = ga.profile.fullName
                                ent.profile.date = ga.profile.date
                                ent.profile.duration = duration
                            }

                            // save creator
                            new Link(source: gaCreator, target: projectUnit, type: metaDataService.ltCreator).save()

                            projectDay.profile.addToUnits(projectUnit.id.toString())

                            // link the new unit to the project day
                            new Link(source: projectUnit, target: projectDay, type: metaDataService.ltProjectDayUnit).save()

                            // activities
                            activities.each { Entity activity ->
                                new Link(source: activity, target: projectUnit, type: metaDataService.ltGroupMember).save()
                            }

                            // parents
                            List gaParents = functionService.findAllByLink(null, ga, metaDataService.ltGroupMemberParent)
                            gaParents?.each { Entity gaParent ->
                                new Link(source: gaParent, target: projectUnit, type: metaDataService.ltProjectUnitParent).save()
                            }

                            // partner
                            List gaPartners = functionService.findAllByLink(null, ga, metaDataService.ltGroupMemberPartner)
                            gaPartners?.each { Entity gaPartner ->
                                new Link(source: gaPartner, target: projectUnit, type: metaDataService.ltProjectUnitPartner).save()
                            }

        }
        render "Done"
    }

    def convertPTtoP = {
        List projectTemplates = Entity.findAllByType(metaDataService.etProjectTemplate)

        EntityType etProject = metaDataService.etProject
        EntityType etProjectDay = metaDataService.etProjectDay
        EntityType etProjectUnit = metaDataService.etProjectUnit

        projectTemplates?.each { Entity pt ->

            Entity entity = entityHelperService.createEntity("project", etProject) {Entity ent ->
                ent.profile = profileHelperService.createProfileFor(ent) as Profile

                ent.profile.fullName = pt.profile.fullName
                ent.profile.description = pt.profile.description  ?: ""
                ent.profile.educationalObjectiveText = pt.profile.educationalObjectiveText  ?: ""
                ent.profile.startDate = new Date()
                ent.profile.endDate = ent.profile.startDate + 1
                ent.profile.status = pt.profile.status
            }

            // publications
            List publications = Publication.findAllByEntity(pt)
            publications?.each { Publication pub ->
                pub.entity = entity
                pub.save()
            }

            // profile picture
            pt.assets.each { Asset asset ->
                if (asset.type == "profile") {
                    new Asset(entity: entity, storage: asset.storage, type: "profile").save()
                }
            }

            // favorites
            List favorites = Favorite.findAllByEntity(pt)
            favorites?.each { Favorite fav ->
                fav.entity = entity
                fav.save()
            }

            // comments
            pt.profile.comments.each { Comment ptcomment ->
                Comment comment = new Comment(content: ptcomment.content, creator: ptcomment.creator, dateCreated: ptcomment.dateCreated).save()
                entity.profile.addToComments(comment)
            }

            // labels
            pt.profile.labels.each { Label ptlabel ->
                Label label = new Label(name: ptlabel.name, description: ptlabel.description, type: "instance").save()
                entity.profile.addToLabels(label)
            }

            // resources
            pt.profile.resources.each { Resource res ->
                Resource resource = new Resource()
                resource.name = res.name
                resource.description = res.description
                res.amount = res.amount
                entity.profile.addToResources(resource)
            }

            // save creator
            def ptCreator = functionService.findByLink(null, pt, metaDataService.ltCreator)
            new Link(source: ptCreator, target: entity, type: metaDataService.ltCreator).save()

                    // create project day
                    Entity projectDay = entityHelperService.createEntity("projectDay", etProjectDay) {Entity ent ->
                        ent.profile = profileHelperService.createProfileFor(ent) as Profile
                        ent.profile.fullName = pt.profile.fullName
                        ent.profile.date = entity.profile.startDate
                        ent.profile.endDate = entity.profile.endDate
                    }

                    // link project day to project
                    new Link(source: projectDay, target: entity, type: metaDataService.ltProjectMember).save()

                            // find all projectUnitTemplates of this projectTemplate
                            List projectUnitTemplates = []
                            pt.profile.templates.each { String put ->
                                projectUnitTemplates.add(Entity.get(put.toInteger()))
                            }

                            projectUnitTemplates?.each { Entity put ->

                                List activityTemplates = []

                                List ats = functionService.findAllByLink(null, put, metaDataService.ltGroupMember)
                                if (ats.size() > 0)
                                    activityTemplates.addAll(ats)

                                int duration = activityTemplates*.profile.duration.sum(0)

                                // create unit
                                Entity projectUnit = entityHelperService.createEntity("projectUnit", etProjectUnit) {Entity ent ->
                                    ent.profile = profileHelperService.createProfileFor(ent) as Profile
                                    ent.profile.fullName = pt.profile.fullName
                                    ent.profile.date = entity.profile.startDate
                                    ent.profile.duration = duration
                                }

                                projectDay.profile.addToUnits(projectUnit.id.toString())

                                // link the new unit to the project day
                                new Link(source: projectUnit, target: projectDay, type: metaDataService.ltProjectDayUnit).save()

                                activityTemplates?.each { Entity at ->
                                    // check if the activityTemplate isn't already linked to the projectUnit
                                    def link = Link.createCriteria().get {
                                        eq('source', at)
                                        eq('target', projectUnit)
                                        eq('type', metaDataService.ltGroupMember)
                                    }
                                    if (!link)
                                        // link activityTemplate to projectUnit
                                        new Link(source: at, target: projectUnit, type: metaDataService.ltGroupMember).save()
                                }

                            }

        }
        render "Done"
    }

}