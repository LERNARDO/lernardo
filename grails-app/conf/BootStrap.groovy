class BootStrap {
    def profileDataService
    def templateDataService
    def activityDataService
    def articleDataService
    def defaultObjectService ;

    def init = {servletContext->
        profileDataService.init()
        templateDataService.init()
        activityDataService.init()
        articleDataService.init()

        // init metadata if DB is empty
        defaultObjectService.onEmptyDatabase {
          log.info "initializing empty database"
          defaultObjectService.makeMetaData()
        }

    }

    def destroy = {
    }
} 