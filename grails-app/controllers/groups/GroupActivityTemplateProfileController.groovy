package groups

import at.openfactory.ep.Entity
import at.openfactory.ep.EntityType
import at.openfactory.ep.Link
import at.openfactory.ep.ProfileHelperService
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import at.openfactory.ep.Profile
import standard.FunctionService
import at.openfactory.ep.EntityException
import lernardo.Method

class GroupActivityTemplateProfileController {
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
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    return [groups: Entity.findAllByType(metaDataService.etGroupActivityTemplate),
            groupTotal: Entity.countByType(metaDataService.etGroupActivityTemplate),
            entity: entityHelperService.loggedIn]
  }

  def show = {
    def group = Entity.get(params.id)
    Entity entity = params.entity ? group : entityHelperService.loggedIn

    if (!group) {
      flash.message = "groupProfile not found with id ${params.id}"
      redirect(action: list)
    }
    else {
      //def allTemplates = Entity.findAllByType(metaDataService.etTemplate)

      // get all templates that are set to completed
      def c = Entity.createCriteria()
      def allTemplates = c.list {
        eq("type", metaDataService.etTemplate)
        profile {
          eq("status", "fertig")
        }
      }

      // find all templates linked to this group
      def links = Link.findAllByTargetAndType(group, metaDataService.ltGroupMember)
      List templates = links.collect {it.source}

      def calculatedDuration = 0
      templates.each {
        calculatedDuration += it.profile.duration
      }

      return [group: group,
              entity: entity,
              allTemplates: allTemplates,
              templates: templates,
              calculatedDuration: calculatedDuration,
              methods: Method.findAllByType('template')]
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
    Entity group = Entity.get(params.id)
    return [entity: entityHelperService.loggedIn,
            group: group]
  }

  def save = {
    EntityType etGroupActivityTemplate = metaDataService.etGroupActivityTemplate

    try {
      Entity entity = entityHelperService.createEntity("group", etGroupActivityTemplate) {Entity ent ->
        ent.profile = profileHelperService.createProfileFor(ent) as Profile
        ent.profile.properties = params
      }

      flash.message = message(code: "group.created", args: [entity.profile.fullName])
      redirect action: 'list'
    } catch (EntityException ee) {
      render(view: "create", model: [group: ee.entity, entity: entityHelperService.loggedIn])
      return
    }

  }

  def addTemplate = {
    def bla = functionService.getParamAsList(params.templates)

    bla.each {
      def linking = functionService.linkEntities(it.toString(), params.id, metaDataService.ltGroupMember)
      if (linking.duplicate)
        render '<span class="red italic">"' + linking.source.profile.fullName + '" wurde bereits zugewiesen!</span>'
    }

    def calculatedDuration = 0
    def templates = Link.findAllByTargetAndType(Entity.get(params.id), metaDataService.ltGroupMember).collect {it.source}
    templates.each {
      calculatedDuration += it.profile.duration
    }

    render template: 'templates', model: [templates: templates, group: Entity.get(params.id), entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
  }

  def removeTemplate = {
    def breaking = functionService.breakEntities(params.template, params.id, metaDataService.ltGroupMember)

    def calculatedDuration = 0
    breaking.results.each {
      calculatedDuration += it.profile.duration
    }

    render template: 'templates', model: [templates: breaking.results, group: breaking.target, entity: entityHelperService.loggedIn, calculatedDuration: calculatedDuration]
  }

  def updateselect = {
    //println params
    def allTemplates = Entity.findAllByType(metaDataService.etTemplate)
    def star1 = params.star1
    def star2 = params.star2

    def c = Entity.createCriteria()
    allTemplates = c.list {
      eq('type', metaDataService.etTemplate)
      if (params.name)
        or {
          ilike('name', "%" + params.name + "%")
          profile {
            ilike('fullName', "%" + params.name + "%")
          }
        }
      profile {
        if (params.duration1 != 'all')
          between('duration', params.duration1.toInteger(), params.duration2.toInteger())
      }
      maxResults(30)
    }

    List finalList = allTemplates

    if (params.method != 'none') {
      // now check each template for their correct element values
      finalList = []
      allTemplates.each { a ->
        //println '----------'
        //println a
        a.profile.each { b ->
          //println 'Profile:'+b
          b.methods.each { d ->
            //println 'Method:'+d
            def counter = 0
            def correct = 0
            d.elements.each { e ->
              //println e.name + ' - ' + star1[counter] + ' to ' + star2[counter]
              if (star1[counter] != 'all' && star2[counter] != 'all') {

                if (e.voting >= star1[counter].toInteger() && e.voting <= star2[counter].toInteger()) {
                  //println counter + '# element OK, is ' + e.voting
                  correct++
                }
                //else {
                //  println counter + '# element not OK, is ' + e.voting
                //}
              }
              else {
                //println counter + '# element OK'
                correct++
              }
              //println '#correct ' + correct + ' of ' + star1.size()
              if (correct == star1.size())
                finalList << a
              counter++
            }
          }
        }
      }

      //println finalList
    }

    render(template: 'searchresults', model: [allTemplates: finalList])
  }

  def listMethods = {

    if (params.id == 'none') {
      render ''
      return
    }

    Method method = Method.get(params.id)

    render(template: 'methods', model: [method: method])
  }

  def secondselect = {
    if (params.value == "all")
      render ''
    else
      render template: 'secondselect', model:[value: params.value.toInteger() + 1]
  }

}
