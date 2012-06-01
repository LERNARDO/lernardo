package at.uenterprise.erp.base

public class Account {

  static belongsTo  = [entity: Entity]
  static hasMany    = [authorities: Role]
  static fetchMode  = [authorities: 'eager']

  String  email
  String  password
  boolean enabled
  Date    lastLogin
  Date    prevLogin
  Date    lastAction
  Locale  locale

  static constraints = {
    email       email: true, nullable: false, blank: false, unique: true
    lastLogin   nullable: true
    prevLogin   nullable: true
    lastAction  nullable: true
    locale      nullable: true
  }

}