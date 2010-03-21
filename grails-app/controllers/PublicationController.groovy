
import de.uenterprise.ep.Entity
import org.springframework.web.multipart.MultipartFile
import lernardo.Publication

class PublicationController {
  def filterService
  def metaDataService
  def publicationHelperService
  def entityHelperService
  def assetService
  def networkService

  def index = { }

  def profile = {
    params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
    Entity e = params.id ? Entity.get(params.id) : entityHelperService.loggedIn
    if (!e) {
      response.sendError (404, 'no such profile')
      return
    }

    Map finalMap = [:]
    def pubs = publicationHelperService.findPublicationsByType(e)
    finalMap = pubs

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
      if (!networkService.isFriendOf(e, entityHelperService.loggedIn)) {
        pubs.value.each {
          if (it.accesslevel < 2) {
            finalMap.value << it
          }
        }
      }
      pubs = finalMap
      // if i'm not in the network drop those pubs
      if (!networkService.isNetworkOf(e, entityHelperService.loggedIn)) {
        pubs.value.each {
          if (it.accesslevel < 1) {
            finalMap.value << it
          }
        }
      }
      //pubs = finalMap
    }*/

    return [entity:e, pubtypes:finalMap]
  }

  def create = {
    Entity entity = Entity.get(params.id)
    def pub = new Publication()
    return [entity:entity, publication:pub]
  }

  def save = {
    Entity e = params.id ? Entity.get(params.id) : entityHelperService.loggedIn
    if (!e) {
      response.sendError (404, 'no such profile')
      return
    }

    def pub = new Publication(params)
    pub.entity = e ?: entityHelperService.loggedIn

    // handle the file
    MultipartFile mpf = request.getFile('file')
    if (mpf?.empty)
      pub.errors.reject ('publication.file.nullable.error')
    else {
      pub.asset = assetService.storeAsset (pub.entity, "Publication", mpf)
      log.debug "created asset $pub.asset.id of type $pub.asset.storage.contentType with storage $pub.asset.storage.storageId "
    }

    log.debug "attempt to save publication: $params"
    if(pub.save(flush:true) && !pub.hasErrors()) {
      flash.message = message(code:"publication.created", args:[pub.name])
      redirect (action:"profile", id:pub.entity.id)
    }
    else {
       render view:'create', model:[entity:e, publication:pub]
      }
  }

  def showasset = {
    def pub = Publication.get(params.id)
    if (!pub?.asset) {
      flash.message = message(code:"publication.notFound", args:[params.id])
      redirect (action:"profile", params:[name:params.name])
    }
    else {
      assetService.renderStorage (pub.asset?.storage, response)
    }
  }

  def delete = {
    def pub = Publication.get(params.id)
    def entity = pub.entity
    if (!pub) {
      flash.message = message(code:"publication.notFound", args:[params.id])
    }
    else {
      flash.message = message(code:"publication.deleted", args:[pub.name])
      pub.delete(flush:true)
    }

    redirect (action:"profile", id: entity.id)
  }

}
