package at.uenterprise.erp

import jxl.*
import jxl.write.*
import at.openfactory.ep.Entity
import at.openfactory.ep.EntityHelperService

class ExcelController {
  FunctionService functionService
  MetaDataService metaDataService
  EntityHelperService entityHelperService

  def report = {
    Entity entity = Entity.get(params.id)

    def file = createReport(entity)

    response.setContentType("application/vnd.ms-excel")
    response.setHeader('Content-disposition', 'attachment;filename=' + entity.profile.fullName + '.xls')
    response.setHeader('Content-length', "${file.size()}")

    OutputStream out = new BufferedOutputStream(response.outputStream)

    try {
      out.write(file.bytes)

    } finally {
      out.close()
      return false
    }
  }

  private File createReport(Entity entity) {
    Entity currentEntity = entityHelperService.loggedIn
    
    WorkbookSettings workbookSettings = new WorkbookSettings()
    workbookSettings.locale = Locale.default

    def file = File.createTempFile('myExcelDocument', '.xls')
    file.deleteOnExit()

    WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)

    WritableFont font = new WritableFont(WritableFont.ARIAL, 10)
    WritableCellFormat format = new WritableCellFormat(font)

    // Create a cell format for Times 16, bold and italic
    WritableFont fontBold = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD);
    WritableCellFormat formatBold = new WritableCellFormat (fontBold);

    WritableSheet sheet = workbook.createSheet('MyTestSheet', 0)

    // auto-size cells
    for (int x = 0; x < 7; x++)
    {
      def cell = sheet.getColumnView(x)
      cell.setAutosize(true)
      sheet.setColumnView(x, cell)
    }

    // client group
    if (entity.type.id == metaDataService.etGroupClient.id) {

      // find all clients of group
      List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)

      // name
      sheet.addCell(new jxl.write.Label(0, 0, message(code: 'name'), formatBold))
      sheet.addCell(new jxl.write.Label(1, 0, entity.profile.fullName, format))

      // description
      sheet.addCell(new jxl.write.Label(0, 1, message(code: 'description'), formatBold))
      sheet.addCell(new jxl.write.Label(1, 1, entity.profile.description, format))

      // creator
      sheet.addCell(new jxl.write.Label(0, 3, message(code: 'creator'), formatBold))
      sheet.addCell(new jxl.write.Label(1, 3, message(code: 'createdBy', args: [currentEntity.profile.fullName, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]), format))

      // column headers
      sheet.addCell(new jxl.write.Label(0, 5, message(code: 'firstName'), formatBold))
      sheet.addCell(new jxl.write.Label(1, 5, message(code: 'lastName'), formatBold))
      sheet.addCell(new jxl.write.Label(2, 5, message(code: 'birthDate'), formatBold))
      sheet.addCell(new jxl.write.Label(3, 5, message(code: 'street'), formatBold))
      sheet.addCell(new jxl.write.Label(4, 5, message(code: 'groupColony'), formatBold))
      sheet.addCell(new jxl.write.Label(5, 5, message(code: 'country'), formatBold))
      sheet.addCell(new jxl.write.Label(6, 5, message(code: 'parents') + " & " + message(code: 'phone'), formatBold))

      def row = 6
      clients.each { Entity client ->
        sheet.addCell(new jxl.write.Label(0, row, client.profile.firstName, format))
        sheet.addCell(new jxl.write.Label(1, row, client.profile.lastName, format))
        sheet.addCell(new jxl.write.Label(2, row, formatDate(date: client.profile.birthDate, format: 'dd.MM.yyyy'), format))
        sheet.addCell(new jxl.write.Label(3, row, client.profile.currentStreet, format))
        Entity colony = functionService.findByLink(null, client, metaDataService.ltColonia)
        sheet.addCell(new jxl.write.Label(4, row, fieldValue(bean: colony, field: 'profile.fullName').decodeHTML() ?: message(code:'noData'), format))
        sheet.addCell(new jxl.write.Label(5, row, client.profile.currentCountry, format))

        // find family
        Entity family = functionService.findByLink(client, null, metaDataService.ltGroupFamily)

        // if there is a family, find parents
        List parents = functionService.findAllByLink(null, family, metaDataService.ltGroupMemberParent)
        
        String par = ""
        parents.each {Entity parent ->
          par = par + parent.profile.fullName + ': ' + (parent?.profile?.phone ?: message(code: 'noData')) + ', '
        } 
        sheet.addCell(new jxl.write.Label(6, row++, par, format))
      }

    }

    workbook.write()
    workbook.close()

    return file
  }
}
