package at.uenterprise.erp.base

class Asset {
  static belongsTo = [entity: Entity]

  AssetStorage  storage
  String        type
  Date          dateCreated
  Date          lastUpdated

  static constraints = {
  }

  String toString() {
    "Asset: $id ($type)"
  }

}
