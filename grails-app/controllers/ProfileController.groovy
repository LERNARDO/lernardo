import grails.converters.JSON

class ProfileController {
    def profileDataService
    def activityDataService
    def geoCoderService

    def index = { }

    def geocode = {
        def result = geoCoderService.geocodeLocation(params.name)
        render result as JSON
    }

    def list = {
        params.profileType = params.profileType ?: "all"
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        return ['profileType': params.profileType,
                'profileList': profileDataService.getProfiles (params.profileType, params.offset, params.max),
                'profileCount': profileDataService.getProfileCount (params.profileType)]
    }

    def show = {
        def prf = profileDataService.getProfile (params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return ;
        }
        def content = params.content ?: "profile"
        def location = geoCoderService.geocodeLocation(prf.ort)
        return ['profileInstance':prf,
                'content':content,
                'activityList':activityDataService.findByOwner(params.name),
                'location':location]
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
