package at.uenterprise.erp

import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import java.text.SimpleDateFormat
import org.springframework.web.servlet.support.RequestContextUtils
import at.openfactory.ep.EntityHelperService

import at.openfactory.ep.SecHelperService
import org.springframework.beans.SimpleTypeConverter
import org.springframework.context.MessageSourceResolvable
import org.codehaus.groovy.grails.web.util.StreamCharBuffer
import org.codehaus.groovy.grails.commons.DomainClassArtefactHandler
import java.text.DecimalFormat
import java.text.NumberFormat
import at.uenterprise.erp.logbook.Attendee
import at.uenterprise.erp.logbook.Attendance
import at.uenterprise.erp.logbook.LogMonth
import at.uenterprise.erp.logbook.LogEntry
import at.uenterprise.erp.logbook.LogClient
import at.uenterprise.erp.logbook.ProcessPaid
import at.uenterprise.erp.logbook.ProcessAttended

class HelperTagLib {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  SecHelperService secHelperService
  FunctionService functionService
  def securityManager
  static namespace = "erp"
  
  def getFavorite = {attrs ->
    if (entityHelperService.loggedIn.profile.favorites.contains(attrs.entity.id.toString()))
      out << remoteLink(class: 'buttonGreen', controller: 'profile', action: 'removeFavorite', id: attrs.entity.id.toString(), update: 'favorites') {'- ' + message(code: 'favorite')}
    else
      out << remoteLink(class: 'buttonGreen', controller: 'profile', action: 'addFavorite', id: attrs.entity.id.toString(), update: 'favorites') {'+ ' + message(code: 'favorite')}
  }

  def getEntity = {attrs, body ->
    Entity entity = Entity.get(attrs.entity)
    out << body(result: entity)
  }

  def createLinkFromEvaluation = {attrs, body ->
    Evaluation evaluation = attrs.evaluation

    if (evaluation.linkedTo.type == metaDataService.etGroupActivity)
      out << link(controller: evaluation.linkedTo.type.supertype.name + 'Profile', action: 'show', id: evaluation.linkedTo.id) {evaluation.linkedTo.profile.fullName}
    else {
      // find project day the project unit is linked to
      Entity projectDay = functionService.findByLink(evaluation.linkedTo, null, metaDataService.ltProjectDayUnit)

      // find project the project day is linked to
      if (projectDay) {
        Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
        out << link(controller: 'projectProfile', action: 'show', id: project.id) {evaluation.linkedTo.profile.fullName + ' (' + message(code: 'project') + ': ' + project.profile.fullName + ')'}
      }
    }
  }

  def renderLogMonthEntries = {attrs, body ->
    Entity facility = attrs.facility
    Date date = attrs.date

    List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}
    entries = entries.sort {it.date}

