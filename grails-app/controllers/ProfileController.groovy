class ProfileController {
    def profileDataService

    def index = { }

    def list = {
        params.profileType = params.profileType ?: "all"
        params.offset = params.offset ? params.offset.toInteger(): 0
        params.max = params.max ? params.max.toInteger(): 10
        def res = ['profileType': params.profileType,
                   'profileList': profileDataService.listProfiles (params.profileType, params.offset, params.max),
                   'totalProfiles': profileDataService.totalProfiles (params.profileType)]
        render (view:"list_${params.profileType}", model:res)
    }

    def show = {
        def prf = profileDataService.getProfile (params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return ;
        }
        render (view:"show_${prf.type ? prf.type:'other'}", model:prf)
    }

    def edit = {
        def prf = profileDataService.getProfile (params.id)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return ;
        }

        render (view:"edit_${prf.type ? prf.type:'other'}", model:prf)
    }

    def save = {
        def prf = profileDataService.getProfile (params.id)
        profileDataService.addProfile("lernardo", prf)
        redirect(url:"/lernardoV2/prf/lernardo")
    }

}
