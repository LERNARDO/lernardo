class ProfileController {
    def profileDataService

    def index = { }

    def show = {
        def prf = profileDataService.getProfile (params.name)
        if (!prf) {
            response.sendError(404, "user profile not found")
            return ;
        }
        render (view:"show_${prf.type ? prf.type:'other'}", model:prf)
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
