
import at.openfactory.ep.Entity
import org.springframework.web.multipart.MultipartFile
import lernardo.Publication
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.AssetService
import standard.MetaDataService
import standard.FilterService
import standard.PublicationHelperService
import standard.FunctionService

class PublicationController {
  FilterService filterService
  MetaDataService metaDataService
  PublicationHelperService publicationHelperService
  EntityHelperService entityHelperService
  AssetService assetService
  FunctionService functionService

  def index = { }

  def profile = {
    params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
    Entity entity = params.id ? Entity.get(params.id) : entityHelperService.loggedIn
    if (!entity) {
      response.sendError (404, 'no such profile')
      return
    }

    List publications = publicationHelperService.findPublicationsOfEntity(entity)

    // (1)
    // if the entity is a group activity template find all documents of the activity templates linked to it
    List activitytemplatesdocuments = []
    if (entity.type.id == metaDataService.etGroupActivityTemplate.id) {
      // find all activity templates linked to the group activity template
      List activitytemplates = functionService.findAllByLink(null, entity, metaDataService.ltGroupMember)

      // get all documents
      activitytemplates.each {
        def bla = publicationHelperService.findPublicationsOfEntity(it as Entity)
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
      groupactivitytemplatesdocuments = publicationHelperService.findPublicationsOfEntity(groupactivitytemplate)

      // find all activity templates linked to the group activity template
      List activitytemplates = functionService.findAllByLink(null, groupactivitytemplate, metaDataService.ltGroupMember)

      // get all documents
      activitytemplates.each {
        def bla = publicationHelperService.findPublicationsOfEntity(it as Entity)
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
      projectUnits.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnitMember)
        bla.each {
          if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
            groupactivitytemplates << it
        }
      }

      // get documents of group activity templates
      groupactivitytemplates.each {
        def bla = publicationHelperService.findPublicationsOfEntity(it as Entity)
        bla.each {
          groupactivitytemplatesdocuments << it
        }
      }

      // find all activity templates linked to the group activity templates
      List activitytemplates = []
      groupactivitytemplates.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltGroupMember)
        bla.each {
          if (!activitytemplates.contains(it)) // filter duplicate activity templates
            activitytemplates << it
        }
      }

      // get all documents
      activitytemplates.each {
        def bla = publicationHelperService.findPublicationsOfEntity(it as Entity)
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
      projecttemplatedocuments = publicationHelperService.findPublicationsOfEntity(projectTemplate)

      // find all project units linked to the project template
      List projectUnits = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnit)

      // find all group activity templates
      List groupactivitytemplates = []
      projectUnits.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnitMember)
        bla.each {
          if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
            groupactivitytemplates << it
        }
      }

      // get documents of group activity templates
      groupactivitytemplates.each {
        def bla = publicationHelperService.findPublicationsOfEntity(it as Entity)
        bla.each {
          groupactivitytemplatesdocuments << it
        }
      }

      // find all activity templates linked to the group activity templates
      List activitytemplates = []
      groupactivitytemplates.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltGroupMember)
        bla.each {
          if (!activitytemplates.contains(it)) // filter duplicate activity templates
            activitytemplates << it
        }
      }

      // get all documents
      activitytemplates.each {
        def bla = publicationHelperService.findPublicationsOfEntity(it as Entity)
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

    return [entity: entity,
            publications: publications,
            activitytemplatesdocuments: activitytemplatesdocuments,
            groupactivitytemplatesdocuments: groupactivitytemplatesdocuments,
            projecttemplatedocuments: projecttemplatedocuments]
  }

  def create = {
    Entity entity = Entity.get(params.id)
    Publication pub = new Publication()
    return [entity:entity, publication:pub]
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

    // handle the file
    MultipartFile mpf = request.getFile('file')
    if (mpf?.empty)
      pub.errors.reject ('publication.file.nullable.error')
    else {
      pub.asset = assetService.storeAsset (pub.entity, "Publication", mpf)
      //log.debug "created asset $pub.asset.id of type $pub.asset.storage.contentType with storage $pub.asset.storage.storageId "
    }

    //log.debug "attempt to save publication: $params"
    if(pub.save(flush:true) && !pub.hasErrors()) {
      flash.message = message(code:"publication.created", args:[pub.name])
      redirect (action:"profile", id:pub.entity.id)
    }
    else {
       render view:'create', model:[entity: entity, publication:pub]
      }
  }

  def showasset = {
    Publication pub = Publication.get(params.id)
    if (!pub?.asset) {
      flash.message = message(code:"publication.notFound", args:[params.id])
      redirect (action:"profile", params:[name:params.name])
    }
    else {
      assetService.renderStorage (pub.asset?.storage, response)
    }
  }

  def delete = {
    Publication pub = Publication.get(params.id)
    Entity entity = pub.entity
    if (!pub) {
      flash.message = message(code:"publication.notFound", args:[params.id])
    }
    else {
      flash.message = message(code:"publication.deleted", args:[pub.name])
      pub.delete(flush:true)
    }

    redirect (action:"profile", id: entity.id)
  }

  def edit = {
      Publication pub = Publication.get(params.id)

      if(!pub) {
          flash.message = message(code:"publication.notFound", args:[params.id])
          redirect action:'list'
      }
      else {
          [entity: entityHelperService.loggedIn, publication: pub]
      }
  }

  def update = {
      Publication publication = Publication.get(params.id)
      if(publication) {
          publication.name = params.name
          if(!publication.hasErrors() && publication.save()) {
              flash.message = message(code:"publication.updated", args:[publication.name])
              redirect (action:'profile', params:[name:params.entity])
          }
          else {
              render view:'edit', model:[entity: entityHelperService.loggedIn, publication:publication]
          }
      }
      else {
          flash.message = message(code:"publication.notFound", args:[params.id])
          redirect action:"profile"
      }
  }


}
