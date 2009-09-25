class BootStrap {
    def profileDataService
    def templateDataService
    def activityDataService
    def articleDataService

    def init = {servletContext->
        profileDataService.init()
        templateDataService.init()
        activityDataService.init()
        articleDataService.init()
    }

    def destroy = {
    }
} 