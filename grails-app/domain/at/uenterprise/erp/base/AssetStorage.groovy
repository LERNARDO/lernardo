package at.uenterprise.erp.base

class AssetStorage {

  static hasMany = [assets: Asset]

  String  storageId
  String  contentType

  static constraints = {
  }

}
