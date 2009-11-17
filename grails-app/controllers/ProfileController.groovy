import grails.converters.JSON
import de.uenterprise.ep.Entity
import de.uenterprise.ep.Link

class ProfileController {
    def profileDataService
    def activityDataService
    def geoCoderService
    def networkService
    def entityHelperService
    def metaDataService

    def index = { }

    def geocode = {
        def result = geoCoderService.geocodeLocation(params.name)
        render result as JSON
    }

    def create = { }

    def print = {
        def image
        if (params.hort == 'Löwenzahn')
            image = "hort_loewenzahn.jpg"
        else if(params.hort == 'Kaumberg')
            image = "hort_kaumberg.jpg"
        return ['image':image, 'pdf':params,'profileList': profileDataService.getProfiles ('client', 0, 50)]
    }

    def attendance = {
        return ['profileList': profileDataService.getProfiles ('client', 0, 50),
                'profileCount': profileDataService.getProfileCount ('client')]
    }

    def list = {
        params.profileType = params.profileType ?: "all"
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        return ['profileType': params.profileType,
                'profileList': Entity.list(params),
                'profileCount': Entity.count()]
    }

    def show = {
        //def prf = profileDataService.getProfile (params.name)
        def e = Entity.findByName(params.name)
        if (!e) {
            response.sendError(404, "user profile not found")
            return ;
        }
        def content = params.content ?: "profile"
        def location = geoCoderService.geocodeLocation(e.profile.city)
        return ['profileInstance':e,
                'content':content,
                'activityList':activityDataService.findByOwner(params.name),
                'location':location,
                'friendsList':networkService.findFriendsOf(e)]
    }

    // not used atm
    def edit = {
        def prf = profileDataService.getProfile (params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return ;
        }

        render (view:"edit_${prf.type ? prf.type:'other'}", model:prf)
    }

    // not used atm
    def save = {
        profileDataService.addProfile(params.name, params)
        def prf = profileDataService.getProfile (params.name)
        render (view:"show_${prf.type ? prf.type:'other'}", model:prf)
    }

    def addFriend = {
      Entity e = params.name ? Entity.findByName(params.name) : null
      if (!e) {
        sendError (404)
        return
      }

      def linkInstance = new Link()
      linkInstance.source = entityHelperService.loggedIn
      linkInstance.type = metaDataService.ltFriend
      linkInstance.target = e ;

      // for now just create a back-link for mutuality - a more elaborate workflow will be in order later on
      def linkBack = new Link()
      linkBack.source = e ;
      linkBack.type = metaDataService.ltFriend
      linkBack.target = entityHelperService.loggedIn

      if(linkInstance.save(flush:true) && linkBack.save(flush:true)) {
        //flash.message = message(code:"addFriend", args:[linkInstance.target.profile.fullName])
        redirect action:'show', params:[name:linkInstance.target.name]
      }
      else {
        //flash.message = message(code:"addFriendFailed", args:[linkInstance.target.profile.fullName])
        redirect action:'show', params:[name:linkInstance.target.name]
      }
    }

    def removeFriend = {
      Entity e = Entity.findByName(params.name)
      def c = Link.createCriteria()
      def linkInstance = c.get {
        eq('source',entityHelperService.loggedIn)
        eq('target',e)
        eq('type',metaDataService.ltFriend)
      }
      def d = Link.createCriteria()
      def linkInstanceBack = d.get {
        eq('source',e)
        eq('target',entityHelperService.loggedIn)
        eq('type',metaDataService.ltFriend)
      }
      if(linkInstance && linkInstanceBack) {
            def n = linkInstance.target.name
            try {
                linkInstance.delete(flush:true)
                linkInstanceBack.delete(flush:true)
                //flash.message = message(code:"removeFriend", args:[e.profile.fullName])
                redirect action:'show', params:[name:n]
            }
            catch(org.springframework.dao.DataIntegrityViolationException ex) {
                //flash.message = message(code:"removeFriendFailed", args:[e.profile.fullName])
                redirect action:'show', params:[name:n]
            }
        }
    }

}
