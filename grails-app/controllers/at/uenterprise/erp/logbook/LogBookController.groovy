package at.uenterprise.erp.logbook

import at.openfactory.ep.Entity
import at.uenterprise.erp.MetaDataService
import at.uenterprise.erp.FunctionService
import at.openfactory.ep.EntityHelperService

class LogBookController {
  MetaDataService metaDataService
  FunctionService functionService
  EntityHelperService entityHelperService

  def entries = {
    Entity currentEntity = entityHelperService.loggedIn

    List facilities
    if (currentEntity.type.id == metaDataService.etEducator.id) {
      facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator)
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking))
    }
    else
      facilities = Entity.findAllByType(metaDataService.etFacility)

    return [facilities: facilities]
  }

  def showEntry = {
    Entity facility = Entity.get(params.facility)
    Date date = params.date('date', 'dd. MM. yy')

    List facilities = Entity.findAllByType(metaDataService.etFacility)

    LogEntry entry = LogEntry.findByDateAndFacility(date, facility)

    render createTimeLine(date, facility)

    if (!entry)
        render "${remoteLink(update: 'entry', class: 'buttonGreen', action: 'createEntry', params: [facility: params.facility, date: params.date]) {message(code: 'logBook.create')}}"
    else
        render template: "entry", model: [entry: entry, date: params.date, facility: params.facility, facilities: facilities]
  }

  def createEntry = {
    Entity facility = Entity.get(params.facility)
    Date date = params.date('date', 'dd. MM. yy')

    List facilities = Entity.findAllByType(metaDataService.etFacility)

    LogEntry entry = new LogEntry(date: date, facility: facility).save()

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

    render createTimeLine(date, facility)
    render template: "entry", model: [entry: entry, date: params.date, facility: params.facility, facilities: facilities]
  }

  def deleteEntry = {
    Entity facility = Entity.get(params.facility.toLong())
    Date date = params.date('date', 'dd. MM. yy')

    LogEntry.findByDateAndFacility(date, facility)?.delete(flush: true)

    render createTimeLine(date, facility)
    render "${remoteLink(update: 'entry', class: 'buttonGreen', action: 'createEntry', params: [facility: params.facility, date: params.date]) {message(code: 'logBook.create')}}"
  }

  def updateEntry = {
    LogEntry entry = LogEntry.get(params.id)

    List facilities = Entity.findAllByType(metaDataService.etFacility)

    //entry.isChecked != entry.isChecked
    if (entry.isChecked)
      entry.isChecked = false
    else
      entry.isChecked = true

    entry.save(flush: true)

    render createTimeLine(entry.date, entry.facility)
    render template: "entry", model: [entry: entry, facilities: facilities]
  }

  def updateEntryProcess = {
    LogEntry entry = LogEntry.get(params.entry)
    ProcessAttended process = ProcessAttended.get(params.id)

    List facilities = Entity.findAllByType(metaDataService.etFacility)

    if (process.hasParticipated)
      process.hasParticipated = false
    else
      process.hasParticipated = true

    process.save(flush: true)

    render createTimeLine(entry.date, entry.facility)
    render template: "entry", model: [entry: entry, facilities: facilities]
  }

  String createTimeLine(date, facility) {

    Calendar start = new GregorianCalendar()
    start.setTime(date)
    start.add(Calendar.DATE, -9)

    Calendar end = new GregorianCalendar()
    end.setTime(date)
    end.add(Calendar.DATE, 9)

    StringBuffer timeline = new StringBuffer()

    timeline.append('<p>' + message(code: 'entries') + ': <span class="gray">' + message(code: 'logBook.notCreated') + '</span> - <span class="green">' + message(code: 'logBook.confirmed') + '</span> - <span class="red">' + message(code: 'logBook.notConfirmed') + '</span></p>')

    while (start <= end) {
      Date currentDate = start.getTime()

      LogEntry someEntry = LogEntry.findByDateAndFacility(currentDate, facility)
      if (!someEntry)
        timeline.append('<span style="background: #ccc; float: left; padding: 3px; margin: 0 2px 2px 0; text-align: center; border:' + (currentDate == date ? '2px solid #000' : 'none') + '">' + remoteLink(update: "entry", action: "showEntry", params: [facility: facility.id, date: formatDate(date: currentDate, format: 'dd. MM. yyyy')]) {formatDate(date: currentDate, format: "EE") + '<br/>' + formatDate(date: currentDate, format: "dd.MM")} + '</span>')
      else {
        if (someEntry.isChecked)
          timeline.append('<span style="background: #cfc; float: left; padding: 3px; margin: 0 2px 2px 0; text-align: center; border:' + (currentDate == date ? '2px solid #000' : 'none') + '">' + remoteLink(update: "entry", action: "showEntry", params: [facility: facility.id, date: formatDate(date: currentDate, format: 'dd. MM. yyyy')]) {formatDate(date: currentDate, format: "EE") + '<br/>' + formatDate(date: currentDate, format: "dd.MM")} + '</span>')
        else
          timeline.append('<span style="background: #fcc; float: left; padding: 3px; margin: 0 2px 2px 0; text-align: center; border:' + (currentDate == date ? '2px solid #000' : 'none') + '">' + remoteLink(update: "entry", action: "showEntry", params: [facility: facility.id, date: formatDate(date: currentDate, format: 'dd. MM. yyyy')]) {formatDate(date: currentDate, format: "EE") + '<br/>' + formatDate(date: currentDate, format: "dd.MM")} + '</span>')
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
    LogEntry entry = LogEntry.get(params.id)
    entry.properties = params
    entry.save(flush: true)
    render template: "entryComment", model: [entry: entry]
  }

  def evaluation = {

    Entity currentEntity = entityHelperService.loggedIn

    List facilities
    if (currentEntity.type.id == metaDataService.etEducator.id) {
      facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator)
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking))
    }
    else
      facilities = Entity.findAllByType(metaDataService.etFacility)

    return [facilities: facilities]
  }

  def showEvaluation = {
    Entity facility = Entity.get(params.facility)
    Date date = params.date ?: params.date('date2', 'dd. MM. yy')

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
    else {
      List clients = functionService.findAllByLink(null, facility, metaDataService.ltGroupMemberClient)
      
      // delete all clients in logMonth object that are not linked to the facility anymore
      List toRemove = []
      logMonth.clients.each { LogClient logClient ->
        if (!clients.contains(logClient.client))
          toRemove.add(logClient)        
      }
      toRemove?.each { LogClient logClient ->
        logMonth.removeFromClients(logClient)
        logClient.delete()
      }
      
      // add all clients that are newly linked to the facility
      clients.each { Entity client ->
        if (!logMonth.clients.find {it.client == client}) {

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
      }
      logMonth.save(flush: true)
    }
    

    render template: "showEvaluation", model: [logMonth: logMonth, facility: facility, date: date]
  }

  def updatePaidProcess = {
    ProcessPaid process = ProcessPaid.get(params.id)

    if (process.isPaid)
      process.isPaid = false
    else
      process.isPaid = true

    process.save(flush: true)

    redirect action: "showEvaluation", params: [facility: params.facility, date2: params.date]
  }

  def createpdf = {
    Entity facility = Entity.get(params.facility.toInteger())
    Date date = params.date('date', 'dd. MM. yy')
    LogMonth logMonth = LogMonth.get(params.id)
    Entity currentEntity = entityHelperService.loggedIn
    renderPdf template: 'printEvaluation', model: [pageformat: params.pageformat, currentEntity: currentEntity, logMonth: logMonth, facility: facility, date: date], filename: "Logbuch" + '.pdf'
  }

  def processes = {
    params.offset = params.int('offset') ?: 0
    params.max = Math.min(params.int('max') ?: 15, 100)
    params.sort = params.sort ?: "name"
    params.order = params.order ?: "asc"

    List processes = Process.list(params)
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    return [processes: processes, facilities: facilities]
  }

  def createProcess = {
    Process process = new Process()
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    List entities = Entity.createCriteria().list {
      //or {
      //  eq("type", metaDataService.etUser)
      //  eq("type", metaDataService.etOperator)
        eq("type", metaDataService.etEducator)
      //}
    }
    return [process: process, facilities: facilities, entities: entities]
  }

  def saveProcess = {
    List entities = params.list('entities')
    List types = params.list('types')

    Process process = new Process(params)

    entities.each { String entity ->
      if (!process.entities.contains(entity))
        process.addToEntities(entity)
    }

    types.each { String type ->
      if (!process.types.contains(type))
        process.addToTypes(type)
    }

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
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    return [process: process, facilities: facilities]
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

    List entities = Entity.createCriteria().list {
      //or {
      //  eq("type", metaDataService.etUser)
      //  eq("type", metaDataService.etOperator)
        eq("type", metaDataService.etEducator)
      //}
    }

    List currentEntities = []
    process.entities.each {
      currentEntities.add(Entity.get(it as Integer))
    }
    return [process: process, facilities: facilities, entities: entities, currentEntities: currentEntities]
  }

  def updateProcess = {
    Process process = Process.get(params.id)
    process.properties = params

    List entities = params.list('entities')
    List types = params.list('types')

    process.entities.clear()
    process.types.clear()

    entities.each { String entity ->
      if (!process.entities.contains(entity))
        process.addToEntities(entity)
    }

    types.each { String type ->
      if (!process.types.contains(type))
        process.addToTypes(type)
    }

    process.save()
    flash.message = message(code: "object.updated", args: [message(code: "process"), process.name])
    redirect action: "showProcess", id: process.id
  }

  def settings = {
    Entity currentEntity = entityHelperService.loggedIn

    List facilities
    if (currentEntity.type.id == metaDataService.etEducator.id) {
      facilities = functionService.findAllByLink(currentEntity, null, metaDataService.ltLeadEducator)
      facilities.addAll(functionService.findAllByLink(currentEntity, null, metaDataService.ltWorking))
    }
    else
      facilities = Entity.findAllByType(metaDataService.etFacility)

    return [facilities: facilities]
  }

  def showAttendances = {
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    Entity facility = Entity.get(params.facility)

    // find all attendances of this facility
    List attendances = Attendance.findAllByFacility(facility)
    attendances = attendances.sort {it.client.profile.lastName}

    render template: 'attendances', model: [attendances: attendances, facilities: facilities]
  }

  def editAttendance = {
    Attendance attendance = Attendance.get(params.id)

    render template: 'editAttendance', model: [attendance: attendance, i: params.i]
  }

  def updateAttendance = {
    List facilities = Entity.findAllByType(metaDataService.etFacility)

    Attendance attendance = Attendance.get(params.id)

    //attendance.properties = params

    attendance.monday = params.monday ? true : false
    attendance.tuesday = params.tuesday ? true : false
    attendance.wednesday = params.wednesday ? true : false
    attendance.thursday = params.thursday ? true : false
    attendance.friday = params.friday ? true : false
    attendance.saturday = params.saturday ? true : false
    attendance.sunday = params.sunday ? true : false

    attendance.mondayFrom = params.date('mondayFrom', 'HH:mm')
    attendance.tuesdayFrom = params.date('tuesdayFrom', 'HH:mm')
    attendance.wednesdayFrom = params.date('wednesdayFrom', 'HH:mm')
    attendance.thursdayFrom = params.date('thursdayFrom', 'HH:mm')
    attendance.fridayFrom = params.date('fridayFrom', 'HH:mm')
    attendance.saturdayFrom = params.date('saturdayFrom', 'HH:mm')
    attendance.sundayFrom = params.date('sundayFrom', 'HH:mm')

    attendance.mondayTo = params.date('mondayTo', 'HH:mm')
    attendance.tuesdayTo = params.date('tuesdayTo', 'HH:mm')
    attendance.wednesdayTo = params.date('wednesdayTo', 'HH:mm')
    attendance.thursdayTo = params.date('thursdayTo', 'HH:mm')
    attendance.fridayTo = params.date('fridayTo', 'HH:mm')
    attendance.saturdayTo = params.date('saturdayTo', 'HH:mm')
    attendance.sundayTo = params.date('sundayTo', 'HH:mm')

    attendance.save()

    render template: 'showAttendance', model: [attendance: attendance, i: params.i, facilities: facilities]
  }
}
