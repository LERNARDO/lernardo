package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService

class FavoriteController {
  EntityHelperService entityHelperService

  def list() {
    return [type: "favorite"]
  }

  def editFavorite() {
    Favorite favorite = Favorite.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn
    List folders = getFolders(currentEntity.profile.favoritesFolder)
    render template: "editFavorite", model: [favorite: favorite, folders: folders]
  }

  def removeFavorite() {
    Favorite favorite = Favorite.get(params.id)
    favorite.folder.removeFromFavorites(favorite)
    favorite.delete(flush: true)
    render template: "folders"
  }

  def updateFavorite() {
    Favorite favorite = Favorite.get(params.id)
    favorite.description = params.description
    favorite.folder.removeFromFavorites(favorite)
    if (params.folder != 'none')
      favorite.folder = Folder.get(params.folder)
    else
      favorite.folder =  entityHelperService.loggedIn.profile.favoritesFolder
    favorite.save(failOnError: true, flush: true)
    favorite.folder.addToFavorites(favorite)
    render template: "folders"
  }

  def createFolder() {
    Entity currentEntity = entityHelperService.loggedIn
    List folders = getFolders(currentEntity.profile.favoritesFolder)
    render template: "createFolder", model: [folders: folders]
  }

  List getFolders(Folder f) {
    List folders = []
    f.folders.each {
      List temp = getFolders(it)
      folders.addAll(temp)
      folders.add(it)
    }
    return folders
  }

  def saveFolder() {
    Folder folder = new Folder()
    folder.name = params.name
    folder.description = params.description
    if (params.folder != 'none')
      folder.folder = Folder.get(params.folder)
    else
      folder.folder =  entityHelperService.loggedIn.profile.favoritesFolder
    folder.type = FolderType.findByName("favorite")
    folder.save(failOnError: true, flush: true)
    folder.folder.addToFolders(folder)
    render template: "folders"
  }

  def updateFolder() {
    Folder folder = Folder.get(params.id)
    folder.name = params.name
    folder.description = params.description
    if (params.folder != 'none')
      folder.folder = Folder.get(params.folder)
    else
      folder.folder =  entityHelperService.loggedIn.profile.favoritesFolder
    folder.type = FolderType.findByName("favorite")
    folder.save(failOnError: true, flush: true)
    render template: "folders"
  }

  def editFolder() {
    Folder folder = Folder.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn
    List folders = getFolders(currentEntity.profile.favoritesFolder)
    render template: "editFolder", model:[folder: folder, folders: folders]
  }

  def removeFolder() {
    Folder folder = Folder.get(params.id)
    folder.folder.removeFromFolders(folder)
    folder.delete(flush: true)
    render template: "folders"
  }

  def moveFolderUp = {
    Folder folder = Folder.get(params.id)
    if (folder.folder.folders.indexOf(folder) > 0) {
      int i = folder.folder.folders.indexOf(folder)
      use(Collections){ folder.folder.folders.swap(i, i - 1) }
    }
    render template: "folders"
  }

  def moveFolderDown = {
    Folder folder = Folder.get(params.id)
    if (folder.folder.folders.indexOf(folder) < folder.folder.folders.size() - 1) {
      int i = folder.folder.folders.indexOf(folder)
      use(Collections){ folder.folder.folders.swap(i, i + 1) }
    }
    render template: "folders"
  }

  def moveFavoriteUp = {
    Favorite favorite = Favorite.get(params.id)
    if (favorite.folder.favorites.indexOf(favorite) > 0) {
      int i = favorite.folder.favorites.indexOf(favorite)
      use(Collections){ favorite.folder.favorites.swap(i, i - 1) }
    }
    render template: "folders"
  }

  def moveFavoriteDown = {
    Favorite favorite = Favorite.get(params.id)
    if (favorite.folder.favorites.indexOf(favorite) < favorite.folder.favorites.size() - 1) {
      int i = favorite.folder.favorites.indexOf(favorite)
      use(Collections){ favorite.folder.favorites.swap(i, i + 1) }
    }
    render template: "folders"
  }
}
