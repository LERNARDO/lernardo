package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import java.text.SimpleDateFormat

class LogBookController {
  MetaDataService metaDataService
  FunctionService functionService

  def entries = {
    List facilities = Entity.findAllByType(metaDataService.etFacility)
    return [facilities: facilities]
  }

  def showEntry = {
    Entity facility = Entity.get(params.facility)
    Date date = Date.parse("dd. MM. yy", params.date)

    LogEntry entry = LogEntry.findByDateAndFacility(date, facility)

    if(!entry) {
      entry = new LogEntry(date: date, facility: facility).save()

      // find all clients linked to the facility
      List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

      clients.each { Entity client ->
        Attendee attendee = new Attendee(client: client).save()

        List processes = Process.list()
        processes.each { Process process ->
          if (process.facilities.contains(facility) || process.facilities.size() == 0) {
            ProcessAttended processAttended = new ProcessAttended(process: process).save()
            attendee.addToProcesses(processAttended)
          }
        }

        entry.addToAttendees(attendee)
      }
      entry.save(flush: true)
    }

    render createTimeLine(date, facility)
    render template: "entry", model: [entry: entry]
  }

  def updateEntry = {
    LogEntry entry = LogEntry.get(params.id)

    //entry.isChecked != entry.isChecked
    if (entry.isChecked)
      entry.isChecked = false
    else
      entry.isChecked = true

    entry.save(flush: true)

    render createTimeLine(entry.date, entry.facility)
    render template: "entry", model: [entry: entry]
  }

  def updateEntryProcess = {
    LogEntry entry = LogEntry.get(params.entry)
    ProcessAttended process = ProcessAttended.get(params.id)

    if (process.hasParticipated)
      process.hasParticipated = false
    else
      process.hasParticipated = true

    process.save(flush: true)

    render createTimeLine(entry.date, entry.facility)
    render template: "entry", model: [entry: entry]
  }

  String createTimeLine(date, facility) {

    Calendar start = new GregorianCalendar()
    start.setTime(date)
    start.add(Calendar.DATE, -15)

    Calendar end = new GregorianCalendar()
    end.setTime(date)
    end.add(Calendar.DATE, 15)

    StringBuffer timeline = new StringBuffer()

    timeline.append('<p>Einträge: <span class="gray">Nicht angelegt</span> - <span class="green">Bestätigt</span> - <span class="red">Nicht bestätigt</span></p>')

    while (start <= end) {
      Date currentDate = start.getTime()

      LogEntry someEntry = LogEntry.findByDateAndFacility(currentDate, facility)
      if (!someEntry)
        timeline.append('<span style="background: #ccc; float: left; padding: 3px; margin: 0 2px 2px 0;">' + remoteLink(update: "entry", action: "showEntry", params: [facility: facility.id, date: formatDate(date: currentDate, format: 'dd. MM. yyyy')]) {formatDate(date: currentDate, format: "EE") + '<br/>' + formatDate(date: currentDate, format: "dd.MM")} + '</span>')
      else {
        if (someEntry.isChecked)
          timeline.append('<span style="background: #cfc; float: left; padding: 3px; margin: 0 2px 2px 0; border:' + (currentDate == date ? '2px solid #000' : 'none') + '">' + remoteLink(update: "entry", action: "showEntry", params: [facility: facility.id, date: formatDate(date: currentDate, format: 'dd. MM. yyyy')]) {formatDate(date: currentDate, format: "EE") + '<br/>' + formatDate(date: currentDate, format: "dd.MM")} + '</span>')
        else
          timeline.append('<span style="background: #fcc; float: left; padding: 3px; margin: 0 2px 2px 0; border:' + (currentDate == date ? '2px solid #000' : 'none') + '">' + remoteLink(update: "entry", action: "showEntry", params: [facility: facility.id, date: formatDate(date: currentDate, format: 'dd. MM. yyyy')]) {formatDate(date: currentDate, format: "EE") + '<br/>' + formatDate(date: currentDate, format: "dd.MM")} + '</span>')
      }

      start.add(Calendar.DATE, 1)
    }
    timeline.append('<div class="clear"></div><br/>')

    return timeline.toString()
  }

  def editEntryComment = {
    LogEntry entry = LogEntry.get(params.id)
    render template: "editEntryComment", model: [entry: entry]
  }

  def updateEntryComment = {
    println params
    LogEntry entry = LogEntry.get(params.id)
    entry.properties = params
    entry.save(flush: true)
    render template: "entryComment", model: [entry: entry]
  }

  def evaluation = {
    List facilities = Entity.findAllByType(metaDataService.etFacility)
    return [facilities: facilities]
  }

  def showEvaluation = {
    Entity facility = Entity.get(params.facility)
    Date date = params.date

    LogMonth logMonth = LogMonth.findByDate(date)

    if (!logMonth) {
      logMonth = new LogMonth(date: date).save()

      // find all clients linked to the facility
      List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)

      clients.each { Entity client ->
        LogClient logClient = new LogClient(client: client).save()

        List processes = Process.list()
        processes.each { Process process ->
          if (process.facilities.contains(facility) || process.facilities.size() == 0) {
            ProcessPaid processPaid = new ProcessPaid(process: process).save()
            logClient.addToProcesses(processPaid)
          }
        }

        logMonth.addToClients(logClient)
      }
      logMonth.save(flush: true)
    }

    render '<table class="default-table">'

    render '<tr>'
    render '<th>Name</th>'
    def processes = logMonth?.clients[0]?.processes
    processes = processes?.sort {it.process.name}
    processes?.each { process ->
      render '<th>' + process.process.name + '</th>'
    }
    render '<th>Tage</th>'
    processes?.each { process ->
      render '<th>' + process.process.name + ' € </th>'
    }
    render '<th>Monatsbeitrag €</th>'
    render '<th>Gesamt €</th>'
    render '</tr>'

