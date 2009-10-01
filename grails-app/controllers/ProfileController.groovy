class ProfileController {
    def profileDataService
    def activityDataService

    def index = { }

    def list = {
        params.profileType = params.profileType ?: "all"
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        def res = ['profileType': params.profileType,
                   'profileList': profileDataService.getProfiles (params.profileType, params.offset, params.max),
                   'profileCount': profileDataService.getProfileCount (params.profileType)]
        render (view:"list", model:res)
    }

    def show = {
        def prf = profileDataService.getProfile (params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return ;
        }
        def content = params.content ?: "profile"

        def bla = [profileInstance:prf,content:content,activityList:activityDataService.getActivitiesOfOwner(params.name)]
        render (view:"show", model:bla)
    }

    def edit = {
        def prf = profileDataService.getProfile (params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return ;
        }

        render (view:"edit_${prf.type ? prf.type:'other'}", model:prf)
    }

    // not working
    def save = {
        profileDataService.addProfile(params.name, params)
        def prf = profileDataService.getProfile (params.name)
        render (view:"show_${prf.type ? prf.type:'other'}", model:prf)
    }

}
