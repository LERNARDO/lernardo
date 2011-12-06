package at.uenterprise.erp

import jxl.*
import jxl.write.*
import at.openfactory.ep.Entity

class ExcelController {
  FunctionService functionService
  MetaDataService metaDataService

  def report = {
    Entity entity = Entity.get(params.id)

    // find all clients of group
    List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)
    log.info clients

    def file = createReport(clients)

    response.setContentType("application/vnd.ms-excel")
    response.setHeader('Content-disposition', 'attachment;filename=MyReport.xls')
    response.setHeader('Content-length', "${file.size()}")

    OutputStream out = new BufferedOutputStream(response.outputStream)

    try {
      out.write(file.bytes)

    } finally {
      out.close()
      return false
    }
  }

  private File createReport(def list) {
    WorkbookSettings workbookSettings = new WorkbookSettings()
    workbookSettings.locale = Locale.default

    def file = File.createTempFile('myExcelDocument', '.xls')
    file.deleteOnExit()

    WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)

    WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
    WritableCellFormat format = new WritableCellFormat(font)

    def row = 0
    WritableSheet sheet = workbook.createSheet('MyTestSheet', 0)

    list.each {
      sheet.addCell(new jxl.write.Label(0, row, it.profile.fullName, format))
      sheet.addCell(new jxl.write.Label(1, row, formatDate(date: it.profile.birthDate, format: 'dd.MM.yyyy'), format))
      sheet.addCell(new jxl.write.Label(2, row, it.profile.currentStreet, format))
      sheet.addCell(new jxl.write.Label(3, row++, it.profile.currentCountry, format))
    }

    workbook.write()
    workbook.close()

    return file
  }
}
