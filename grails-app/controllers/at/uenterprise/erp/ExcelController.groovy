package at.uenterprise.erp

import jxl.*
import jxl.write.*
import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.EntityHelperService
import java.text.SimpleDateFormat

class ExcelController {
  FunctionService functionService
  MetaDataService metaDataService
  EntityHelperService entityHelperService
  LinkDataService linkDataService

  def report = {
    Entity entity = Entity.get(params.id)

    def file = createReport(entity, params)

    response.setContentType("application/vnd.ms-excel")
    response.setHeader('Content-disposition', 'attachment;filename=Excel.xls')
    response.setHeader('Content-length', "${file.size()}")

    OutputStream out = new BufferedOutputStream(response.outputStream)

    try {
      out.write(file.bytes)

    } finally {
      out.close()
      return false
    }
  }

  private File createReport(Entity entity, def params = [:]) {
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

    // client group
    if (params.type == 'clientgroup') {

      WritableSheet sheet = workbook.createSheet(entity.profile, 0)

      // auto-size cells
      for (int x = 0; x < 22; x++)
      {
        def cell = sheet.getColumnView(x)
        cell.setAutosize(true)
        sheet.setColumnView(x, cell)
      }
      
      // find all clients of group
      List clients = functionService.findAllByLink(null, entity, metaDataService.ltGroupMemberClient)

      // name
      sheet.addCell(new jxl.write.Label(0, 0, message(code: 'name'), formatBold))
      sheet.addCell(new jxl.write.Label(1, 0, entity.profile, format))

      // description
      sheet.addCell(new jxl.write.Label(0, 1, message(code: 'description'), formatBold))
      sheet.addCell(new jxl.write.Label(1, 1, entity.profile.description, format))

      // creator
      sheet.addCell(new jxl.write.Label(0, 3, message(code: 'creator'), formatBold))
      sheet.addCell(new jxl.write.Label(1, 3, message(code: 'createdBy', args: [currentEntity.profile, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]), format))

      // column headers
      sheet.addCell(new jxl.write.Label(0, 5, message(code: 'lastName'), formatBold))
      sheet.addCell(new jxl.write.Label(1, 5, message(code: 'firstName'), formatBold))
      sheet.addCell(new jxl.write.Label(2, 5, message(code: 'birthDate'), formatBold))
      sheet.addCell(new jxl.write.Label(3, 5, message(code: 'gender'), formatBold))
      sheet.addCell(new jxl.write.Label(4, 5, message(code: 'client.profile.interests'), formatBold))
      sheet.addCell(new jxl.write.Label(5, 5, message(code: 'street'), formatBold))
      sheet.addCell(new jxl.write.Label(6, 5, message(code: 'zip'), formatBold))
      sheet.addCell(new jxl.write.Label(7, 5, message(code: 'groupColony'), formatBold))
      sheet.addCell(new jxl.write.Label(8, 5, message(code: 'country'), formatBold))
      sheet.addCell(new jxl.write.Label(9, 5, message(code: 'client.profile.origin') + " " + message(code: 'city'), formatBold))
      sheet.addCell(new jxl.write.Label(10, 5, message(code: 'client.profile.origin') + " " + message(code: 'zip'), formatBold))
      sheet.addCell(new jxl.write.Label(11, 5, message(code: 'client.profile.origin') + " " + message(code: 'country'), formatBold))
      sheet.addCell(new jxl.write.Label(12, 5, message(code: 'familyStatus'), formatBold))
      sheet.addCell(new jxl.write.Label(13, 5, message(code: 'languages'), formatBold))
      sheet.addCell(new jxl.write.Label(14, 5, message(code: 'client.profile.school'), formatBold))
      sheet.addCell(new jxl.write.Label(15, 5, message(code: 'client.profile.schoolLevel'), formatBold))
      sheet.addCell(new jxl.write.Label(16, 5, message(code: 'socialSecurityNumber'), formatBold))
      sheet.addCell(new jxl.write.Label(17, 5, message(code: 'client.profile.schoolPerformance'), formatBold))
      sheet.addCell(new jxl.write.Label(18, 5, message(code: 'client.profile.healthNotes'), formatBold))
      sheet.addCell(new jxl.write.Label(19, 5, message(code: 'client.profile.materials'), formatBold))
      sheet.addCell(new jxl.write.Label(19, 5, message(code: 'client.date.entry') + "/" + message(code: 'client.date.exit'), formatBold))
      sheet.addCell(new jxl.write.Label(20, 5, message(code: 'parents') + " & " + message(code: 'phone'), formatBold))

      def row = 6
      clients.each { Entity client ->
        sheet.addCell(new jxl.write.Label(0, row, client.profile.lastName, format))
        sheet.addCell(new jxl.write.Label(1, row, client.profile.firstName, format))
        sheet.addCell(new jxl.write.Label(2, row, formatDate(date: client.profile.birthDate, format: 'dd.MM.yyyy'), format))
        sheet.addCell(new jxl.write.Label(3, row, client.profile.gender == 1 ? message(code: 'male') : message(code: 'female'), format))
        sheet.addCell(new jxl.write.Label(4, row, client.profile.interests, format))
        sheet.addCell(new jxl.write.Label(5, row, client.profile.currentStreet, format))
        Entity colony = linkDataService.getColony(client)
        sheet.addCell(new jxl.write.Label(6, row, fieldValue(bean: colony, field: 'profile.zip').decodeHTML() ?: message(code:'noData'), format))
        sheet.addCell(new jxl.write.Label(7, row, fieldValue(bean: colony, field: 'profile').decodeHTML() ?: message(code:'noData'), format))
        sheet.addCell(new jxl.write.Label(8, row, fieldValue(bean: colony, field: 'profile.country').decodeHTML() ?: message(code:'noData'), format))

        sheet.addCell(new jxl.write.Label(9, row, fieldValue(bean: client, field: 'profile.originCity').decodeHTML() ?: message(code:'noData'), format))
        sheet.addCell(new jxl.write.Label(10, row, fieldValue(bean: client, field: 'profile.originZip').decodeHTML() ?: message(code:'noData'), format))
        sheet.addCell(new jxl.write.Label(11, row, fieldValue(bean: client, field: 'profile.originCountry').decodeHTML() ?: message(code:'noData'), format))
        sheet.addCell(new jxl.write.Label(12, row, client.profile.familyStatus, format))

        // languages
        String languages = ""
        client.profile.languages.each {
          languages = languages + it + ', '
        }
        sheet.addCell(new jxl.write.Label(13, row, languages, format))

        sheet.addCell(new jxl.write.Label(14, row, client.profile.school, format))
        sheet.addCell(new jxl.write.Label(15, row, client.profile.schoolLevel, format))
        sheet.addCell(new jxl.write.Label(16, row, client.profile.socialSecurityNumber, format))

        // performances
        String performances = ""
        client.profile.performances.each {
          performances = performances + formatDate(date: it.date, format: "dd. MM. yyyy") + " - " + it.text + ', '
        }
        sheet.addCell(new jxl.write.Label(17, row, performances, format))

        // healths
        String healths = ""
        client.profile.healths.each {
          healths = healths + formatDate(date: it.date, format: "dd. MM. yyyy") + " - " + it.text + ', '
        }
        sheet.addCell(new jxl.write.Label(18, row, healths, format))

        // materials
        String materials = ""
        client.profile.materials.each {
          materials = materials + formatDate(date: it.date, format: "dd. MM. yyyy") + " - " + it.text + ', '
        }
        sheet.addCell(new jxl.write.Label(19, row, materials, format))

        // dates
        String dates = ""
        client.profile.dates.each {
          dates = dates + formatDate(date: it.date, format: "dd. MM. yyyy") + " - " + message(code: "client.date." + it.type)
        }
        sheet.addCell(new jxl.write.Label(19, row, dates, format))


        // find family
        Entity family = linkDataService.getFamily(client)

        // if there is a family, find parents
        List parents = functionService.findAllByLink(null, family, metaDataService.ltGroupMemberParent)
        
        String par = ""
        parents.each {Entity parent ->
          par = par + parent.profile + ': ' + (parent?.profile?.phone ?: message(code: 'noData')) + ', '
        } 
        sheet.addCell(new jxl.write.Label(20, row++, par, format))
      }

    }
    // educator - personal time evaluation
    if (params.type == 'evaluation') {

      WritableSheet sheet = workbook.createSheet(entity.profile, 0)

      // auto-size cells
      for (int x = 0; x < 7; x++)
      {
        def cell = sheet.getColumnView(x)
        cell.setAutosize(true)
        sheet.setColumnView(x, cell)
      }

      Date date1 = params.date('date1','dd. MM. yy')
      Date date2 = params.date('date2','dd. MM. yy')

      List workdaycategories = WorkdayCategory.list()

      sheet.addCell(new jxl.write.Label(0, 0, 'Zeitauswertung von ' + entity.profile + ' für den Zeitraum von', format))
      sheet.addCell(new jxl.write.Label(0, 1, formatDate(date: date1, format: 'dd. MM. yyyy') + ' bis ' + formatDate(date: date2, format: 'dd. MM. yyyy'), formatBold))

      // column headers
      sheet.addCell(new jxl.write.Label(0, 3, message(code: 'date'), formatBold))
      int i = 1
      workdaycategories.each { wdc ->
        sheet.addCell(new jxl.write.Label(i++, 3, wdc.name + ' (h)', formatBold))
      }
      sheet.addCell(new jxl.write.Label(i, 3, message(code: 'total') + ' (h)', formatBold))

      Calendar calendarStart = new GregorianCalendar()
      calendarStart.setTime(date1)

      Calendar calendarEnd = new GregorianCalendar()
      calendarEnd.setTime(date2)

      SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy", new Locale("en"))

      List sums = []
      workdaycategories.each {
        sums.add(0)
      }

      int row = 4
      int column
      while (calendarStart <= calendarEnd) {
        column = 0
        BigDecimal total = 0
        Date currentDate = calendarStart.getTime()
        sheet.addCell(new jxl.write.Label(column, row, formatDate(date: currentDate, format: "dd.MM.yyyy"), format))
        workdaycategories.eachWithIndex { wdcat, ind ->
          BigDecimal hours = 0
          entity.profile.workdayunits.each { WorkdayUnit workdayUnit ->
            if (workdayUnit.category == wdcat.name) {
              // check if the date of the workdayunit is between date1 and date2
              if (df.format(workdayUnit.date1) == df.format(currentDate)) {
                hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60

              }
            }
          }
          if (wdcat?.count) {
            total += hours
            sums[ind] += hours
          }
          sheet.addCell(new jxl.write.Label(column + 1, row, hours.toString(), format))
          column++
        }
        sheet.addCell(new jxl.write.Label(column + 1, row, total.toString(), format))
        calendarStart.add(Calendar.DATE, 1)
        row++
      }
      column = 0
      sheet.addCell(new jxl.write.Label(column++, row, message(code: "total"), formatBold))
      sums.each {
        sheet.addCell(new jxl.write.Label(column++, row, it.toString(), formatBold))
      }
      sheet.addCell(new jxl.write.Label(column, row, sums.sum().toString(), formatBold))

    }
    // global time evaluation
    if (params.type == 'globalevaluation') {

      WritableSheet sheet = workbook.createSheet('Zeitaufzeichnung', 0)

      // auto-size cells
      for (int x = 0; x < 7; x++)
      {
        def cell = sheet.getColumnView(x)
        cell.setAutosize(true)
        sheet.setColumnView(x, cell)
      }

      Date date1 = params.date('date1', 'dd. MM. yy')
      Date date2 = params.date('date2', 'dd. MM. yy')

      List workdaycategories = WorkdayCategory.list()

      sheet.addCell(new jxl.write.Label(0, 0, message(code:'educator.timeschedule.export.period', args:'[date1, date2]'), format))
      sheet.addCell(new jxl.write.Label(0, 1, message(code:'educator.timeschedule.export.from', args:'[entity.profile]') + formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + message(code: 'atTime') + formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + message(code: 'clock'), format))

    /*<h2><g:message code="profile.overview"/></h2>
    <table class="default-table">
      <thead>
      <tr>
        <th><g:message code="name"/></th>
        <g:each in="${workdaycategories}" var="category">
          <th>${category.name} (h)</th>
      </g:each>
        <th><g:message code="credit.hours"/></th>
        <th><g:message code="debit.hours"/></th>
        <th><g:message code="approved"/></th>
        <th><g:message code="payout"/> (${grailsApplication.config.currency})</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${educators}" status="i" var="educator">
        <erp:showHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${fieldValue(bean: educator, field: 'profile').decodeHTML()}</td>
      <g:each in="${workdaycategories}" var="category">
      <td><erp:getHoursForCategory category="${category}" educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          </g:each>
      <td><erp:getTotalHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getExpectedHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getSalary educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getHoursConfirmed educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        </tr>
      </erp:showHours>
      </g:each>
      </tbody>
    </table>

      <g:each in="${educators}" status="i" var="educator">
      <h1 style="page-break-before: always"><g:message code="educator.timeschedule.export.period" args="[date1, date2]"/></h1>
      <h2><g:message code="detailed.info"/></h2>
      <h3>${educator.profile}</h3>
      <erp:getWorkdayUnits educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/>
      </g:each>*/
    }

    workbook.write()
    workbook.close()

    return file
  }
}
