class ProfileController {
    def profileDataService

    def index = { }

    def list = {
        params.profileType = params.profileType ?: "all"
        def res = ['profileType': params.profileType,
                 'profileList': profileDataService.listProfiles (params.profileType, "a", "b")]
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

    def paginate = {
        def max = Math.min(params.max?.toInteger() ?: 10, 100)
        def offset = params.offset?.toInteger() ?: 0

        def profiles = profileDataService.listProfiles (params.profileType, "a", "b")
        def total = profiles.count()

        // AAZ: "withCriteria" method does not work on lists, need to find another solution here
        def paginateList = profiles.withCriteria {
            maxResults max
            firstResult offset
        }
        return [profileList:paginateList,totalProfiles:total]
    }
}
