class ProfileController {
    def profileDataService

    def index = { }

    def list = {
      params.profileType = params.profileType ?: "paed"


      def res = ['profileType': params.profileType]
    }

    def show = {
      def prf = profileDataService.getProfile (params.name)
      if (!prf) {
        response.sendError(404, "user profile not found")
        return ;
      }

      render (view:"show_${prf.type ? prf.type:'other'}", model:prf)
    }



}