    logMonth?.clients?.each { client ->

      List participatedTimes = []

      def attendance = Attendance.findByClient(client.client)
      render '<tr>'
      render '<td>' + client.client.profile.fullName + '</td>'

      // calculate the amount of participated and total processes
      client.processes.each { proc ->
        int total = 0
        int participated = 0

        List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}

        entries.each { entry ->
          Attendee attendee = entry.attendees.find {it.client == client.client}
          attendee.processes.each { aproc ->
            if (aproc.process.name == proc.process.name) {
              total++
              if (aproc.hasParticipated) {
                participated++
              }
            }
          }
        }
        participatedTimes.add(participated)

        render '<td>' + participated + '/' + total + '</td>'
      }

      // calculate the days the client should have participated
      Calendar start = new GregorianCalendar()
      start.setTime(date)

      Calendar end = new GregorianCalendar()
      end.setTime(date)
      end.add(Calendar.MONTH, 1)

      SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

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
      render '<td>' + days + '/' + debitDays + '</td>'

      int totalCosts = 0
      def cprocesses = client.processes
      cprocesses = cprocesses?.sort {it.process.name}
      cprocesses.eachWithIndex { process, i ->
        render '<td>' + (process.process.costs * participatedTimes[i]) + '</td>'
        totalCosts += (process.process.costs * participatedTimes[i])
      }
      int monthlyCosts = attendance.costs
      totalCosts += monthlyCosts
      render '<td>' + monthlyCosts + '</td>'
      render '<td>' + totalCosts + '</td>'
      render '</tr>'
    }

    render '</table>'

  }

  def processes = {
    List processes = Process.list(params)
    return [processes: processes]
  }

  def createProcess = {
    Process process = new Process()
    List facilities = Entity.findAllByType(metaDataService.etFacility)
    return [process: process, facilities: facilities]
  }

  def saveProcess = {
    Process process = new Process(params)

    if (process.save()) {
      flash.message = message(code: "object.created", args: [message(code: "process"), process.name])
      redirect action: "processes"
    }
    else {
      render view:"create", model:[process: process]
    }
  }

  def showProcess = {
    Process process = Process.get(params.id)
    return [process: process]
  }

  def deleteProcess = {
    Process process = Process.get(params.id)
    flash.message = message(code: "object.deleted", args: [message(code: "process"), process.name])
    process.delete()
    redirect action: "processes"
  }

  def editProcess = {
    Process process = Process.get(params.id)
    List facilities = Entity.findAllByType(metaDataService.etFacility)
    return [process: process, facilities: facilities]
  }

  def updateProcess = {
    Process process = Process.get(params.id)
    process.properties = params
    process.save()
    flash.message = message(code: "object.updated", args: [message(code: "process"), process.name])
    redirect action: "showProcess", id: process.id
  }

  def settings = {
    List facilities = Entity.findAllByType(metaDataService.etFacility)
    return [facilities: facilities]
  }

  def showAttendances = {
    Entity facility = Entity.get(params.facility)

    // find all attendances of this facility
    List attendances = Attendance.findAllByFacility(facility)

    render template: 'attendances', model: [attendances: attendances]
  }

  def editAttendance = {
    Attendance attendance = Attendance.get(params.id)

    render template: 'editAttendance', model: [attendance: attendance, i: params.i]
  }

  def updateAttendance = {
    Attendance attendance = Attendance.get(params.id)

    //attendance.properties = params

    attendance.costs = params.costs.toInteger()

    attendance.monday = params.monday ? true : false
    attendance.tuesday = params.tuesday ? true : false
    attendance.wednesday = params.wednesday ? true : false
    attendance.thursday = params.thursday ? true : false
    attendance.friday = params.friday ? true : false
    attendance.saturday = params.saturday ? true : false
    attendance.sunday = params.sunday ? true : false

    attendance.mondayFrom = params.mondayFrom ? Date.parse("HH:mm", params.mondayFrom) : null
    attendance.tuesdayFrom = params.tuesdayFrom ? Date.parse("HH:mm", params.tuesdayFrom) : null
    attendance.wednesdayFrom = params.wednesdayFrom ? Date.parse("HH:mm", params.wednesdayFrom) : null
    attendance.thursdayFrom = params.thursdayFrom ? Date.parse("HH:mm", params.thursdayFrom) : null
    attendance.fridayFrom = params.fridayFrom ? Date.parse("HH:mm", params.fridayFrom) : null
    attendance.saturdayFrom = params.saturdayFrom ? Date.parse("HH:mm", params.saturdayFrom) : null
    attendance.sundayFrom = params.sundayFrom ? Date.parse("HH:mm", params.sundayFrom) : null

    attendance.mondayTo = params.mondayTo ? Date.parse("HH:mm", params.mondayTo) : null
    attendance.tuesdayTo = params.tuesdayTo ? Date.parse("HH:mm", params.tuesdayTo) : null
    attendance.wednesdayTo = params.wednesdayTo ? Date.parse("HH:mm", params.wednesdayTo) : null
    attendance.thursdayTo = params.thursdayTo ? Date.parse("HH:mm", params.thursdayTo) : null
    attendance.fridayTo = params.fridayTo ? Date.parse("HH:mm", params.fridayTo) : null
    attendance.saturdayTo = params.saturdayTo ? Date.parse("HH:mm", params.saturdayTo) : null
    attendance.sundayTo = params.sundayTo ? Date.parse("HH:mm", params.sundayTo) : null

    attendance.save()

    render template: 'showAttendance', model: [attendance: attendance, i: params.i]
  }
}
