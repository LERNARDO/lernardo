package at.uenterprise.erp.base

import org.springframework.web.multipart.MultipartFile
import at.uenterprise.erp.base.util.HashTools
import at.uenterprise.erp.base.asset.IByteStore
import at.uenterprise.erp.base.asset.IByteStore

class AssetService {
    boolean transactional = true
    IByteStore assetStore

    AssetStorage findStorage (String sid) {
      AssetStorage.findByStorageId (sid)
    }


   /**
   * finds storage based on entity, type and optional selector
    */
    AssetStorage findStorage (Entity ent, String type, String selector='latest') {
      def assets = Asset.createCriteria().list {
        and {
          eq ('entity', ent)
          eq ('type', type)
        }
        order("lastUpdated", "desc")
      }

      if (!assets)
        return null

      if (assets.size() == 1)
        return assets[0].storage

      if (selector == 'latest')
        return assets [0].storage
      else
        return assets[-1].storage
    }

    def withContent (AssetStorage store, Closure c) {
      if (!store)
        return (false)

      byte[] content = assetStore.get(store.storageId)
      if (!content)
        throw new AssetException(message:"no physical asset stored under $sid")

      return c.call(content, store.contentType)
    }


    void renderStorage (AssetStorage store, def response) {
      if (!store) {
        response.sendError (404, "no such asset")
        return
      }

      try {
        withContent(store) {content, contentType->
          log.debug ("render asset $store.storageId ($store.contentType) to response")
          response.contentType = contentType
          response.outputStream << content
          response.outputStream.flush ()
        }
      }
      catch (RuntimeException e) {
        response.sendError (500, e.message)
      }
    }




   /**
    * creates and if necessary stores an asset from the given data.
    * The corresponding storage is identified by a SHA hash (of the content) and re-used if already
    * exists. This will avoid duplicate storage and has other interesting usages
    */
    def storeAsset(Entity ent, String type, String contentType, byte[] content) {
      def sid = HashTools.SHA(content)

      // see if we have it already stored somehow ...
      def store = findStorage(sid)
      if (!store) {
        store = new AssetStorage (storageId:sid, contentType:contentType)
        assetStore.put (sid, content)
        store = store.save()
      }

      // now see if we have a linked asset for this user type and storage
      def asset = Asset.createCriteria().get {
        and {
          eq ('entity', ent)
          eq ('type', type)
          eq ('storage', store)
        }
      }
      
      // if the new asset is of type "profile" delete the existing (if any) asset of this type
      if (type == "profile") {
        Asset.findByEntityAndType(ent, "profile")?.delete()
      }

      // only if it's not there, create a new one and link it with the storage
      if (!asset) {
        asset = new Asset(entity:ent, storage:store, type:type)
        if (!asset.save()) {
          asset.errors.allErrors.each {
            log.error ("create asset $asset: field: '$it.field' code: $it.code, rejectedValue: $it.rejectedValue")
          }
          return null
        }
      } else {
        // update the timestamp so it comes out first with selection 'latest' and such
        asset.lastUpdated = new Date()
        asset.save()
      }

      // also delete unreferenced asset storages
      List ast = AssetStorage.list()
      ast.each {AssetStorage assetStorage ->
        if (assetStorage?.assets?.size() == 0)
          assetStorage.delete()
      }

      log.debug ("asset for $ent.name of type $type is stored as $sid")
      return asset
    }


   /**
   * convenient shortcut to be used by controller
    */
    def storeAsset(Entity ent, String type, MultipartFile mfile) {
      storeAsset(ent, type, mfile.contentType, mfile.getBytes())
    }



}

class AssetException extends RuntimeException {
  String message
  Asset asset
}
