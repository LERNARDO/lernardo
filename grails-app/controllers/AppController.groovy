import at.openfactory.ep.Entity
import at.openfactory.ep.Account
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.SecHelperService
import at.openfactory.ep.EntityHelperService
import at.openfactory.ep.Tag
import standard.FunctionService
import at.openfactory.ep.TagLinkType
import at.openfactory.ep.EntityTagLink
import at.openfactory.ep.Asset
import standard.MetaDataService

class AppController {
  SecHelperService secHelperService
  EntityHelperService entityHelperService
  def securityManager
  FunctionService functionService
  MetaDataService metaDataService

  def error404 = {
    render view: '/404'
  }

  def updatelinks = {

    Entity entity = Entity.get(params.id)

    if (params.type == 'groupActivities') {
      List groupActivities = []
      if (entity.type.id == metaDataService.etEducator.id)
        groupActivities = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberEducator)
      else if (entity.type.id == metaDataService.etParent.id)
        groupActivities = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberParent)
      else if (entity.type.id == metaDataService.etPartner.id)
        groupActivities = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberPartner)
      else if (entity.type.id == metaDataService.etFacility.id)
        groupActivities = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberFacility)
      else if (entity.type.id == metaDataService.etClient.id)
        groupActivities = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
      render template: "/templates/linkscontent", model: [list: groupActivities]
    }

    if (params.type == 'projects') {
      List projects = []
      if (entity.type.id == metaDataService.etEducator.id) {
        List days = functionService.findAllByLink(entity, null, metaDataService.ltProjectDayEducator)
        days.each {
          projects << functionService.findByLink(it as Entity, null, metaDataService.ltProjectMember)
        }
      }
      else if (entity.type.id == metaDataService.etFacility.id)
        projects = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberFacility)
      else if (entity.type.id == metaDataService.etClient.id)
        projects = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
      else if (entity.type.id == metaDataService.etParent.id) {
        // find all project units the entity is linked to
        List projectUnits = functionService.findAllByLink(entity, null, metaDataService.ltProjectUnitParent)

        // for each project unit find all project days they are linked to
        List projectDays = []
        projectUnits.each {
          def result = functionService.findByLink(it as Entity, null, metaDataService.ltProjectDayUnit)
          if (!projectDays.contains(result))
            projectDays << result
        }

        // for each project day find all projects they are linked to
        projectDays.each {
          projects << functionService.findByLink(it as Entity, null, metaDataService.ltProjectMember)
        }
      }
      else if (entity.type.id == metaDataService.etPartner.id) {
        List projectUnits = functionService.findAllByLink(entity, null, metaDataService.ltProjectUnitParent)

        List projectDays = []
        projectUnits.each {
          def result = functionService.findByLink(it as Entity, null, metaDataService.ltProjectDayUnit)
          if (!projectDays.contains(result))
            projectDays << result
        }

        projectDays.each {
          projects << functionService.findByLink(it as Entity, null, metaDataService.ltProjectMember)
        }
      }
      render template: "/templates/linkscontent", model: [list: projects]
    }

    if (params.type == 'activities') {
      List activities = []
      if (entity.type.id == metaDataService.etClient.id)
        activities = functionService.findAllByLink(entity, null, metaDataService.ltActClient)
      else if (entity.type.id == metaDataService.etEducator.id)
        activities = functionService.findAllByLink(entity, null, metaDataService.ltActEducator)
      else if (entity.type.id == metaDataService.etFacility.id)
        activities = functionService.findAllByLink(entity, null, metaDataService.ltActFacility)
      render template: "/templates/linkscontent", model: [list: activities]
    }

    if (params.type == 'families') {
      List families = []
      if (entity.type.id == metaDataService.etParent.id)
        families = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberParent)
      else if (entity.type.id == metaDataService.etClient.id)
        families = functionService.findAllByLink(entity, null, metaDataService.ltGroupFamily)
      else if (entity.type.id == metaDataService.etChild.id)
        families = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberChild)
      render template: "/templates/linkscontent", model: [list: families]
    }

    if (params.type == 'colonies') {
      List colonies = []
      if (entity.type.id == metaDataService.etFacility.id)
        colonies = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberFacility)
      else if (entity.type.id == metaDataService.etPartner.id)
        colonies = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberPartner)
      render template: "/templates/linkscontent", model: [list: colonies]
    }

    if (params.type == 'facilities') {
      List facilities = []
      if (entity.type.id == metaDataService.etEducator.id)
        facilities = functionService.findAllByLink(entity, null, metaDataService.ltWorking)
      else if (entity.type.id == metaDataService.etClient.id)
        facilities = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
      render template: "/templates/linkscontent", model: [list: facilities]
    }

    if (params.type == 'clientgroups') {
      List clientgroups = functionService.findAllByLink(entity, null, metaDataService.ltGroupMemberClient)
      render template: "/templates/linkscontent", model: [list: clientgroups]
    }

    if (params.type == 'partnergroups') {
      List partnergroups = functionService.findAllByLink(entity, null, metaDataService.ltGroupMember)
      render template: "/templates/linkscontent", model: [list: partnergroups]
    }

  }

  /*
   * this should forward the exception to the developer then render the 500 view
   * TODO: complete the mail part
   */
  def error500 = {
    println params

    /*try {
      sendMail {
        to      "aaz@uenterprise.de"
        subject "Lernardo - Fehler 500"
        html    g.render(template:'/errortemplate', model:[request:params.request, exception: params.exception])
      }
    } catch(Exception ex) {
      log.error "Problem sending email $ex.message", ex
    }*/

    render view: '/500'
  }

  /*
   * this is the private start
   */
  def start = {
    Entity currentEntity = entityHelperService.loggedIn
    if (currentEntity) {
      Locale locale = currentEntity.user?.locale ?: new Locale("de", "DE");
      RequestContextUtils.getLocaleResolver(request).setLocale(request, response, locale)

      redirect controller: 'profile', action: 'showNews', id: currentEntity.id
    }
    else
      redirect action: 'home'
  }

  /*
   * this is the public start
   */
  def home = {
    redirect controller: 'articlePost', action: 'index'
  }

  /*
   * renders a view where the user can change his password
   */
  def password = {
    return ['params': params]
  }

  /*
   * resets the password of the user and sends him a new password
   */
  def sendPassword = {
    Account user = Account.findByEmail(params.email)
    if (user) {
      Entity e = Entity.findByUser(user)

      // generate new random password
      Random randomGenerator = new Random()
      def random = randomGenerator.nextInt(300) + 100
      String pass = 'pass' + random.toString()
      user.password = securityManager.encodePassword(pass)
      try {
        sendMail {
          to "${user.email}"
          subject "Lernardo - Dein Passwort"
          html g.render(template: 'passwordemail', model: [entity: e, password: pass])
        }
      } catch (Exception ex) {
        log.error "Problem sending email $ex.message", ex
      }
      flash.message = message(code: "account.message", args: [params.email])
      redirect controller: 'articlePost', action: 'index'
    }
    else {
      flash.message = message(code: "account.notFound", args: [params.email])
      render view: 'password', model: [params: params]
    }
  }

  /*
   * adds a tag to an entity
   */
  def addTag = {
    Entity entity = Entity.get(params.entity)
    Tag tag = Tag.findByName(params.tag)

    // make sure the entity isn't already marked with this tag
    if (!EntityTagLink.findByTagAndEntity(tag, entity)) {
      TagLinkType tlt = new TagLinkType(name: 'default').save()

      EntityTagLink etl = new EntityTagLink(tag: tag, entity: entity, type: tlt).save() // IntelliJ fails to recognize the "tag" relationship
      entity.addToTagslinks(etl)
      tag.addToEntityLinks(etl)

    }
    //else {
    //render '<span class="red italic">' + entity.profile.fullName + ' ist bereits als ' + tag.name + ' getaggt!</span>'
    //}

    // get all tags of the entity
    List tags = entity.tagslinks.collect {it.tag}

    render template: '/app/tags', model: [tags: tags, entity: entity, update: params.update]
  }

  /*
   * removes a tag from an entity
   */
  def removeTag = {
    Entity entity = Entity.get(params.entity)
    Tag tag = Tag.get(params.tag)

    EntityTagLink etl = EntityTagLink.findByTagAndEntity(tag, entity)

    entity.removeFromTagslinks(etl)
    tag.removeFromEntityLinks(etl)

    etl.delete()

    List tags = entity.tagslinks.collect {it.tag}

    render template: '/app/tags', model: [tags: tags, entity: entity, update: params.update]
  }

  /*
   * deletes the profile pic of a given entity
   */
  def deleteProfilePic = {
    Entity entity = Entity.get(params.id)

    Asset asset = Asset.findByEntity(entity)
    entity.removeFromAssets(asset)
    asset.delete()

    flash.message = "Profilbild wurde gel�scht!"
    redirect controller: entity.type.supertype.name + 'Profile', action: 'show', id: entity.id, params: [entity: entity.id]
  }
}
