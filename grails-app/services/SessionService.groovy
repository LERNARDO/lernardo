// Session counter by: http://www.ecotronics.ch/webdesign/grails.htm

class SessionService {
  static scope = "session"
  static transactional = false

  //Constructor
  public SessionService() {
    ApplicationService.allSessions++
    ApplicationService.activeSessions++
  }

  protected void finalize() {
    if (ApplicationService.activeSessions > 0) {
      ApplicationService.activeSessions--
    }
  }
}
