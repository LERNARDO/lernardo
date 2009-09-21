class BootStrap {
     def profileDataService

     def init = {servletContext->
      profileDataService.initProfiles();
      // todo: add actionsDataService.initActions();
     }

     def destroy = {
     }
} 