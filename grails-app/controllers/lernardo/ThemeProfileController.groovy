package lernardo

import de.uenterprise.ep.Entity
import de.uenterprise.ep.EntityType
import de.uenterprise.ep.EntityHelperService
import de.uenterprise.ep.ProfileHelperService
import standard.MetaDataService
import de.uenterprise.ep.Link
import de.uenterprise.ep.Profile

class ThemeProfileController {
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
        return[themeList: Entity.findAllByType(metaDataService.etTheme),
               themeTotal: Entity.countByType(metaDataService.etTheme)]
    }

    def show = {
        Entity theme = Entity.get( params.id )

        if(!theme) {
            flash.message = "themeProfile not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            def c = Entity.createCriteria()
            def allSubthemes = c.list {
              eq("type", metaDataService.etTheme)
              profile {
                eq("type", "Subthema")
              }
            }
            // find all subthemes of this theme
            def links = Link.findAllByTargetAndType(theme, metaDataService.ltSubTheme)
            List subthemes = links.collect {it.source}
            [theme: theme,
             entity: entityHelperService.loggedIn,
             allSubthemes: allSubthemes,
             subthemes: subthemes]
        }
    }

    def del = {
        Entity theme = Entity.get(params.id)
        if(theme) {
            // delete all links
            Link.findAllBySourceOrTarget(theme, theme).each {it.delete()}
            try {
                flash.message = message(code:"theme.deleted", args:[theme.profile.fullName])
                theme.delete(flush:true)
                redirect(action:"list")
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code:"theme.notDeleted", args:[theme.profile.fullName])
                redirect(action:"show",id:params.id)
            }
        }
        else {
            flash.message = "themeProfile not found with id ${params.id}"
            redirect(action:"list")
        }
    }

    def edit = {
        Entity theme = Entity.get(params.id)

        if(!theme) {
            flash.message = "themeProfile not found with id ${params.id}"
            redirect action:'list'
        }
        else {
            [theme: theme, entity: entityHelperService.loggedIn]
        }
    }

    def update = {
      Entity theme = Entity.get(params.id)

      theme.profile.properties = params

      if(!theme.profile.hasErrors() && theme.profile.save()) {
          flash.message = message(code:"theme.updated", args:[theme.profile.fullName])
          redirect action:'show', id: theme.id
      }
      else {
          render view:'edit', model:[theme: theme, entity: entityHelperService.loggedIn]
      }
    }

    def create = {
      return [entity: entityHelperService.loggedIn]
    }

    def save = {
      EntityType etTheme = metaDataService.etTheme

      try {
        Entity entity = entityHelperService.createEntity("theme", etTheme) {Entity ent ->
          ent.profile = profileHelperService.createProfileFor(ent) as Profile
          ent.profile.properties = params
        }
        flash.message = message(code:"theme.created", args:[entity.profile.fullName])
        redirect action:'list'
      } catch (de.uenterprise.ep.EntityException ee) {
        render (view:"create", model:[theme: ee.entity, entity: entityHelperService.loggedIn])
        return
      }

    }

    def addSubTheme = {
      Entity theme = Entity.get(params.id)

      // check if the child isn't already linked to the pate
      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.subtheme))
        eq('target', theme)
        eq('type', metaDataService.ltSubTheme)
      }
      if (!link)
        new Link(source:Entity.get(params.subtheme), target: theme, type:metaDataService.ltSubTheme).save()

      // find all subthemes of this theme
      def links = Link.findAllByTargetAndType(theme, metaDataService.ltSubTheme)
      List subthemes = links.collect {it.source}

      render template:'subthemes', model: [subthemes: subthemes, theme: theme, entity: entityHelperService.loggedIn]
    }

    def removeSubTheme = {
      Entity theme = Entity.get(params.id)

      def c = Link.createCriteria()
      def link = c.get {
        eq('source', Entity.get(params.subtheme))
        eq('target', theme)
        eq('type', metaDataService.ltSubTheme)
      }
      link.delete()

      // find all subthemes of this theme
      def links = Link.findAllByTargetAndType(theme, metaDataService.ltSubTheme)
      List subthemes = links.collect {it.source}

      render template:'subthemes', model: [subthemes: subthemes, theme: theme, entity: entityHelperService.loggedIn]
    }
}