    entries.each { LogEntry entry ->

      out << '<p style="page-break-before: always">' + message(code: "date") + ": " + formatDate(date: entry.date, format: 'dd. MM. yyyy') + '</p>'
      out << '<table class="default-table">'
      out << '<tr>'
      out << '<th>' + message(code: 'name') + '</th>'
      entry?.attendees[0]?.processes?.each {
        out << '<th>' + it.process.name + '</th>'
      }
      out << '</tr>'
      entry?.attendees?.each { Attendee attendee ->
        out << '<tr>'
        out << '<td>' + attendee.client.profile.fullName.decodeHTML() + '</td>'
        attendee?.processes?.each { ProcessAttended process ->
          out << '<td>' + formatBoolean(boolean: process.hasParticipated, true: message(code: 'yes'), false: "<span class='red'>" + message(code: 'no') + "</span>") + '</td>'
        }
        out << '</tr>'
      }
      out << '</table>'

      out << '<p><span class="bold">' + message(code:"comment") + '</span>'
      out << '<div id="comment">'
      out << (entry.comment ?: '<span class="italic">' + message(code:"noData") + '</span>')
      out << '</div></p>'

      out << '<p><span class="bold">' + message(code:"confirmed") + '</span><br/>'
      out << formatBoolean(boolean: entry.isChecked, true: message(code: 'yes'), false: message(code: 'no'))
      out << '</p>'
    }
  }

  def renderLogMonthPrint = {attrs, body ->
    LogMonth logMonth = attrs.logMonth
    Entity facility = attrs.facility
    Date date = attrs.date

    def entriesConfirmed = 0
    List monthEntries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}
    monthEntries.each { e ->
      if (e.isChecked)
        entriesConfirmed++
    }
    if (entriesConfirmed == monthEntries.size()) {
      out << '<p class="green">' + message(code: 'logBook.allEntriesConfirmed') + '</p>'
    }
    else {
      out << '<p class="red">' + message(code: 'logBook.notAllEntriesConfirmed') + '</p>'
    }

    out << '<p class="gray">' + message(code: 'logBook.info') + '</p>'

    out << '<table class="default-table">'

    out << '<tr>'
    out << '<th>' + message(code: 'name') + '</th>'
    def processes = logMonth?.clients[0]?.processes
    processes = processes?.sort {it.process.name}
    processes?.each { ProcessPaid process ->
      out << '<th>' + process.process.name + '</th>'
    }
    out << '<th>' + message(code: 'activityInstance.profile.days') + '</th>'
    out << '<th>' + message(code: "total") + grailsApplication.config.currencySymbol + '</th>'
    out << '</tr>'

    logMonth?.clients?.each { LogClient client ->

      def processes2 = client.processes
      processes2 = processes2?.sort {it.process.name}

      def attendance = Attendance.findByClientAndFacility(client.client, facility)
      out << '<tr>'
      out << '<td>' + client.client.profile.fullName + '</td>'

      int totalCosts = 0

      SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

      // calculate the amount of participated and total processes
      processes2.eachWithIndex { ProcessPaid proc, i ->
        int total = 0
        int participated = 0

        List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}

        entries.each { LogEntry entry ->
          Attendee attendee = entry.attendees.find {it.client == client.client}
          attendee.processes.each { ProcessAttended aproc ->
            if (aproc.process.name == proc.process.name) {
              if ((attendance.monday && df.format(entry.date) == 'Monday') ||
                  (attendance.tuesday && df.format(entry.date) == 'Tuesday') ||
                  (attendance.wednesday && df.format(entry.date) == 'Wednesday') ||
                  (attendance.thursday && df.format(entry.date) == 'Thursday') ||
                  (attendance.friday && df.format(entry.date) == 'Friday') ||
                  (attendance.saturday && df.format(entry.date) == 'Saturday') ||
                  (attendance.sunday && df.format(entry.date) == 'Sunday')) {
                total++
              }
              if (aproc.hasParticipated) {
                participated++
              }
            }
          }
        }

        int costs
        if (proc.process.unit == "perDay")
          costs = proc.process.costs * participated
        else
          costs = proc.process.costs

        totalCosts += costs

        out << '<td>' + participated + '/' + total + ' - ' + costs + grailsApplication.config.currencySymbol

        if (proc.process.costs > 0) {

          out << ' ' + checkBox(name: 'checkbox', value: proc.isPaid, onclick: remoteFunction(update: "evaluation", action: "updatePaidProcess", id: proc.id, params: [facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]))

          /*out << '' + remoteLink(update: "evaluation", action: "updatePaidProcess", id: process.id, params: [facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]) {
          if (process.isPaid)
            ' <img src="' + resource(dir: 'images/icons', file: 'bullet_green.png') + '" alt="' + message(code: 'edit') + '" align="top"/>'
          else
            ' <img src="' + resource(dir: 'images/icons', file: 'bullet_red.png') + '" alt="' + message(code: 'edit') + '" align="top"/>'
          }*/

        }
        out << '</td>'
      }

      // calculate the days the client should have participated
      Calendar start = new GregorianCalendar()
      start.setTime(date)

      Calendar end = new GregorianCalendar()
      end.setTime(date)
      end.add(Calendar.MONTH, 1)

      int debitDays = 0
      while (start <= end) {
        Date currentDate = start.getTime()

        if ((attendance.monday && df.format(currentDate) == 'Monday') ||
            (attendance.tuesday && df.format(currentDate) == 'Tuesday') ||
            (attendance.wednesday && df.format(currentDate) == 'Wednesday') ||
            (attendance.thursday && df.format(currentDate) == 'Thursday') ||
            (attendance.friday && df.format(currentDate) == 'Friday') ||
            (attendance.saturday && df.format(currentDate) == 'Saturday') ||
            (attendance.sunday && df.format(currentDate) == 'Sunday')) {
          debitDays++
        }
        start.add(Calendar.DATE, 1)
      }

      // calculate days the client has participated
      int days = 0
      List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}
      entries.each { e ->
        e.attendees.each { a ->
          if (a.client == client.client) {
            def result = a.processes.find {it.hasParticipated}
            if (result)
              days++
          }
        }
      }
      out << '<td>' + days + '/' + debitDays + '</td>'
      out << '<td>' + totalCosts + grailsApplication.config.currencySymbol + '</td>'
      out << '</tr>'
    }
    out << '</table>'
  }

  def renderLogMonth = {attrs, body ->
    LogMonth logMonth = attrs.logMonth
    Entity facility = attrs.facility
    Date date = attrs.date

    Entity currentEntity = entityHelperService.loggedIn

    def entriesConfirmed = 0
    List monthEntries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}
    monthEntries.each { e ->
      if (e.isChecked)
        entriesConfirmed++
    }
    if (entriesConfirmed == monthEntries.size()) {
      out << '<p class="green">' + message(code: 'logBook.allEntriesConfirmed') + '</p>'
    }
    else {
      out << '<p class="red">' + message(code: 'logBook.notAllEntriesConfirmed') + '</p>'
    }

    out << '<p class="gray">' + message(code: 'logBook.info') + '</p>'
    
    out << '<table class="default-table">'

    out << '<tr>'
    out << '<th>' + message(code: 'name') + '</th>'
    def processes = logMonth?.clients[0]?.processes
    processes = processes?.sort {it.process.name}
    processes?.each { process ->
      out << '<th>' + process.process.name + '</th>'
    }
    out << '<th>Tage</th>'
    out << '<th>' + message(code: "total") + grailsApplication.config.currencySymbol + '</th>'
    out << '</tr>'

    logMonth?.clients?.each { LogClient client ->

      def processes2 = client.processes
      processes2 = processes2?.sort {it.process.name}

      def attendance = Attendance.findByClientAndFacility(client.client, facility)
      //if (!attendance)
      //  log.info "no attendance found for client: ${client.client.profile.fullName} and facility: ${facility.profile.fullName} - this should not be possible"
      out << '<tr>'
      out << '<td>' + client.client.profile.fullName + '</td>'

      int totalCosts = 0

      SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

      // calculate the amount of participated and total processes
      processes2?.eachWithIndex { proc, i ->
        int total = 0
        int participated = 0

        List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}

        entries.each { LogEntry entry ->
          Attendee attendee = entry.attendees.find {it.client == client.client}
          attendee?.processes?.each { aproc ->
            if (aproc.process.name == proc.process.name) {
              // calculate the total amount by checking if the attendee should be attending at this day
              if ((attendance?.monday && df.format(entry.date) == 'Monday') ||
                  (attendance?.tuesday && df.format(entry.date) == 'Tuesday') ||
                  (attendance?.wednesday && df.format(entry.date) == 'Wednesday') ||
                  (attendance?.thursday && df.format(entry.date) == 'Thursday') ||
                  (attendance?.friday && df.format(entry.date) == 'Friday') ||
                  (attendance?.saturday && df.format(entry.date) == 'Saturday') ||
                  (attendance?.sunday && df.format(entry.date) == 'Sunday')) {
                total++
              }
              if (aproc.hasParticipated) {
                participated++
              }
            }
          }
        }

        int costs
        if (proc.process.unit == "perDay")
          costs = proc.process.costs * participated
        else
          costs = proc.process.costs * (participated > 0 ? 1 : 0)

        totalCosts += costs

        out << '<td>' + participated + '/' + total + ' - ' + costs + grailsApplication.config.currencySymbol

        if (proc.process.costs > 0) {

          // check if the current entity may see the checkbox
          def typeOK = false
          if ((currentEntity.type == metaDataService.etEducator && proc.process.types.contains('educator')) ||
              (currentEntity.type == metaDataService.etOperator && proc.process.types.contains('operator')) ||
              (functionService.findByLink(currentEntity, null, metaDataService.ltLeadEducator) && proc.process.types.contains('leadEducator')))
            typeOK = false

          if (proc.process.entities.contains(currentEntity.id.toString()) || typeOK) {

            out << ' ' + checkBox(name: 'checkbox', value: proc.isPaid, onclick: remoteFunction(update: "evaluation", action: "updatePaidProcess", id: proc.id, params: [facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]))

          }
          /*out << '' + remoteLink(update: "evaluation", action: "updatePaidProcess", id: process.id, params: [facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]) {
          if (process.isPaid)
            ' <img src="' + resource(dir: 'images/icons', file: 'bullet_green.png') + '" alt="' + message(code: 'edit') + '" align="top"/>'
          else
            ' <img src="' + resource(dir: 'images/icons', file: 'bullet_red.png') + '" alt="' + message(code: 'edit') + '" align="top"/>'
          }*/

        }
        out << '</td>'
      }

      // calculate the days the client should have participated
      Calendar start = new GregorianCalendar()
      start.setTime(date)

      Calendar end = new GregorianCalendar()
      end.setTime(date)
      end.add(Calendar.MONTH, 1)

      int debitDays = 0
      while (start <= end) {
        Date currentDate = start.getTime()

        if ((attendance?.monday && df.format(currentDate) == 'Monday') ||
            (attendance?.tuesday && df.format(currentDate) == 'Tuesday') ||
            (attendance?.wednesday && df.format(currentDate) == 'Wednesday') ||
            (attendance?.thursday && df.format(currentDate) == 'Thursday') ||
            (attendance?.friday && df.format(currentDate) == 'Friday') ||
            (attendance?.saturday && df.format(currentDate) == 'Saturday') ||
            (attendance?.sunday && df.format(currentDate) == 'Sunday')) {
          debitDays++
        }
        start.add(Calendar.DATE, 1)
      }

      // calculate days the client has participated
      int days = 0
      List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}
      entries.each { e ->
        e.attendees.each { a ->
          if (a.client == client.client) {
            def result = a.processes.find {it.hasParticipated}
            if (result)
              days++
          }
        }
      }
      out << '<td>' + days + '/' + debitDays + '</td>'
      out << '<td>' + totalCosts + grailsApplication.config.currencySymbol + '</td>'
      out << '</tr>'
    }

    out << '</table>'

    //render (template: "buttons", model: [logMonth: logMonth])
  }
  /**
   * Returns the time evaluations for a given entity
   *
   * @author Alexander Zeillinger
   * @attr entity REQUIRED The group activity or project to check
   * @attr date1 REQUIRED The beginning of the date range
   * @attr date2 REQUIRED The end of the date range
   */
  def getEvaluation = {attrs, body ->
    Entity entity = attrs.entity

    Date date1 = attrs.date1
    Date date2 = attrs.date2

    Calendar calendarStart = new GregorianCalendar()
    calendarStart.setTime(date1)

    Calendar calendarEnd = new GregorianCalendar()
    calendarEnd.setTime(date2)

    SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy", new Locale("en"))

    List workdaycategories = WorkdayCategory.list()

    List sums = []
    workdaycategories.each {
      sums.add(0)
    }

    while (calendarStart <= calendarEnd) {
      BigDecimal total = 0
      Date currentDate = calendarStart.getTime()
      out << "<tr>"
      out << "<td>" + formatDate(date: currentDate, format: "dd.MM.yyyy") + "</td>"
      workdaycategories.eachWithIndex { wdcat, i ->
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
          sums[i] += hours
        }
        out << "<td>" + hours + "</td>"
      }
      out << "<td>" + total + "</td>"
      out << "</tr>"
      calendarStart.add(Calendar.DATE, 1)
    }
    out << "<tr style='background: #bdf;'>"
    out << "<td class='bold'>" + message(code: "total") + "</td>"
    sums.each {
      out << "<td class='bold'>" + it + "</td>"
    }
    out << "<td class='bold'>" + sums.sum() + "</td>"
    out << "</tr>"
  }

  /**
   * Checks if a resource is available for planning
   *
   * @author Alexander Zeillinger
   * @attr resource REQUIRED The resource to check
   * @attr entity REQUIRED The group activity or project to check
   */
  def getResourceFree = {attrs, body ->
    Calendar calendar = new GregorianCalendar()
    calendar.setTime(attrs.entity.profile.date)

    if (attrs.entity.type.id == metaDataService.etGroupActivity.id)
      calendar.add(Calendar.MINUTE, attrs.entity.profile.realDuration)
    else {
      // get all project units of a project day and calculate the sum of their durations
      List units = functionService.findAllByLink(null, attrs.entity, metaDataService.ltProjectDayUnit)
      int duration = units*.profile.duration.sum(0)
      calendar.add(Calendar.MINUTE, duration)
    }

    // get begin and end date of the group activity or project
    Date entityBegin = attrs.entity.profile.date
    Date entityEnd = calendar.getTime()

    // find all links the resource is already planned with
    List links = Link.findAllBySourceAndType(attrs.resource, metaDataService.ltResourcePlanned)

    // set the initial amount of how many units are available to the total amount of the resource
    int free = attrs.resource.profile.amount

    // now check for every link if it falls into the duration of the entity and if yes reduce the available amount
    links.each { Link link ->
      Date resourceBegin = new Date()
      resourceBegin.setTime(link.das.beginDate.toLong() * 1000)
      Date resourceEnd = new Date()
      resourceEnd.setTime(link.das.endDate.toLong() * 1000)

     if (!(resourceBegin >= entityEnd || resourceEnd <= entityBegin)) {
       free -= link.das.amount.toInteger()
     }
    }

    out << body(resourceFree: free)
  }

  /**
   * Return the amount of units a resource is planned with
   *
   * @author Alexander Zeillinger
   * @attr resource REQUIRED The resource to check
   * @attr entity REQUIRED The group activity or project to check
   */
  def getPlannedResourceAmount = {attrs ->
    def link = Link.createCriteria().get {
      eq('source', attrs.resource)
      eq('target', attrs.entity)
      eq('type', metaDataService.ltResourcePlanned)
    }
   out << link.das.amount
  }

  /**
   * Returns all entities who have birthday today
   *
   * @author Alexander Zeillinger
   */
  def getBirthdays = {attrs, body ->

    SimpleDateFormat sdf = new SimpleDateFormat("d M", new Locale("en"))
    Date date = new Date()

    List results = []

    List educators = Entity.findAllByType(metaDataService.etEducator)
    educators.each { Entity educator ->
      if (sdf.format(educator.profile.birthDate) == sdf.format(date))
        results.add(educator)
    }

    List clients = Entity.findAllByType(metaDataService.etClient)
    clients.each { Entity client ->
      if (sdf.format(client.profile.birthDate) == sdf.format(date))
        results.add(client)
    }

    results.each {out << body(entities: it)}
  }

  /**
   * Renders the text of an event
   *
   * @author Alexander Zeillinger
   * @attr event REQUIRED The event to render
   */
  def getEvent = {attrs ->
    Entity who = Entity.get(attrs.event.who)
    def what = Entity.get(attrs.event.what)
    if (!what) {
     what = Helper.get(attrs.event.what)
     if (who && what)
       out << message(code: attrs.event.type.toString(), args: ['<a href="' + createLink(controller: who.type.supertype.name +'Profile', action:'show', id: who.id, params:[entity: who.id]) + '"><span class="bold">' + who.profile.fullName + '</span></a>', '<a href="' + createLink(controller: 'helper', action: 'list') + '"><span class="bold">' + what.title + '</span></a>']).decodeHTML()
    }
    else
      if (who && what)
        out << message(code: attrs.event.type.toString(), args: ['<a href="' + createLink(controller: who.type.supertype.name +'Profile', action:'show', id: who.id, params:[entity: who.id]) + '"><span class="bold">' + who.profile.fullName + '</span></a>', '<a href="' + createLink(controller: what.type.supertype.name +'Profile', action: 'show', id: what.id, params:[entity: what.id]) + '"><span class="bold">' + what.profile.fullName + '</span></a>']).decodeHTML()
  }

  def profileImage = {attrs ->
    def imgattrs = [:]
    imgattrs['src'] = g.createLink (controller:'app', action:'get', params:[type:'profile', entity:attrs.entity.id])
    attrs.name = attrs.entity.name
    attrs.each {key, val ->
      imgattrs[key] = val
    }
    def mkp = new groovy.xml.MarkupBuilder(out)
    mkp { img (imgattrs) }
  }

  def truncate = {attrs ->
    out << (attrs.string.size() > 20 ? attrs.string.substring(0, 20) + "..." : attrs.string)
  }

  /**
   * Retrieves all online users who where active within the last 5 minutes
   *
   * @author Alexander Zeillinger
   */
  def getOnlineUsers = {attrs, body ->
    List users = Entity.list()

    List onlineUsers = []
    users.each { Entity entity ->
      if (entity?.user?.lastAction)
        if ((new Date().getTime() - entity.user.lastAction.getTime()) / 1000 / 60 <= 5)
          onlineUsers.add(entity)
    }

    onlineUsers.each {out << body(onlineUsers: it)}
  }

  /**
   * Get all workdayunits of an educator
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getWorkdayUnits = { attrs, body ->
    Date date1 = Date.parse("dd. MM. yy", attrs.date1)
    Date date2 = Date.parse("dd. MM. yy", attrs.date2) + 1

    Entity educator = attrs.educator

    List units = []
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the date of the workdayunit is between date1 and date2
      if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
        units.add(workdayUnit)
      }
    }

    // get all workdayunits for each day
    Calendar calendarStart = new GregorianCalendar()
    calendarStart.setTime(date1)

    Calendar calendarEnd = new GregorianCalendar()
    calendarEnd.setTime(date2)

    SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy", new Locale("en"))
    NumberFormat nf = new DecimalFormat("##0.00")
    SimpleDateFormat wdf = new SimpleDateFormat("EEEE", new Locale("en"))

    while (calendarStart <= calendarEnd) {

      List currentUnits = []
      units.each { unit ->
        if (df.format(unit.date1) == df.format(calendarStart.getTime()))
          currentUnits.add(unit)
      }

      if (currentUnits.size() > 0) {
        out << "<p>" + formatDate(date: currentUnits[0].date1, format: "EEEE, dd.MM.yyyy") + "</p>"
        out << "<table style='margin-bottom: 20px'>"
        out << "<tr>"
        out << "<th width='40px'>" + message(code: 'from.upper') + "</th>"
        out << "<th width='40px'>" + message(code: 'to.upper') + "</th>"
        out << "<th width='80px'>" + message(code: 'credit.hours') + "</th>"
        out << "<th width='100px'>" + message(code: 'category') + "</th>"
        out << "<th width='400px'>" + message(code: 'description') + "</th>"
        out << "</tr>"

        BigDecimal totalCreditHours = 0
        Date first = null
        Date last = null
        currentUnits.eachWithIndex { unit, index ->

          // calculate credit hours
          BigDecimal creditHours = (unit.date2.getTime() - unit.date1.getTime()) / 1000 / 60 / 60

          totalCreditHours += creditHours
          if (index == 0)
            first = unit.date1
          if (index == currentUnits.size() - 1)
            last = unit.date2
          out << "<tr>"
          out << "<td>" + formatDate(date: unit.date1, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + "</td>"
          out << "<td>" + formatDate(date: unit.date2, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + "</td>"
          out << "<td>" + nf.format(creditHours) + "</td>"
          out << "<td>" + unit.category + "</td>"
          out << "<td>" + unit.description.decodeHTML() + "</td>"
          out << "</tr>"
        }

        // calculate expected hours
        BigDecimal expectedHours = 0
        if (wdf.format(calendarStart.getTime()) == 'Monday')
          expectedHours += educator.profile.workHoursMonday
        else if (wdf.format(calendarStart.getTime()) == 'Tuesday')
          expectedHours += educator.profile.workHoursTuesday
        else if (wdf.format(calendarStart.getTime()) == 'Wednesday')
          expectedHours += educator.profile.workHoursWednesday
        else if (wdf.format(calendarStart.getTime()) == 'Thursday')
          expectedHours += educator.profile.workHoursThursday
        else if (wdf.format(calendarStart.getTime()) == 'Friday')
          expectedHours += educator.profile.workHoursFriday
        else if (wdf.format(calendarStart.getTime()) == 'Saturday')
          expectedHours += educator.profile.workHoursSaturday
        else if (wdf.format(calendarStart.getTime()) == 'Sunday')
          expectedHours += educator.profile.workHoursSunday

        out << "<tr style='background: #eee; font-weight: bold'>"
        out << "<td>" + formatDate(date: first, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + "</td>"
        out << "<td>" + formatDate(date: last, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + "</td>"
        out << "<td style='background-color: ${totalCreditHours < expectedHours ? '#f55' : '#5f5'}'>" + nf.format(totalCreditHours) + "</td>"
        out << "<td></td>"
        out << "<td>" + message(code: 'debit.hours') + ": " + nf.format(expectedHours) + "</td>"
        out << "</tr>"

        out << "</table>"
      }

      calendarStart.add(Calendar.DATE, 1)
    }

    BigDecimal th = calculateTotalHours(educator, date1, date2)
    BigDecimal eh = calculateExpectedHours(educator, date1, date2)
    out << "<table>"
    out << "<tr style='background: #eee; font-weight: bold'>"
    out << "<td colspan='2' style='border: 0; width: 85px'>" + message(code: 'total') + "</td>"
    out << "<td colspan='2' style='border: 0; width: 185px; background-color: ${th < eh ? '#f55' : '#5f5'}'>" + message(code: 'credit.hours') + ": " + nf.format(th) + "</td>"
    out << "<td width='400px' style='border: 0'>" + message(code: 'debit.hours') + ": " + nf.format(eh) + "</td>"
    out << "</tr>"
    out << "</table>"
  }

  /**
   * Check if all workdayunits of an educator are confirmed
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getHoursConfirmed = { attrs, body ->
    Date date1
    Date date2

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator

    def allConfirmed = true
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the date of the workdayunit is between date1 and date2
      if (attrs.date1 != null && attrs.date2 != null) {
        if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
          if (!workdayUnit.confirmed) {
            allConfirmed = false
          }
        }
      }
    }

    if (allConfirmed)
        out << "${message(code: 'yes')}"
    else
        out << "${message(code: 'no')}"
  }

  /**
   * Calculates the salary of an educator
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getSalary = { attrs, body ->
    Date date1 = null
    Date date2 = null

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator

    // calculate expected hours
    BigDecimal expectedHours = 0
    Calendar tcalendarStart = new GregorianCalendar();
    tcalendarStart.setTime(date1);

    Calendar tcalendarEnd = new GregorianCalendar();
    tcalendarEnd.setTime(date2);

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE", new Locale("en"))

    while (tcalendarStart <= tcalendarEnd) {
      Date currentDate = tcalendarStart.getTime();

      if (tdf.format(currentDate) == 'Monday')
        expectedHours += educator.profile.workHoursMonday
      else if (tdf.format(currentDate) == 'Tuesday')
        expectedHours += educator.profile.workHoursTuesday
      else if (tdf.format(currentDate) == 'Wednesday')
        expectedHours += educator.profile.workHoursWednesday
      else if (tdf.format(currentDate) == 'Thursday')
        expectedHours += educator.profile.workHoursThursday
      else if (tdf.format(currentDate) == 'Friday')
        expectedHours += educator.profile.workHoursFriday
      else if (tdf.format(currentDate) == 'Saturday')
        expectedHours += educator.profile.workHoursSaturday
      else if (tdf.format(currentDate) == 'Sunday')
        expectedHours += educator.profile.workHoursSunday

      tcalendarStart.add(Calendar.DATE, 1)
    }

    // calculate real hours
    int hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the workdayunit should be counted
      WorkdayCategory category = WorkdayCategory.findByName(workdayUnit.category)
      if (category?.count) {
        // check if the date of the workdayunit is between date1 and date2
        if (attrs.date1 != null && attrs.date2 != null) {
          if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
            hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
      }
    }

    // calculate salary
    def result = 0
    if (hours <= expectedHours)
        result += hours * (educator?.profile?.hourlyWage ?: 0)
    else
        result += expectedHours * (educator?.profile?.hourlyWage ?: 0) + ((hours - expectedHours) * (educator?.profile?.overtimePay ?: 0))

    out << result

  }

  /**
   * Calculates the number of hours an educator should have worked
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getExpectedHours = { attrs, body ->
    Date date1 = null
    Date date2 = null

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator

    BigDecimal hours = calculateExpectedHours(educator, date1, date2)
    NumberFormat df = new DecimalFormat("##0.00")
    out << df.format(hours)
  }

  def showHours = { attrs, body ->
    Date date1 = null
    Date date2 = null

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator

    if (calculateExpectedHours(educator, date1, date2) > 0)
      out << body()
  }

  BigDecimal calculateExpectedHours(educator, date1, date2) {
    BigDecimal expectedHours = 0
    Calendar tcalendarStart = new GregorianCalendar();
    tcalendarStart.setTime(date1);

    Calendar tcalendarEnd = new GregorianCalendar();
    tcalendarEnd.setTime(date2);

    SimpleDateFormat tdf = new SimpleDateFormat("EEEE", new Locale("en"))

    while (tcalendarStart <= tcalendarEnd) {
      Date currentDate = tcalendarStart.getTime();

      if (tdf.format(currentDate) == 'Monday')
        expectedHours += educator.profile.workHoursMonday
      else if (tdf.format(currentDate) == 'Tuesday')
        expectedHours += educator.profile.workHoursTuesday
      else if (tdf.format(currentDate) == 'Wednesday')
        expectedHours += educator.profile.workHoursWednesday
      else if (tdf.format(currentDate) == 'Thursday')
        expectedHours += educator.profile.workHoursThursday
      else if (tdf.format(currentDate) == 'Friday')
        expectedHours += educator.profile.workHoursFriday
      else if (tdf.format(currentDate) == 'Saturday')
        expectedHours += educator.profile.workHoursSaturday
      else if (tdf.format(currentDate) == 'Sunday')
        expectedHours += educator.profile.workHoursSunday

      tcalendarStart.add(Calendar.DATE, 1)
    }

    return expectedHours
  }

  /**
   * Calculates the number of total hours an educator has worked
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   */
  def getTotalHours = { attrs, body ->
    Date date1 = null
    Date date2 = null

    if (attrs.date1 != null && attrs.date2 != null) {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator

    BigDecimal hours = calculateTotalHours(educator, date1, date2)
    NumberFormat df = new DecimalFormat("##0.00")
    out << df.format(hours)
  }

  BigDecimal calculateTotalHours(educator, date1, date2) {
    BigDecimal hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      // check if the workdayunit should be counted
      WorkdayCategory category = WorkdayCategory.findByName(workdayUnit.category)
      if (category?.count) {
        // check if the date of the workdayunit the chosen date range
        if (date1 != null && date2 != null) {
          if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
            hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
      }
    }

    return hours
  }

  /**
   * Calculates the number of hours an educator has worked in a given category
   *
   * @author Alexander Zeillinger
   * @attr educator REQUIRED The educator to find the workdayunits of
   * @attr date1 REQUIRED The begin of the date range to check
   * @attr date2 REQUIRED The end of the date range to check
   * @attr category REQUIRED The category to check
   */
  def getHoursForCategory = { attrs, body ->
    Date date1
    Date date2
    if (attrs.date1 != "" && attrs.date2 != "") {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2) + 1
    }

    Entity educator = attrs.educator
    WorkdayCategory workdayCategory = attrs.category

    BigDecimal hours = 0
    educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
      if (workdayUnit.category == workdayCategory.name) {

        // check if the date of the workdayunit is between date1 and date2
        if (attrs.date1 != "" && attrs.date2 != "") {
          if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2) {
            hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (workdayUnit.date2.getTime() - workdayUnit.date1.getTime()) / 1000 / 60 / 60
      }
    }

    NumberFormat df = new DecimalFormat("##0.00")
    out << df.format(hours)
  }

  /**
   * custom tag for as long as the official implementation is broken with jQuery, see http://jira.codehaus.org/browse/GRAILS-2512--}%
   * checked on 01.09.2011, not resolved yet
   * TODO: check again in the future
   */
  def remoteField = { attrs, body ->
    def params = attrs['params']?:null
    if(params){
      String pString = "\'"
      params.each { key, value ->
        pString += "${key}=${value}&"
      }
      pString += "\'"
      attrs['params'] = pString;
    }
    out << g.remoteField(attrs, body)
  }

  /**
   * get the local tags of a given entity
   */
  def getLocalTags = {attrs, body ->
    Entity entity = attrs.entity
    Entity target = attrs.target

    List tags = []

    def a = Link.createCriteria()
    def resulta = a.get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltAbsent)
    }
    if (resulta)
      tags.add(true)
    else
      tags.add(false)

    def b = Link.createCriteria()
    def resultb = b.get {
      eq('source', entity)
      eq('target', target)
      eq('type', metaDataService.ltIll)
    }
    if (resultb)
      tags.add(true)
    else
      tags.add(false)

    out << body(tags: tags)
  }

  /**
   * get the tags of a given entity
   */
  def getTags = {attrs, body ->
    Entity entity = attrs.entity
    List tags = entity.tagslinks*.tag
    out << body(tags: tags)
  }

  /**
   * checks whether to render a tag button
   */
  def showTagButton = {attrs, body ->
    List tags = attrs.tags
    List tagnames = tags*.name
    if (!tagnames.contains(attrs.button))
      out << body()
  }

  /**
   * before deleting an entity this method finds any links to and from the entity and returns a confirmation message
   */
  def getLinks = {attrs ->
    Integer id = attrs.id
    Entity entity = Entity.get(id)

    def linksTarget = Link.findAllByTarget(entity)
    List sourceNames = linksTarget*.source.profile.fullName

    def linksSource = Link.findAllBySource(entity)
    List targetNames = linksSource*.target.profile.fullName

    if (sourceNames.size() == 0 && targetNames.size() == 0)
      out << "return confirm('${message(code: 'connectionsNone')}')"
    else if (sourceNames.size() > 0 && targetNames.size() == 0)
      out << "return confirm('${message(code: 'connectionsTo', args: [sourceNames])}')"
    else if (sourceNames.size() == 0 && targetNames.size() > 0)
      out << "return confirm('${message(code: 'connectionsFrom', args: [targetNames])}')"
    else
      out << "return confirm('${message(code: 'connectionsToAndFrom', args: [sourceNames, targetNames])}')"
  }

  /**
   * Modular access check
   *
   * @attr entity REQUIRED The entity which should be checked for access
   * @attr types The types to check against
   * @attr roles The roles to check against
   * @attr checkoperator Check if the entity is an operator
   * @attr creatorof Check if the entity is creator of this
   * @attr me Check if the entity is the currently logged in entity
   * @attr checkstatus Check if the entity is open for editing
   * @attr log Enables logging for current taglib call
   */
  def accessCheck = {attrs, body ->
    Entity entity = attrs.entity

    boolean isOpen = true
    if (attrs.checkstatus) {
      isOpen = accessIsOpen(attrs.checkstatus)
    }

    boolean isMe = false
    if (attrs.me) {
      isMe = accessIsMe(attrs.me)
      if (attrs.log)
        log.info "${attrs.me.profile} is ${entity.profile}: ${isMe}"
    }

    boolean isLeadEducator = false
    if (attrs.facilities)
      isLeadEducator = accessIsLeadEducator(entity, attrs.facilities)
    if (attrs.log)
      log.info "${entity.profile} is lead educator: ${isLeadEducator}"

    boolean isCreatorOf = false
    if (attrs.creatorof)
      isCreatorOf = accessIsCreatorOf(entity, attrs.creatorof)
    if (attrs.log)
      log.info "${entity.profile} is creator: " + isCreatorOf

    boolean isAdmin = entity?.user?.authorities?.find {it.authority == 'ROLE_ADMIN'} ? true : false

    boolean isOperator = false
    if (attrs.checkoperator) {
      isOperator = entity.type == metaDataService.etOperator
      if (attrs.log)
        log.info "${entity.profile} is operator: " + isOperator
    }

    if ((isAdmin || isCreatorOf || isMe || isOperator) ||
        ((accessHasTypes(entity, attrs.types) || accessHasRoles(entity, attrs.roles) || isLeadEducator) && isOpen))
      out << body()
  }

  // checks if a given entity has at least one of the given roles
  boolean accessHasRoles(Entity entity, List roles = []) {

    def result = false

    if (entity.user) {
      result = roles.findAll { entity.user?.authorities*.authority.contains(it) }
    }

    return result ? true : false
  }

  // checks if a given entity is of one of the given types
  boolean accessHasTypes(Entity entity, List types = []) {

    def result = types.findAll { entity.type?.name == it }

    return result ? true : false
  }

  // checks if a given entity is the currently logged in entity
  boolean accessIsMe(Entity entity) {
    return entity == entityHelperService.loggedIn
  }

  // checks if a given entity has an open status
  boolean accessIsOpen(def checkstatus) {

    def result = false
    if (checkstatus instanceof Entity) {
      if (checkstatus.profile.status && checkstatus.profile.status == 'notDoneOpen')
        result = true
    }

    return result
  }

  // checks if a given entity is creator of another given entity
  boolean accessIsCreatorOf(Entity entity, def creatorof) {

    def result = null
    if (creatorof instanceof Entity) {
      if (creatorof.type.id == metaDataService.etAppointment.id) {
        def c = Link.createCriteria()
        result = c.get {
          eq('source', creatorof)
          eq('target', entity)
          eq('type', metaDataService.ltAppointment)
        }
      }
      else {
        def c = Link.createCriteria()
        result = c.get {
          eq('source', entity)
          eq('target', creatorof)
          eq('type', metaDataService.ltCreator)
        }
      }
    }
    else if (creatorof instanceof Publication) {
      result = (creatorof.entity.id == entity.id)
    }

    if (result)
      return true
    else
      return false
  }

  // checks if a given entity is lead educator of a given facility
  boolean accessIsLeadEducator(Entity entity, List facilities) {

    List allFacilities = functionService.findAllByLink(entity, null, metaDataService.ltLeadEducator)

    def hits = false

    allFacilities.each {
      if (facilities.contains(it))
        hits = true
    }

    return hits
  }

  /**
   * outputs selectbox items for each language
   */
  def localeSelect = {attrs ->
    def locale = RequestContextUtils.getLocale(request)

    attrs['from'] = grailsApplication.config.locales
    attrs['value'] = (attrs['value'] ?: RequestContextUtils.getLocale(request))?.toString()
    // set the key as a closure that formats the locale
    attrs['optionKey'] = {"${it.language}_${it.country}"}
    // set the option value as a closure that formats the locale for display
    attrs['optionValue'] = {"${it.getDisplayLanguage(locale)}"}

    // use generic select
    out << eselect(attrs)
  }

  /**
   * returns the filetype of a publication
   * Reference: http://en.wikipedia.org/wiki/Internet_media_type
   */
  def getFileType = {attrs ->
    if (attrs.type == 'application/vnd.ms-excel' || attrs.type == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      out << "Excel"
    else if (attrs.type == 'image/jpeg' || attrs.type == 'image/png' || attrs.type == 'image/gif' || attrs.type == 'image/bmp')
      out << "Bild"
    else if (attrs.type == 'application/msword' || attrs.type == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
      out << "Word"
    else if (attrs.type == 'application/force-download' || attrs.type == 'application/pdf')
      out << "PDF"
    else if (attrs.type == 'text/plain')
      out << "Text"
    else if (attrs.type == 'application/vnd.ms-powerpoint' || attrs.type == 'application/mspowerpoint')
      out << "PowerPoint"
    else if (attrs.type == 'application/x-shockwave-flash')
      out << "Flash"
    else if (attrs.type == 'application/zip')
      out << "Archiv"
    else if (attrs.type == 'audio/mpeg3' || attrs.type == 'audio/x-mpeg3' || attrs.type == 'audio/mpeg')
      out << "MP3"
    else if (attrs.type == 'video/avi')
      out << "Video"
    else
      out << "Unbekannt"
  }

  /**
   * finds all parents of a given child
   */
  def getParentsOfClient = {attrs, body ->
    def client = attrs.client

    // find family
    Entity family = functionService.findByLink(client, null, metaDataService.ltGroupFamily)

    // if there is a family, find parents
    List parents = functionService.findAllByLink(null, family, metaDataService.ltGroupMemberParent)

    // output each parent
    parents.each { Entity parent ->
      out << parent.profile.fullName << ": " << parent.profile.phone << "<br/>"
    }
  }

  /**
   * finds the number of units linked to a project template
   */
  def getProjectTemplateUnitsCount = {attrs, body ->
    def units = Link.countByTargetAndType(attrs.template, metaDataService.ltProjectUnitTemplate)
    out << units
  }

  /**
   * finds the number of clients linked to a client group
   */
  def getGroupClientsCount = {attrs, body ->
    def clients = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberClient)
    out << clients
  }

  /**
   * finds the project a project unit belongs to
   */
  def getProjectOfUnit = {attrs ->
    // find project day the project unit is linked to
    Entity projectDay = functionService.findByLink(attrs.unit, null, metaDataService.ltProjectDayUnit)

    // find project the project day is linked to
    if (projectDay) {
      Entity project = functionService.findByLink(projectDay, null, metaDataService.ltProjectMember)
      out << message(code: 'project') + ": " + project?.profile?.fullName ?: 'not found'
    }
  }

  /**
   * finds all project units linked to a project day
   */
  def getProjectDayUnits = {attrs, body ->
    //List projectDayUnits = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayUnit)

    List projectDayUnits = []
    attrs.projectDay.profile.units.each {
      projectDayUnits.add(Entity.get(it))
    }

    if (projectDayUnits)
      projectDayUnits.each {out << body(units: it)}
    else
      out << body(units: null)
      //out << '<span class="italic red">' + message(code: 'projectUnits.choose') + '</span>'
  }

  /**
   * finds all educators linked to a project day
   */
  def getProjectDayEducators = {attrs, body ->
    List projectDayEducators = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayEducator)
    if (projectDayEducators)
      projectDayEducators.each {out << body(educators: it)}
    else
      out << '<span class="italic red">' + message(code: 'educators.choose') + '</span>'
  }

  /**
   * finds all supplemental educators linked to a project day
   */
  def getProjectDaySubstitutes = {attrs, body ->
    List projectDaySubstitutes = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDaySubstitute)
    if (projectDaySubstitutes)
      projectDaySubstitutes.each {out << body(educators: it)}
    else
      out << '<span class="italic red">' + message(code: 'substitutes.choose') + '</span>'
  }

  /**
   * finds all resources linked to a project day
   */
  def getProjectDayResources = {attrs, body ->
    List projectDayResources = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayResource)
    if (projectDayResources)
      projectDayResources.each {out << body(resources: it)}
    else
      out << '<span class="italic">' + message(code: 'resources.notAssigned') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /**
   * finds all activity groups linked to a project unit
   */
  def getProjectUnitActivityGroups = {attrs, body ->
    List projectUnitActivityGroups = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnit)
    if (projectUnitActivityGroups)
      projectUnitActivityGroups.each {out << body(activityGroups: it)}
    else
      out << '<span class="italic">Keine Aktivitätsblockvorlagen gefunden</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /**
   * finds all parents linked to a project unit
   */
  def getProjectUnitParents = {attrs, body ->
    List projectUnitParents = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitParent)
    if (projectUnitParents)
      projectUnitParents.each {out << body(parents: it)}
    else
      out << '<span class="italic red">' + message(code: 'parents.choose') + '</span>'
  }

  /**
   * finds the number of parents linked to a project unit
   */
  def getProjectUnitParentsCount = {attrs, body ->
    List projectUnitParents = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitParent)
    out << "(" + projectUnitParents.size() + ")"
  }

  /**
   * finds all partners linked to a project unit
   */
  def getProjectUnitPartners = {attrs, body ->
    List projectUnitPartners = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitPartner)
    if (projectUnitPartners)
      projectUnitPartners.each {out << body(partners: it)}
    else
      out << '<span class="italic red">' + message(code: 'partners.choose') + '</span>'
  }

  /**
   * finds all group activity templates linked to a project unit
   */
  def getGroupActivityTemplates = {attrs, body ->
    List groupActivityTemplates = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitMember)
    if (groupActivityTemplates)
      groupActivityTemplates.each {out << body(groupActivityTemplates: it)}
    else
      out << '<span class="italic red" style="margin-left: 15px">' + message(code: 'groupActivityTemplates.notAssigned') + '</span>'
  }

  /**
   * finds all resources linked to an entity
   */
  def getResources = {attrs, body ->
    List resources = functionService.findAllByLink(null, attrs.entity, metaDataService.ltResource)
    if (resources)
      resources.each {out << body(resources: it)}
    else
      out << '<span class="italic">' + message(code: 'resources.notAssigned') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /**
   * finds all group members of a given group
   */
  def getGroup = {attrs, body ->
    List groups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
    if (groups)
      groups.each {out << body(members: it)}
    else
      out << '<span class="italic">Diese Gruppe ist leer</span>'
  }

  /**
   * returns the size of a group
   */
  def getGroupSize = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /**
   * returns all facilities linked to a group
   */
  def getGroupFacilities = {attrs, body ->
    def result = Link.countBySourceAndType(attrs.entity, metaDataService.ltGroupMemberFacility)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /**
   * returns all resources linked to a group
   */
  def getGroupResources = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltResource)
    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /**
   * returns the total duration of the activities within a group
   */
  def getGroupDuration = {attrs, body ->
    List groups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
    def duration = 0
    if (groups)
      groups.each {duration += it.profile.duration}
    out << duration
  }

  /**
   * returns the entity a resource is linked to - which is either a facility or colony
   */
  def resourceCreatedIn = {attrs, body ->
    def result = functionService.findByLink(attrs.resource, null, metaDataService.ltResource)
    if (result)
      out << body(source: result)
  }

  /**
   * returns the template to a given activity
   */
  def getTemplate = {attrs, body ->
    Entity template = functionService.findByLink(null, attrs.entity, metaDataService.ltActTemplate)
    if (template)
      out << body(template: template)
    else
      out << '<span class="italic">keine Vorlage vorhanden</span>'
  }

  /**
   * returns all clients to a given activity
   */
  def getClients = {attrs, body ->
    List clients = functionService.findAllByLink(null, attrs.entity, metaDataService.ltActClient)
    if (clients)
      clients.each {out << body(clients: it)}
    else
      out << '<span class="italic">' + message(code: 'clients.empty') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
  }

  /**
   * returns all clients linked to a given pate
   */
  def getPateClients = {attrs, body ->
    List pateClients = functionService.findAllByLink(null, attrs.entity, metaDataService.ltPate)
    if (pateClients)
      pateClients.each {out << body(clients: it)}
    else
      out << '<span class="italic">' + message(code: 'clients.empty') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
  }

  /**
   * returns all educators linked to a given activity
   */
  def getEducators = {attrs, body ->
    List educators = functionService.findAllByLink(null, attrs.entity, metaDataService.ltActEducator)
    if (educators)
      educators.each {out << body(educators: it)}
    else
      out << '<span class="italic">' + message(code: 'educators.empty') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
  }

  /**
   * returns the facility linked to a given activity
   */
  def getFacility = {attrs, body ->
    Entity facility = functionService.findByLink(null, attrs.entity, metaDataService.ltActFacility)
    if (facility)
      out << body(facility: facility)
    else
      out << '<span class="italic">' + message(code:'notAssignedToFacility') + '</span>'
  }

  /**
   * returns the facility linked to a given activity
   */
  def getFacilityOfProject = {attrs, body ->
    Entity facilityOfProject = functionService.findByLink(null, attrs.entity, metaDataService.ltGroupMemberFacility)
    if (facilityOfProject)
      out << body(facility: facilityOfProject)
    else
      out << '<span class="italic">' + message(code:'notAssignedToFacility') + '</span>'
  }

  /**
   * returns all subthemes of a given activity
   */
  def getSubThemes = {attrs, body ->
    List subThemes = functionService.findAllByLink(null, attrs.theme, metaDataService.ltSubTheme)
    if (subThemes)
      subThemes.each {out << body(subthemes: it)}
  }

  /**
   * returns the creator of an entity
   */
  def createdBy = {attrs, body ->
    def result = functionService.findByLink(null, attrs.entity, metaDataService.ltCreator)
    if (result)
      out << body(creator: result)
  }

  /**
   * returns the creator (entity) to a given ID
   */
  def getCreator = {attrs, body ->
    out << body(creator: Entity.get(attrs.id))
  }

  /**
   * sets the active state of each letter of the glossary
   */
  def active = {attrs ->
    if (attrs.glossary == attrs.letter)
      out << '<span style="background: #050; padding: 1px 3px; color: #fff;">' << attrs.letter << '</span>'
    else
      out << attrs.letter
  }

  /**
   * finds the colony linked to a given entity
   */
  def getColony = {attrs, body ->
    out << body(colony: functionService.findByLink(null, attrs.entity, metaDataService.ltColonia))
  }

  /**
   * returns the gender
   */
  def showGender = {attrs ->
    if (attrs.gender == 1)
      out << message(code: 'male')
    else
      out << message(code: 'female')
  }

  /**
   * returns the number of new private messages through a service
   */
  def getNewInboxMessages = {attrs, body ->
    def c = Msg.createCriteria()
    def result = c.list {
      eq('entity', attrs.entity)
      ne('sender', attrs.entity)
      eq('read', false)
    }

    //if (results.size() > 0)
    //  out << "(" + results.size() + ")"
    out << body(result: result.size())
  }

  /**
   * returns the number of new news (last 7 days)
   */
  def getNewNews = {attrs, body ->

    Date lastWeek = new Date() - 7

    def c = News.createCriteria()
    def result = c.list {
      ge('dateCreated', lastWeek)
    }

    out << body(result: result.size())
  }

  /**
   * returns the number of current appointments
   */
  def getCurrentAppointments = {attrs, body ->

    List result = functionService.findAllByLink(null, attrs.entity, metaDataService.ltAppointment)
    result = result.findAll {it.profile.endDate > new Date()}

    out << body(result: result.size())
  }

  /**
   * returns the number of publications of an entity
   */
  def getPublicationCount = {attrs ->
    int m = Publication.countByEntity(attrs.entity)

    // group activity template
    if (attrs.entity.type.name == "Aktivitätsvorlagenblock") {
      List activitytemplates = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)

      activitytemplates.each { Entity at ->
        m += Publication.countByEntity(at)
      }
    }

    // group activity
    else if (attrs.entity.type.name == "Aktivitätsblock") {
      Entity groupactivitytemplate = functionService.findByLink(null, attrs.entity, metaDataService.ltTemplate)

      if (groupactivitytemplate) {
          m += Publication.countByEntity(groupactivitytemplate)

          List activitytemplates = functionService.findAllByLink(null, groupactivitytemplate, metaDataService.ltGroupMember)

          activitytemplates.each { Entity at ->
            m += Publication.countByEntity(at)
          }
      }
    }

    // project template
    else if (attrs.entity.type.name == "Projektvorlage") {
      List projectUnits = functionService.findAllByLink(null, attrs.entity, metaDataService.ltProjectUnit)

      List groupactivitytemplates = []
      projectUnits.each { Entity projectUnit ->
        def bla = functionService.findAllByLink(null, projectUnit, metaDataService.ltProjectUnitMember)
        bla.each {
          if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
            groupactivitytemplates << it
        }
      }

      groupactivitytemplates.each {
        m += Publication.countByEntity(it)
      }

      List activitytemplates = []
      groupactivitytemplates.each { Entity gat ->
        def bla = functionService.findAllByLink(null, gat, metaDataService.ltGroupMember)
        bla.each {
          if (!activitytemplates.contains(it)) // filter duplicate activity templates
            activitytemplates << it
        }
      }

      activitytemplates.each {
        m += Publication.countByEntity(it) 
      }
    }

    // project
    else if (attrs.entity.type.name == "Projekt") {
      Entity projectTemplate = functionService.findByLink(null, attrs.entity, metaDataService.ltProjectTemplate)

      if (projectTemplate) {
          m += Publication.countByEntity(projectTemplate)

          List projectUnits = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnit)

          List groupactivitytemplates = []
          projectUnits.each { Entity pu ->
            def bla = functionService.findAllByLink(null, pu, metaDataService.ltProjectUnitMember)
            bla.each {
              if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
                groupactivitytemplates << it
            }
          }

          groupactivitytemplates.each {
            m += Publication.countByEntity(it)
          }

          List activitytemplates = []
          groupactivitytemplates.each { Entity gat ->
            def bla = functionService.findAllByLink(null, gat, metaDataService.ltGroupMember)
            bla.each {
              if (!activitytemplates.contains(it)) // filter duplicate activity templates
                activitytemplates << it
            }
          }

          activitytemplates.each {
            m += Publication.countByEntity(it)
          }
      }
    }
    
    out << "(" + m + ")"
  }

  /**
   * returns the link (relationship) type between two given entities
   */
  def getRelationship = {attrs ->
    out << Link.findBySourceAndTarget(Entity.findByName(attrs.source), Entity.findByName(attrs.target)).type.name
  }

  /**
   * self explanatory methods below
   */

  def isLoggedIn = {attrs, body ->
    if (entityHelperService.loggedIn)
      out << body()
  }

  def isNotLoggedIn = {attrs, body ->
    if (!entityHelperService.loggedIn)
      out << body()
  }

  def isFriend = {attrs, body ->
    if (friend(attrs))
      out << body()
  }

  def notFriend = {attrs, body ->
    if (!friend(attrs))
      out << body()
  }

  def isBookmark = {attrs, body ->
    if (bookmark(attrs))
      out << body()
  }

  def notBookmark = {attrs, body ->
    if (!bookmark(attrs))
      out << body()
  }

  def isEnabled = {attrs, body ->
    if (attrs?.entity?.user?.enabled)
      out << body()
  }

  def notEnabled = {attrs, body ->
    if (!attrs?.entity?.user?.enabled)
      out << body()
  }

  def notAdmin = {attrs, body ->
    if (!attrs.entity.user.authorities.find {it.authority == 'ROLE_ADMIN'})
      out << body()
  }

  def isSystemAdmin = {attrs, body ->
    if (attrs.entity.user.authorities.find {it.authority == 'ROLE_SYSTEMADMIN'} )
      out << body()
  }

  def notMe = {attrs, body ->
    if (entityHelperService.loggedIn.id != attrs.entity.id)
      out << body()
  }

  def hasNotRoles = {attrs, body ->
    def entity = attrs.entity ?: entityHelperService.loggedIn

    def res = !attrs.roles.find { entity.user.authorities*.authority.contains(it) }
    if (res)
      out << body()
  }

  private boolean friend(attrs) {
    Entity currentEntity = entityHelperService.loggedIn
    if (!currentEntity)
      return false
    Entity e = attrs.entity ?: currentEntity
    if (!e)
      return false

    def c = Link.createCriteria
    def result = c.get {
      eq("source", currentEntity)
      eq("target", e)
      eq("type", metaDataService.ltFriendship)
    }
    return result ? true : false
  }

  private boolean bookmark(attrs) {
    Entity currentEntity = entityHelperService.loggedIn
    if (!currentEntity)
      return false
    Entity e = attrs.entity ?: currentEntity
    if (!e)
      return false

    def c = Link.createCriteria
    def result = c.get {
      eq("source", currentEntity)
      eq("target", e)
      eq("type", metaDataService.ltBookmark)
    }
    return result ? true : false
  }

  /**
   * starbox rating used for rating elements of methods
   */
  def starBox = {attrs ->

    Entity currentEntity = entityHelperService.loggedIn

    Element element = Element.get(attrs.element)

    def star = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star.png'/>"
    def star_empty = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star_empty.png'/>"

    def updateDiv = "starBox${element.id}"
    def vote = element.voting


    out << '<div>'
    // if the current entity is admin, operator or the creator display this
    if (currentEntity.user.authorities.find {it.authority == 'ROLE_ADMIN'} || currentEntity.type.id == metaDataService.etOperator.id || accessIsCreatorOf(currentEntity,attrs.template)) {
      out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 1]) { vote > 0 ? star : star_empty }
      out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 2]) { vote > 1 ? star : star_empty }
      //out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 3]) { vote > 2 ? star : star_empty }
      //out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 4]) { vote > 3 ? star : star_empty }
      //out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 5]) { vote > 4 ? star : star_empty }
    }
    // else just display the images
    else {
      out << (vote > 0 ? star : star_empty)
      out << (vote > 1 ? star : star_empty)
      //out << (vote > 2 ? star : star_empty)
      //out << (vote > 3 ? star : star_empty)
      //out << (vote > 4 ? star : star_empty)
    }
    out << '</div>'



  }

  /**
   * returns if a person is active in the calendareds list of an entity
   */
  def getActiveCalPerson = {attrs, body ->

    Entity currentEntity = entityHelperService.loggedIn

    def result = currentEntity.profile.calendar.calendareds.contains(attrs.id.toString())

    out << body(active: result)
  }

  /**
   * returns the currently logged in entity
   */
  def getCurrentEntity = {attrs, body ->
    out << body(currentEntity: entityHelperService.loggedIn)
  }

  /**
   * this is a modified version of the select tag that is used by the localeselect tag
   * used as a workaround because the 1.3.7 implementation is broken
   */
  def eselect = { attrs ->
        def messageSource = grailsAttributes.getApplicationContext().getBean("messageSource")
        def locale = RequestContextUtils.getLocale(request)
        def writer = out
        attrs.id = attrs.id ?: attrs.name
        def from = attrs.remove('from')
        def keys = attrs.remove('keys')
        def optionKey = attrs.remove('optionKey')
        def optionValue = attrs.remove('optionValue')
        def value = attrs.remove('value')
        if (value instanceof Collection && attrs.multiple == null) {
            attrs.multiple = 'multiple'
        }
        if (value instanceof StreamCharBuffer) {
            value = value.toString()
        }
        def valueMessagePrefix = attrs.remove('valueMessagePrefix')
        def noSelection = attrs.remove('noSelection')
        if (noSelection != null) {
            noSelection = noSelection.entrySet().iterator().next()
        }
        def disabled = attrs.remove('disabled')
        if (disabled && Boolean.valueOf(disabled)) {
            attrs.disabled = 'disabled'
        }

        writer << "<select name=\"${attrs.remove('name')?.encodeAsHTML()}\" "
        // process remaining attributes
        outputAttributes(attrs)

        writer << '>'
        writer.println()

        if (noSelection) {
            renderNoSelectionOptionImpl(writer, noSelection.key, noSelection.value, value)
            writer.println()
        }

        // create options from list
        if (from) {
            from.eachWithIndex {el, i ->
                def keyValue = null
                writer << '<option '
                if (keys) {
                    keyValue = keys[i]
                    ewriteValueAndCheckIfSelected(keyValue, value, writer)
                }
                else if (optionKey) {
                    def keyValueObject = null
                    if (optionKey instanceof Closure) {
                        keyValue = optionKey(el)
                        //log.info "optionKey: " + optionKey(el) + ", is locale? " + (optionKey(el) instanceof Locale)
                        //log.info "from element: " + el + ", is locale? " + (el instanceof Locale)
                    }
                    else if (el != null && optionKey == 'id' && grailsApplication.getArtefact(DomainClassArtefactHandler.TYPE, el.getClass().name)) {
                        keyValue = el.ident()
                        keyValueObject = el
                    }
                    else {
                        keyValue = el[optionKey]
                        keyValueObject = el
                    }
                    ewriteValueAndCheckIfSelected(keyValue, value, writer, keyValueObject)
                }
                else {
                    keyValue = el
                    ewriteValueAndCheckIfSelected(keyValue, value, writer)
                }
                writer << '>'
                if (optionValue) {
                    if (optionValue instanceof Closure) {
                        writer << optionValue(el).toString().encodeAsHTML()
                    }
                    else {
                        writer << el[optionValue].toString().encodeAsHTML()
                    }
                }
                else if (el instanceof MessageSourceResolvable) {
                    writer << messageSource.getMessage(el, locale)
                }
                else if (valueMessagePrefix) {
                    def message = messageSource.getMessage("${valueMessagePrefix}.${keyValue}", null, null, locale)
                    if (message != null) {
                        writer << message.encodeAsHTML()
                    }
                    else if (keyValue && keys) {
                        def s = el.toString()
                        if (s) writer << s.encodeAsHTML()
                    }
                    else if (keyValue) {
                        writer << keyValue.encodeAsHTML()
                    }
                    else {
                        def s = el.toString()
                        if (s) writer << s.encodeAsHTML()
                    }
                }
                else {
                    def s = el.toString()
                    if (s) writer << s.encodeAsHTML()
                }
                writer << '</option>'
                writer.println()
            }
        }
        // close tag
        writer << '</select>'
    }

    def typeConverter = new SimpleTypeConverter()
    private ewriteValueAndCheckIfSelected(keyValue, value, writer) {
        ewriteValueAndCheckIfSelected(keyValue, value, writer, null)
    }

    private ewriteValueAndCheckIfSelected(keyValue, value, writer, el) {

        boolean selected = false
        def keyClass = keyValue?.getClass()
        //log.info keyValue
        //log.info keyClass
        if (keyClass.isInstance(value)) {
            selected = (keyValue == value)
        }
        else if (value instanceof Collection) {
            // first try keyValue
            selected = value.contains(keyValue)
            if (! selected && el != null) {
                selected = value.contains(el)
            }
        }
        else if (keyClass && value) {
            try {
                //value = typeConverter.convertIfNecessary(value, keyClass)
                selected = (keyValue == value)
            }
            catch (e) {
                // ignore
            }
        }
        writer << "value=\"${keyValue}\" "
        if (selected) {
            writer << 'selected="selected" '
        }
    }

    void outputAttributes(attrs) {
        attrs.remove('tagName') // Just in case one is left
        def writer = getOut()
        attrs.each { k, v ->
            writer << "$k=\"${v.encodeAsHTML()}\" "
        }
    }

    def renderNoSelectionOptionImpl(out, noSelectionKey, noSelectionValue, value) {
        // If a label for the '--Please choose--' first item is supplied, write it out
        out << "<option value=\"${(noSelectionKey == null ? '' : noSelectionKey)}\"${noSelectionKey == value ? ' selected="selected"' : ''}>${noSelectionValue.encodeAsHTML()}</option>"
    }

}
