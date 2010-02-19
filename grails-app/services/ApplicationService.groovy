class ApplicationService {
  static scope = "singleton"
  static transactional = false

  static activeSessions = 0L
  static allSessions = 0L
}
