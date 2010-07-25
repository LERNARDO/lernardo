package standard

/*
 * this was implemented in order to keep track of the number of currently active sessions
 * it only worked locally so it's not used right now
 */
class ApplicationService {
  static scope = "singleton"
  static transactional = false

  static activeSessions = 0L
  static allSessions = 0L
}
