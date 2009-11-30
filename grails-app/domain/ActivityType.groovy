// not used yet

class ActivityType {

  static hasMany = [ activities : Activity, templates : ActivityTemplate ]

  String name

  static constraints = {
    name (blank:false)
  }
}
