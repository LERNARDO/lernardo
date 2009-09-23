class BootStrap {
     def profileDataService
     def templateDataService
     def activityDataService

     def init = {servletContext->
      profileDataService.init()
      templateDataService.init()
      activityDataService.init()
     }

     def destroy = {
     }
} 