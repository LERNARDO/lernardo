class BootStrap {
     def profileDataService
     def actionsDataService

     def init = {servletContext->
      profileDataService.initProfiles()
      actionsDataService.initActions()
     }

     def destroy = {
     }
} 