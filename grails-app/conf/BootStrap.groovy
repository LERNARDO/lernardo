class BootStrap {
     def profileDataService

     def init = {servletContext->
      profileDataService.initProfiles() ; 
     }

     def destroy = {
     }
} 