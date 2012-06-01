package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import org.springframework.web.multipart.MultipartFile
import at.uenterprise.erp.base.EntityHelperService
import at.uenterprise.erp.base.AssetService

class PublicationController {
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  AssetService assetService
  FunctionService functionService

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

  def index = { }

  def list = {
    params.max = Math.min(params.int('max') ?: 10, 100)
    params.sort = params.sort ?: 'dateCreated'
    Entity entity = params.id ? Entity.get(params.id) : entityHelperService.loggedIn
    if (!entity) {
      response.sendError (404, 'no such profile')
      return
    }

    List publications = functionService.findPublicationsOfEntity(entity)

    // (1)
    // if the entity is a group activity template find all documents of the activity templates linked to it
    List activitytemplatesdocuments = []
    if (entity.type.id == metaDataService.etGroupActivityTemplate.id) {
      // find all activity templates linked to the group activity template
      List activitytemplates = functionService.findAllByLink(null, entity, metaDataService.ltGroupMember)

      // get all documents
      activitytemplates.each { Entity at ->
        def bla = functionService.findPublicationsOfEntity(at)
        bla.each {
          activitytemplatesdocuments << it
        }
      }
    }

    // (2)
    // if the entity is a group activity find the group activity template and its documents and then all
    // documents of the activity templates linked to the group activity template
    List groupactivitytemplatesdocuments = []
    if (entity.type.id == metaDataService.etGroupActivity.id) {
      // find the group activity template
      Entity groupactivitytemplate = functionService.findByLink(null, entity, metaDataService.ltTemplate)

      // get documents of template
      groupactivitytemplatesdocuments = functionService.findPublicationsOfEntity(groupactivitytemplate)

      // find all activity templates linked to the group activity template
      List activitytemplates = functionService.findAllByLink(null, groupactivitytemplate, metaDataService.ltGroupMember)

      // get all documents
      activitytemplates.each { Entity at ->
        def bla = functionService.findPublicationsOfEntity(at)
        bla.each {
          activitytemplatesdocuments << it
        }
      }
    }

    // (3)
    // if the entity is a project template find all group activity templates and their documents and then all
    // documents of the activity templates linked to the group activity templates
    if (entity.type.id == metaDataService.etProjectTemplate.id) {

      // find all project units linked to the project template
      List projectUnits = functionService.findAllByLink(null, entity, metaDataService.ltProjectUnit)

      // find all group activity templates
      List groupactivitytemplates = []
      projectUnits.each { Entity pu ->
        def bla = functionService.findAllByLink(null, pu, metaDataService.ltProjectUnitMember)
        bla.each {
          if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
            groupactivitytemplates << it
        }
      }

      // get documents of group activity templates
      groupactivitytemplates.each { Entity gat ->
        def bla = functionService.findPublicationsOfEntity(gat)
        bla.each {
          groupactivitytemplatesdocuments << it
        }
      }

      // find all activity templates linked to the group activity templates
      List activitytemplates = []
      groupactivitytemplates.each { Entity gat ->
        def bla = functionService.findAllByLink(null, gat, metaDataService.ltGroupMember)
        bla.each {
          if (!activitytemplates.contains(it)) // filter duplicate activity templates
            activitytemplates << it
        }
      }

      // get all documents
      activitytemplates.each { Entity at ->
        def bla = functionService.findPublicationsOfEntity(at)
        bla.each {
          activitytemplatesdocuments << it
        }
      }
    }

    // (4)
    // if the entity is a project find the project template and its documents then all group activity templates and
    // their documents and then all documents of the activity templates linked to the group activity templates
    List projecttemplatedocuments = []
    if (entity.type.id == metaDataService.etProject.id) {

      // find project template
      Entity projectTemplate = functionService.findByLink(null, entity, metaDataService.ltProjectTemplate)

      // get documents of project template
      projecttemplatedocuments = functionService.findPublicationsOfEntity(projectTemplate)

      // find all project units linked to the project template
      List projectUnits = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnit)

      // find all group activity templates
      List groupactivitytemplates = []
      projectUnits.each { Entity pu ->
        def bla = functionService.findAllByLink(null, pu, metaDataService.ltProjectUnitMember)
        bla.each {
          if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
            groupactivitytemplates << it
        }
      }

      // get documents of group activity templates
      groupactivitytemplates.each { Entity gat ->
        def bla = functionService.findPublicationsOfEntity(gat)
        bla.each {
          groupactivitytemplatesdocuments << it
        }
      }

      // find all activity templates linked to the group activity templates
      List activitytemplates = []
      groupactivitytemplates.each { Entity gat ->
        def bla = functionService.findAllByLink(null, gat, metaDataService.ltGroupMember)
        bla.each {
          if (!activitytemplates.contains(it)) // filter duplicate activity templates
            activitytemplates << it
        }
      }

      // get all documents
      activitytemplates.each { Entity at ->
        def bla = functionService.findPublicationsOfEntity(at)
        bla.each {
          activitytemplatesdocuments << it
        }
      }
    }

