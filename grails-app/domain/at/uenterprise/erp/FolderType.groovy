package at.uenterprise.erp

class FolderType {

  static hasMany = [folders: Folder]

  String  name

  static constraints = {
  }
}
