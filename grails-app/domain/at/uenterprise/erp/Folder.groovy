package at.uenterprise.erp

class Folder {

  String      name
  String      description
  Folder      folder
  FolderType  type

  static constraints = {
    folder nullable: true
  }
}
