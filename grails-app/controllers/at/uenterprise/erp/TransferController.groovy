package at.uenterprise.erp

import org.codehaus.groovy.grails.commons.ConfigurationHolder
import at.uenterprise.erp.profiles.ChildProfile

class TransferController {

    InterfaceMaintenanceService interfaceMaintenanceService
    def exportService

    def index = { }

    def importChildren = {

      def upload = request.getFile("file").inputStream

      interfaceMaintenanceService.importChildren(upload)

      flash.message = "children successfully imported"

      redirect action: 'index'
    }

    def exportChildren = {
      //if(!params.max) params.max = 10

      params.extension = 'xml'
      params.format = 'xml'

      if(params?.format && params.format != "html"){
          response.contentType = ConfigurationHolder.config.grails.mime.types[params.format]
          response.setHeader("Content-disposition", "attachment; filename=children.${params.extension}")

        List fields = ["firstName", "lastName", "birthDate", "gender", "job"]
        exportService.export(params.format, response.outputStream, ChildProfile.list(params), fields, [:], [:], [:])
      }

      flash.message = "children successfully exported"

    }
}
