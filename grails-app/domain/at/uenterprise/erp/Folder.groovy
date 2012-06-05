package at.uenterprise.erp

class Folder {

  static belongsTo = [folder: Folder]

  List folders, favorites
  static hasMany = [folders: Folder, favorites: Favorite]

  String      name
  String      description
  FolderType  type

  static constraints = {
    folder nullable: true
  }

  String toString() {
    return "${name}"
  }
}
