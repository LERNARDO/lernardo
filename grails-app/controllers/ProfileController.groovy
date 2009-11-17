import grails.converters.JSON
import de.uenterprise.ep.Entity

class ProfileController {
    def profileDataService
    def activityDataService
    def geoCoderService
    def networkService

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

}
