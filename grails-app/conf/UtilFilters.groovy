class UtilFilters {

  def filters = {

    // source: http://techbeats.deluan.com/profiling-web-requests-in-grails-application
    profiler(controller: '*', action: '*') {
      before = {
        request._timeBeforeRequest = System.currentTimeMillis()
      }

      after = {
        request._timeAfterRequest = System.currentTimeMillis()
      }

      afterView = {
        if (params.showTime) {
          session._showTime = params.showTime == "on"
        }
        if (session._showTime) {
          def actionDuration = request._timeAfterRequest - request._timeBeforeRequest
          def viewDuration = System.currentTimeMillis() - request._timeAfterRequest
          log.info("Request duration for (${controllerName}/${actionName}): ${actionDuration}ms/${viewDuration}ms")
        }
      }
    }
  }

}
