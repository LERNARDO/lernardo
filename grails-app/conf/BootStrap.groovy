class BootStrap {
     def profileDataService
     def actionsDataService
     def activitiesDataService

     def init = {servletContext->
      profileDataService.initProfiles()
      actionsDataService.initActions()
      activitiesDataService.initActivities()
     }

     def destroy = {
     }
} 