    /*
     * the code below should check the access level of a document to decide whether or not a publication is visible
     * to the user - NOT USED ATM
     */

    /*log.info pubs
    log.info pubs[0]
    log.info pubs.value
    log.info pubs.key

    // if it's me show all pubs
    if (e == entityHelperService.loggedIn) {
      finalMap = pubs
    }
    else {
      // else drop all pubs that are private
      pubs.value.each {
        if (it.accesslevel < 3) {
          finalMap.value << it
        }
      }
      pubs = finalMap
      log.info pubs
      // if i'm not a friend drop those pubs a friend could see
      if (!functionService.isFriendOf(e, entityHelperService.loggedIn)) {
        pubs.value.each {
          if (it.accesslevel < 2) {
            finalMap.value << it
          }
        }
      }
      pubs = finalMap
      // if i'm not in the network drop those pubs
      if (!functionService.isNetworkOf(e, entityHelperService.loggedIn)) {
        pubs.value.each {
          if (it.accesslevel < 1) {
            finalMap.value << it
          }
        }
      }
      //pubs = finalMap
    }*/

    publications.sort {it[params.sort]}
    publications = publications.reverse()

    render template: "list", model: [entity: entity,
        currentEntity: entityHelperService.loggedIn,
            publications: publications,
            activitytemplatesdocuments: activitytemplatesdocuments,
            groupactivitytemplatesdocuments: groupactivitytemplatesdocuments,
            projecttemplatedocuments: projecttemplatedocuments]
  }

  def create = {
    Entity entity = Entity.get(params.id)
    Publication pub = new Publication()
    render template: "create", model: [entity:entity, publication:pub]
  }

  def save = {
    Entity entity = params.id ? Entity.get(params.id) : entityHelperService.loggedIn
    if (!entity) {
      response.sendError (404, 'no such profile')
      return
    }

    Publication pub = new Publication(params)
    pub.entity = entity
    pub.type = metaDataService.ptDoc1 // temporarily hardcoded

    if (!entity.user)
      pub.isPublic = true

    // handle the file
    MultipartFile mpf = request.getFile('file')
    if (mpf?.empty)
      pub.errors.reject ('publication.file.nullable.error')
    else {
      pub.asset = assetService.storeAsset (pub.entity, "Publication", mpf)
      //log.debug "created asset $pub.asset.id of type $pub.asset.storage.contentType with storage $pub.asset.storage.storageId "
    }

    //log.debug "attempt to save publication: $params"
    if(pub.save(flush:true)) {
      flash.message = message(code: "object.created", args: [message(code: "publication"), pub.name])
      redirect controller: pub.entity.type.supertype.name + "Profile", action: "show", id: pub.entity.id
    }
    else {
       render view: 'create', model: [entity: entity, publication: pub]
      }
  }

  def showasset = {
    Publication pub = Publication.get(params.id)
    if (pub?.asset) {
      assetService.renderStorage (pub.asset?.storage, response)
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "publication")])
      redirect (action: "list", params: [name: params.name])
    }

  }

  def delete = {
    Publication pub = Publication.get(params.id)
    Entity entity = pub.entity
    if (!pub) {
      flash.message = message(code: "object.notFound", args: [message(code: "publication")])
    }
    else {
      flash.message = message(code: "object.deleted", args: [message(code: "publication"), pub.name])
      pub.delete(flush:true)
    }

    chain (action: "list", id: entity.id)
  }

  def edit = {
    Publication publication = Publication.get(params.id)

    if(publication) {
      render template: "edit", model: [publication: publication]
    }
    else {
      flash.message = message(code: "object.notFound", args: [message(code: "publication")])
      redirect action: 'list'
    }

  }

  def update = {
      Publication publication = Publication.get(params.id)
      if(publication) {
          publication.properties = params
          if(publication.save()) {
              flash.message = message(code: "object.updated", args: [message(code: "publication"), publication.name])
              chain (action: 'list', id: publication.entity.id)
          }
          else {
              render view: 'edit', model: [publication: publication]
          }
      }
      else {
          flash.message = message(code: "object.notFound", args: [message(code: "publication")])
          redirect action: "list", id: publication.entity.id
      }
  }


}
