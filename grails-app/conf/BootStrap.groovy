class BootStrap {
     def profileDataService
     def actionsDataService

     def init = {servletContext->
      profileDataService.initProfiles();
      // todo: add actionsDataService.initActions();
     }

     def destroy = {
     }
} 