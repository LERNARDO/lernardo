class ProfileController {
    def profileDataService

    def index = { }

    def list = {
      params.profileType = params.profileType ? params.profileType : "paed"
      def res = ['profileType': params.profileType]
    }

    def show = {
      def prf = profileDataService.getProfile (params.name)
      println "SHOW PRF: ${prf.dump()}"
      if (!prf) {
        response.sendError(404, "user profile not found")
        return ;
      }
      println "attempt to render type: $prf.type"
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
