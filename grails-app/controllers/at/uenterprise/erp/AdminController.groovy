package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import at.openfactory.ep.AssetStorage
import at.openfactory.ep.Asset
import at.uenterprise.erp.logbook.Attendance

/**
 * This controller contains only actions for various admin related things
 *
 * @author  Alexander Zeillinger
 */
class AdminController {
  FunctionService functionService
  MetaDataService metaDataService

  def index = {
    redirect action: "stuff"
  }

  def stuff = {
      List entities = Entity.list()
      return [entities: entities]
  }

  def linksresults = {
      if (params.id != 'null') {
          Entity entity = Entity.get(params.id)

          List targets = Link.findAllBySource(entity)
          List sources = Link.findAllByTarget(entity)

          render template: 'linksresults', model:[entity: entity, targets: targets, sources: sources]
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
   * populates tables for sorting links
   */
  def createtables = {
    // group activity templates
    List groups = Entity.findAllByType(metaDataService.etGroupActivityTemplate)
    int number = 0
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
}
