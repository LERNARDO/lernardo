package at.uenterprise.erp

/**
 * This class represents global events that can be seen right after logging in
 *
 * @author  Alexander Zeillinger
 */
class Event {

  EVENT_TYPE type
  Integer who
  Integer what
  Date    date
  Date    dateCreated
  Date    lastUpdated

  static constraints = {

  }

}

enum EVENT_TYPE {ACTIVITY_TEMPLATE_CREATED,
                 COMMENT_CREATED,
                 HELPER_CREATED,
                 GROUP_ACTIVITY_TEMPLATE_CREATED,
                 PROJECT_TEMPLATE_CREATED,
                 THEME_CREATED,
                 PROJECT_DAY_MOVED}