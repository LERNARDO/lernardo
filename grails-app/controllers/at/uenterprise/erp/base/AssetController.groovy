package at.uenterprise.erp.base

import org.springframework.web.multipart.MultipartFile

class AssetController {
  def assetService
  def entityHelperService
  def secHelperService

  def index = { }

   /**
    * renders  a single (binary) asset based on 'entity', 'type' and 'content-type' parameters. if there's more than one for this type, the select param
    * determines which one is taken. Currently only <latest> is supported, but there will be probably
    * thinks like <random>, etc in the future
    */
  def get = {
    Entity ent = Entity.findByName (params.entity)
    if (!ent) {
      response.sendError(404, "no such entity: '$params.entity")
      return
    }

    AssetStorage store = assetService.findStorage(ent, params.type, params.select ?: 'latest' )
    if (!store) {
//      response.sendError(404, 'no matching asset')
        def res = grailsApplication.mainContext.getResource ("${pluginContextPath}/images/default_asset.jpg")
        if (res) {
          response.contentType = "image/jpg"
          response.outputStream << res.inputStream
          response.outputStream.flush ()
        }
      return
    }

    assetService.renderStorage (store, response)
  }


   /**
    * renders a single (binary) asset by a given (storage)id
    */
  def getstore = {
    if (!params.id) {
      flash.message "missing 'id' parameter"
      return
    }

    AssetStorage store = assetService.findStorage(params.id)
    if (!store) {
      response.sendError(404, "no such storage")
      return
    }

    assetService.renderStorage (store, response)
  }


  /**
   * gets a list of assets based on entity and type
   */
  def list = {

  }

  /**
   * generic target for multipart uploads via forms. either pass in 'type' via a hidden field
   * 'asset' is the name if the input file tag, type determines the type of the asset which is specific to your application
   * some agreed on types are 'profile' for profile images and 'album' for a simple user photo album
   * from the form or (preferred) define your own action in your controller and forward to here (see 'putprf' below)
   */
  def put = {
    if (!entityHelperService.loggedIn) {
      flash.message = "for upload your need to be logged in"
      redirect (controller:'login', action:'denied')
      return
    }

    Entity ent = null
    if (params.entity) {
      ent = Entity.findByName(params.entity)
      if (!ent) {
        flash.message = "no such entity: '$params.entity"
        return [:]
      }
      /*if (!secHelperService.isMeOrAdmin(ent)) {
        flash.message = "you're not allowed to upload for others"
        redirect (controller:'login', action:'denied')
        return
      }*/
    }
    ent = ent ?: entityHelperService.loggedIn


    MultipartFile asset = request.getFile ('asset')
    if (asset && !asset.empty) {
      log.debug ("uploaded asset name:'$asset.name', size:'$asset.size', content:'$asset.contentType' ")
      log.debug ("type: $params.type")

      def result = assetService.storeAsset(ent, params.type, asset)
      if (!result) 
        flash.message = 'uploading the asset went bad somehow'

      [asset: result, entity: ent]
    }
  }

  def putprf = {
    forward(action:"put", params:[type:"profile"])
  }

  def upload = {
  }

  def uploadprf = {
  }

}
