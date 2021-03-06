package at.uenterprise.erp

import at.uenterprise.erp.base.Entity
import at.uenterprise.erp.base.Link
import java.text.SimpleDateFormat
import at.uenterprise.erp.base.EntityHelperService
import java.text.DecimalFormat
import java.text.NumberFormat
import at.uenterprise.erp.logbook.Attendee
import at.uenterprise.erp.logbook.Attendance
import at.uenterprise.erp.logbook.LogMonth
import at.uenterprise.erp.logbook.LogEntry
import at.uenterprise.erp.logbook.LogClient
import at.uenterprise.erp.logbook.ProcessPaid
import at.uenterprise.erp.logbook.ProcessAttended
import at.uenterprise.erp.base.AssetStorage
import at.uenterprise.erp.base.AssetService

class HelperTagLib {
    EntityHelperService entityHelperService
    MetaDataService metaDataService
    FunctionService functionService
    AssetService assetService
    def securityManager
    LinkDataService linkDataService
    static namespace = "erp"

    /**
     * Returns all labels
     *
     * @author Alexander Zeillinger
     */
    def getAllLabels = {attrs, body ->
        List labels = functionService.getLabels()
        out << body(allLabels: labels)
    }

    def getFolders = {attrs, body ->
        Entity currentEntity = entityHelperService.loggedIn
        List folders = functionService.getFolders(currentEntity.profile.favoritesFolder)
        out << body(folders: folders)
    }

    def outputFolder(Folder f) {
        out << '<ul>'
        f.folders?.each { Folder folder ->
            out << '<li class="folder fader">' + folder.name + ' <span class="gray">' + folder.description + '</span> <span style="visibility: hidden">' +
                    remoteLink(action: "moveFolderUp", update: "favoriteslist", id: folder.id) {'<img src="' + resource(dir: 'images/icons', file: 'arrow_up.png') + '" align="top">'} + " " +
                    remoteLink(action: "moveFolderDown", update: "favoriteslist", id: folder.id) {'<img src="' + resource(dir: 'images/icons', file: 'arrow_down.png') + '" align="top">'} + " " +
                    remoteLink(action: "editFolder", update: "faveditbox", id: folder.id) {'<img src="' + resource(dir: 'images/icons', file: 'icon_edit.png') + '" align="top">'} + " " +
                    remoteLink(action: "removeFolder", update: "favoriteslist", id: folder.id) {'<img src="' + resource(dir: 'images/icons', file: 'icon_remove.png') + '" align="top">'} + '</span></li>'
            outputFolder(folder)
        }
        f.favorites?.each { Favorite favorite ->
            out << '<li class="item fader">' + link(controller: favorite.entity.type.supertype.name + "Profile", action: "show", id: favorite.entity.id) {favorite.entity.profile} + ' <span class="gray">' + '(' + message(code: "profiletype." + favorite.entity.type.supertype.name) + ') ' + favorite.description + '</span> <span style="visibility: hidden">' +
                    remoteLink(action: "moveFavoriteUp", update: "favoriteslist", id: favorite.id) {'<img src="' + resource(dir: 'images/icons', file: 'arrow_up.png') + '" align="top">'} + " " +
                    remoteLink(action: "moveFavoriteDown", update: "favoriteslist", id: favorite.id) {'<img src="' + resource(dir: 'images/icons', file: 'arrow_down.png') + '" align="top">'} + " " +
                    remoteLink(action: "editFavorite", update: "faveditbox", id: favorite.id) {'<img src="' + resource(dir: 'images/icons', file: 'icon_edit.png') + '" align="top">'} + " " +
                    remoteLink(action: "removeFavorite", update: "favoriteslist", id: favorite.id) {'<img src="' + resource(dir: 'images/icons', file: 'icon_remove.png') + '" align="top">'} + '</span></li>'
        }
        out << '</ul>'
    }

    def showFolders = {attrs, body ->
        Entity currentEntity = entityHelperService.loggedIn
        outputFolder(currentEntity.profile.favoritesFolder)
    }

    /**
     * Display the current Grails Environment
     *
     * @author Mike Kuhl
     * @attrs env
     */
    def ifGrailsEnv = {attrs, body ->
        def env = grails.util.GrailsUtil.environment

        if (attrs.env && attrs.env instanceof List && attrs.env.contains(env))
            out << body()
        else if (attrs.env == env)
            out << body()
    }

    /**
     * Set the page format for PDFs
     *
     * @author Alexander Zeillinger
     * @attrs pageformat REQUIRED the format code
     */
    def setPageFormat = {attrs ->
        if (attrs.pageformat == "1")
            out << "size: 210mm 297mm;"
        else if (attrs.pageformat == "2")
            out << "size: 297mm 210mm;"
        else if (attrs.pageformat == "3")
            out << "size: 216mm 279mm;"
        else if (attrs.pageformat == "4")
            out << "size: 279mm 216mm;"
    }

    /**
     * Get the range maximum of the size constraint of an attribute of a domain class
     *
     * @author Alexander Zeillinger
     * @author David Zeillinger
     * @attr domainClass REQUIRED The domain class
     * @attr constraint REQUIRED The constraint
     */
    def getConstraintSizeMax = {attrs, body ->
        String domainClass = "at.uenterprise.erp.profiles.${attrs.domainClass}"
        out << grailsApplication.getClassForName(domainClass).constraints[attrs.constraint].size.getToInt()
    }

    /**
     * Check if a resource can be accessed by an entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity to check
     */
    def checkResourceAccess = {attrs, body ->

        Entity currentEntity = entityHelperService.loggedIn

        def owner = Link.createCriteria().get {
            eq('source', currentEntity)
            eq('target', attrs.entity)
            eq('type', metaDataService.ltOwner)
        }

        def responsible = Link.createCriteria().get {
            eq('source', currentEntity)
            eq('target', attrs.entity)
            eq('type', metaDataService.ltResponsible)
        }

        def ok = false
        if ((currentEntity?.user?.authorities?.find {it.authority == 'ROLE_ADMIN'} ? true : false) ||
                (currentEntity.type.id == metaDataService.etOperator.id) ||
                (owner ? true : false) ||
                (responsible ? true : false))
            ok = true

        if (ok)
            out << body()
    }

    /**
     * Renders the + or - Favorite button
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity to check
     */
    def getFavorite = {attrs ->
        out << '<span id="favbutton">'
        if (findFavorite(attrs.entity))
            out << remoteLink(controller: 'profile', action: 'removeFavorite', id: attrs.entity.id.toString(), update: 'favbutton') {'<img class="tooltiphelp" data-tooltip="' + message(code: "favorite.remove") + '" src="' + g.resource(dir: 'images/icons', file: 'icon_star.png') + '" alt="toolTip" />'}
        else
            out << '''<a href="#" onclick="jQuery('#favmodal').modal(); return false">''' + '<img class="tooltiphelp" data-tooltip="' + message(code: "favorite.add") + '" src="' + g.resource(dir: 'images/icons', file: 'icon_star_empty.png') + '" alt="toolTip" />' + '''</a>'''
        out << '</span>'
    }

    def getSimpleFavorite = {attrs ->
        if (findFavorite(attrs.entity))
            out << '<img src="' + g.resource(dir: "images/icons", file: "icon_star.png") + '" alt="favorite" />'
        else
            out << '<img src="' + g.resource(dir: "images/icons", file: "transparent.png") + '" alt="favorite" />'
    }

    def findFavorite(Entity entity) {
        Entity currentEntity = entityHelperService.loggedIn
        return findNow(currentEntity.profile.favoritesFolder, entity)
    }

    Boolean findNow(Folder folder, Entity entity) {
        //println "---"
        //println "folder: " + folder.name
        //folder.favorites.each {println it.entity.profile}
        //println "entity: " + entity.profile
        def found = false
        if (folder.favorites.find {it.entity.id == entity.id}) {
            //println "found favorite in folder"
            return true
        }
        else {
            //println "didn't find favorite in folder, searching subfolders"
            folder.folders.each { Folder f ->
                if (findNow(f, entity)) {
                    //println "found favorite in subfolder"
                    found = true
                }
            }
        }
        return found
    }

    /**
     * Returns an entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED An entity id to get the entity from
     */
    def getEntity = {attrs, body ->
        Entity entity = Entity.get(attrs.entity)
        out << body(result: entity)
    }

    /**
     * Returns a link to the project an evaluation is linked to
     *
     * @author Alexander Zeillinger
     * @attr linked REQUIRED The linked entity
     */
    def createLinkFromEvaluation = {attrs, body ->
        Entity linked = attrs.linked

        Entity project = functionService.findByLink(attrs.linked, null, metaDataService.ltProjectMember)
        out << link(controller: 'projectProfile', action: 'show', id: project.id, params: [one: linked.id]) {linked.profile.fullName + ' (' + message(code: 'project') + ': ' + project.profile.fullName + ')'}
    }

    def renderLogMonthEntries = {attrs, body ->
        Entity facility = attrs.facility
        Date date = attrs.date

        List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}

        // only render details if there were any log entries this month
        if (entries) {
            entries = entries.sort {it.date}

            // new
            List processes = entries[0]?.attendees[0]?.processes
            List attendees = entries[0]?.attendees
            List colors = ['#e44', '#4e4', '#44e', '#e4e', '#4ee', '#ee4', '#eee', '#444']

            int pages = entries[0]?.attendees?.size() / 5

            for (int page = 0; page <= pages; page++) {

                out << '<div style="page-break-before: always"></div>'
                processes.eachWithIndex { p, i ->
                    out << '<div style="float: left; width: 50px; color: #fff; padding: 2px 4px; background: ' + colors[i] + '">' + p.process.name + '</div>'
                }
                out << '<div class="clear"></div>'

                Calendar start = new GregorianCalendar()
                start.setTime(date)

                out << '<table style="margin-top: 10px" class="default-table">'
                out << '<tr>'
                out << '<th style="width: 40px;">' + message(code: 'date') + '</th>'
                attendees.eachWithIndex { Attendee attendee, i ->
                    if (i >= page * 5 && i < page * 5 + 5)
                        out << '<th>' + attendee.client.profile.decodeHTML() + '</th>'
                }
                out << '</tr>'

                while (start.getTime().getMonth() == date.getMonth()) {
                    out << '<tr>'
                    out << '<td>' + formatDate(date: start.getTime(), format: 'dd.MM') + '</td>'
                    LogEntry logentry = LogEntry.findAllByFacility(facility).find {it.date.getMonth() == start.getTime().getMonth() && it.date.getDate() == start.getTime().getDate()}// && it.date.getYear() == start.getTime().getYear()}
                    if (logentry) {
                        logentry?.attendees?.eachWithIndex { Attendee attendee, ind ->
                            if (ind >= page * 5 && ind < page * 5 + 5) {
                                out << '<td>'
                                attendee?.processes?.eachWithIndex { ProcessAttended process, i ->
                                    if (process.hasParticipated)
                                        out << '<div style="float: left; width: 15px; height: 15px; background: ' + colors[i] + '"></div>'
                                    else
                                        out << '<div style="float: left; width: 15px; height: 15px; background: #fff;"></div>'
                                }
                                out << '</td>'
                            }
                        }
                    }
                    else {
                        int times = page == pages ? (entries[0]?.attendees?.size() % 5) : 5
                        for (int j = 0; j < times; j++) {
                            out << '<td></td>'
                        }
                    }
                    out << '</tr>'
                    start.add(Calendar.DATE, 1)
                }

                out << '</table>'
            }

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
        out << '<th>' + message(code: 'days') + '</th>'
        out << '<th>' + message(code: "total") + grailsApplication.config.currencySymbol + '</th>'
        out << '</tr>'

        List clients = logMonth?.clients
        clients.sort {it.client.profile.lastName}

        clients?.each { LogClient client ->

            def processes2 = client.processes
            processes2 = processes2?.sort {it.process.name}

            def attendance = Attendance.findByClientAndFacility(client.client, facility)
            out << '<tr>'
            out << '<td>' + client.client.profile + '</td>'

            int totalCosts = 0

            SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

            // calculate the amount of participated and total processes
            processes2.eachWithIndex { ProcessPaid proc, i ->
                int total = 0
                int participated = 0

                List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}

                entries.each { LogEntry entry ->
                    Attendee attendee = entry.attendees.find {it.client == client.client}
                    attendee?.processes?.each { ProcessAttended aproc ->
                        if (aproc.process.name == proc.process.name) {
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
                    out << ' ' + checkBox(name: 'checkbox', value: proc.isPaid, onclick: remoteFunction(update: "evaluation", action: "updatePaidProcess", id: proc.id, params: [facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]))
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
        out << '<th>' + message(code: "days") + '</th>'
        out << '<th>' + message(code: "total") + grailsApplication.config.currencySymbol + '</th>'
        out << '</tr>'

        List clients = logMonth?.clients
        clients.sort {it.client.profile.lastName}

        clients?.each { LogClient client ->

            def processes2 = client.processes
            processes2 = processes2?.sort {it.process.name}

            def attendance = Attendance.findByClientAndFacility(client.client, facility)
            //if (!attendance)
            //  log.info "no attendance found for client: ${client.client.profile} and facility: ${facility.profile} - this should not be possible"
            out << '<tr>'
            out << '<td>' + client.client.profile + '</td>'

            int totalCosts = 0

            SimpleDateFormat df = new SimpleDateFormat("EEEE", new Locale("en"))

            // calculate the amount of participated and total processes
            processes2?.eachWithIndex { proc, i ->
                int total = 0
                int participated = 0

                List entries = LogEntry.findAllByFacility(facility).findAll {it.date.getMonth() == date.getMonth()}

                int costs = 0

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
                                if (proc.process.unit == "perHour") {
                                    def duration = 0
                                    if (attendance?.monday)
                                        duration = (attendance?.mondayTo?.getTime() - attendance?.mondayFrom?.getTime()) / 1000 / 3600
                                    if (attendance?.tuesday)
                                        duration = (attendance?.tuesdayTo?.getTime() - attendance?.tuesdayFrom?.getTime()) / 1000 / 3600
                                    if (attendance?.wednesday)
                                        duration = (attendance?.wednesdayTo?.getTime() - attendance?.wednesdayFrom?.getTime()) / 1000 / 3600
                                    if (attendance?.thursday)
                                        duration = (attendance?.thursdayTo?.getTime() - attendance?.thursdayFrom?.getTime()) / 1000 / 3600
                                    if (attendance?.friday)
                                        duration = (attendance?.fridayTo?.getTime() - attendance?.fridayFrom?.getTime()) / 1000 / 3600
                                    if (attendance?.saturday)
                                        duration = (attendance?.saturdayTo?.getTime() - attendance?.saturdayFrom?.getTime()) / 1000 / 3600
                                    if (attendance?.sunday)
                                        duration = (attendance?.sundayTo?.getTime() - attendance?.sundayFrom?.getTime()) / 1000 / 3600
                                    costs += proc.process.costs * duration
                                }
                            }
                            if (aproc.hasParticipated) {
                                participated++
                            }
                        }
                    }
                }

                if (proc.process.unit == "perDay")
                    costs = proc.process.costs * participated
                else if (proc.process.unit == "perMonth")
                    costs = proc.process.costs * (participated > 0 ? 1 : 0)

                totalCosts += costs

                out << '<td>' + participated + '/' + total + ' - ' + costs + grailsApplication.config.currencySymbol

                if (proc.process.costs > 0) {

                    // check if the current entity may see the checkbox
                    def typeOK = false
                    if ((currentEntity?.user?.authorities?.find {it.authority == 'ROLE_ADMIN'} ? true : false) ||
                            (currentEntity.type == metaDataService.etEducator && proc.process.types.contains('educator')) ||
                            (currentEntity.type == metaDataService.etOperator && proc.process.types.contains('operator')) ||
                            (functionService.findByLink(currentEntity, null, metaDataService.ltLeadEducator) && proc.process.types.contains('leadEducator')))
                        typeOK = true

                    if (proc.process.entities.contains(currentEntity.id.toString()) || typeOK) {

                        out << ' ' + checkBox(name: 'checkbox', value: proc.isPaid, onclick: remoteFunction(update: "evaluation", action: "updatePaidProcess", id: proc.id, params: [facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]))

                    }

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
     * Creates the time recording report for a given entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED An educator or user
     * @attr date1 REQUIRED The beginning of the date range
     * @attr date2 REQUIRED The end of the date range
     */
    def timeRecordingReport = {attrs, body ->
        Entity entity = attrs.entity

        Date date1 = attrs.date1
        Date date2 = attrs.date2

        Calendar calendarStart = new GregorianCalendar()
        calendarStart.setTime(date1)

        Calendar calendarEnd = new GregorianCalendar()
        calendarEnd.setTime(date2)

        SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy", new Locale("en"))

        SimpleDateFormat weekday = new SimpleDateFormat("EEEE", new Locale("en"))

        List workdaycategories = WorkdayCategory.list()

        List sums = []
        workdaycategories.each {
            sums.add(0)
        }

        List unitsWithDescription = []

        out << '<table class="default-table" style="width: 100%;">'
        out << '<thead>'
        out << '<tr>'
        out << '<th>' + message(code: "date") + '</th>'
        workdaycategories?.each {
            out << '<th>' + it.name + ' (h)</th>'
        }
        out << '<th>' + message(code: "total") + '</th>'
        out << '</tr></thead><tbody>'

        while (calendarStart <= calendarEnd) {
            BigDecimal total = 0
            Date currentDate = calendarStart.getTime()

            if (weekday.format(currentDate) == 'Monday') {
                out << "<tr>"
                out << "<td style='border-top: 1px solid #000;' colspan='${workdaycategories.size() + 2}'>" + message(code: 'calendarWeek') + " " + calendarStart.get(Calendar.WEEK_OF_YEAR) + "</td>"
                out << "</tr>"
            }

            out << "<tr>"
            out << "<td>" + remoteLink(action: 'record', update: 'content', id: entity.id, params: [date: formatDate(date: currentDate, format: "dd. MM. yy")]) {formatDate(date: currentDate, format: "EE, dd.MM.yyyy")} + "</td>"

            workdaycategories.eachWithIndex { wdcat, i ->
                BigDecimal hours = 0
                entity.profile.workdayunits.each { WorkdayUnit workdayUnit ->
                    if (workdayUnit.category == wdcat.name) {
                        // check if the date of the workdayunit is between date1 and date2
                        if (df.format(functionService.convertFromUTC(workdayUnit.date1)) == df.format(currentDate)) {
                            hours += (functionService.convertFromUTC(workdayUnit.date2).getTime() - functionService.convertFromUTC(workdayUnit.date1).getTime()) / 1000 / 60 / 60
                            if (workdayUnit.description.size() > 0)
                                unitsWithDescription.add(workdayUnit)
                        }
                    }
                }
                if (wdcat?.counts) {
                    total += hours
                    sums[i] += hours
                }
                out << "<td>" + Math.round(hours * 2) / 2 + "</td>"
            }
            out << "<td>" + Math.round(total * 2) / 2 + "</td>"
            out << "</tr>"
            calendarStart.add(Calendar.DATE, 1)
        }
        out << "<tr style='background: #bdf;'>"
        out << "<td class='bold'>" + message(code: "total") + "</td>"
        sums.each {
            out << "<td class='bold'>" + Math.round(it * 2) / 2 + "</td>"
        }
        out << "<td class='bold'>" + Math.round(sums.sum() * 2) / 2 + "</td>"
        out << "</tr>"

        out << "</tbody>"
        out << "</table>"

        out << '<h4>' + message(code: "descriptions") + '</h4>'
        unitsWithDescription?.each { WorkdayUnit unit ->
            out << '<div style="margin: 5px 0;"><span class="gray">' + formatDate(date: unit.date1, format: "dd.MM.yy, HH:mm", timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + ' - ' + formatDate(date: unit.date2, format: "dd.MM.yy, HH:mm", timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + '</span> ' + unit.description + '</div>'
        }
    }

    /** WIP
     * Creates the time evaluation
     *
     * @author Alexander Zeillinger
     * @attr entities REQUIRED The entities
     */
    def timeEvaluation = {attrs, body ->
        Date date1 = null
        Date date2 = null

        if (attrs.date1 != null && attrs.date2 != null) {
            date1 = Date.parse("dd. MM. yy", attrs.date1)
            date2 = Date.parse("dd. MM. yy", attrs.date2)
        }

        BigDecimal total = 0

        Map totalSum = [:]
        attrs.workdaycategories.eachWithIndex { category, ind ->
            if (category.counts) {
                totalSum[ind] = 0
            }
        }

        NumberFormat df = new DecimalFormat("##0.00")

        attrs.entities.each { person ->
            if (calculateExpectedHours(person, date1, date2) > 0) {
                out << '<tr>'
                out << '<td>' + link(controller: person.type.supertype.name + "Profile", action: "show", id: person.id, params: [entity: person.id]) {fieldValue(bean: person, field: 'profile.firstName').decodeHTML() + " " + fieldValue(bean: person, field: 'profile.lastName').decodeHTML()} + "</td>"
                attrs.workdaycategories.eachWithIndex { category, ind ->
                    if (category.counts) {
                        out << '<td>' + df.format(functionService.getHoursForCategory(category, person, date1 ?: null, date2 ?: null)) + '</td>'
                        totalSum[ind] += functionService.getHoursForCategory(category, person, date1 ?: null, date2 ?: null)
                    }
                }

                // calculate total hours
                BigDecimal hours = calculateTotalHours(person, date1, date2 + 1)
                out << '<td>' + df.format(hours) + '</td>'

                // calculate expected hours
                hours = calculateExpectedHours(person, date1, date2)
                out << '<td>' + df.format(hours) + '</td>'

                // calculate confirmed hours
                def allConfirmed = true
                person.profile.workdayunits.each { WorkdayUnit workdayUnit ->
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
                    out << "<td>${message(code: 'yes')}</td>"
                else
                    out << "<td>${message(code: 'no')}" + link(controller: 'msg', action: 'create', id: person.id, params: [subject: 'Erinnerung Zeitaufzeichnung', content: attrs.date1 + ' - ' + attrs.date2]) {' (Erinnern)'} + "<td>"

                // calculate salary

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
                        expectedHours += person.profile.workHoursMonday
                    else if (tdf.format(currentDate) == 'Tuesday')
                        expectedHours += person.profile.workHoursTuesday
                    else if (tdf.format(currentDate) == 'Wednesday')
                        expectedHours += person.profile.workHoursWednesday
                    else if (tdf.format(currentDate) == 'Thursday')
                        expectedHours += person.profile.workHoursThursday
                    else if (tdf.format(currentDate) == 'Friday')
                        expectedHours += person.profile.workHoursFriday
                    else if (tdf.format(currentDate) == 'Saturday')
                        expectedHours += person.profile.workHoursSaturday
                    else if (tdf.format(currentDate) == 'Sunday')
                        expectedHours += person.profile.workHoursSunday

                    tcalendarStart.add(Calendar.DATE, 1)
                }

                // calculate real hours
                hours = 0
                person.profile.workdayunits.each { WorkdayUnit workdayUnit ->
                    // check if the workdayunit should be counted
                    WorkdayCategory category = WorkdayCategory.findByName(workdayUnit.category)
                    if (category?.counts) {
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
                    result += hours * (person?.profile?.hourlyWage ?: 0)
                else
                    result += expectedHours * (person?.profile?.hourlyWage ?: 0) + ((hours - expectedHours) * (person?.profile?.overtimePay ?: 0))

                out << '<td>' + result + '</td>'

                out << '</tr>'
            }
        }

        out << '<tr><td></td>'
        totalSum.each() {
            out << '<td></td>'
        }
        out << '<td></td></tr>'

        out << '<tr>'
        out << '<td>' + message(code: 'total') + '</td>'
        BigDecimal sumOfTotal = 0
        totalSum.each() { key, value ->
            out << '<td>' + df.format(value) + '</td>'
            sumOfTotal += value
        }
        out << '<td class="bold">' + df.format(sumOfTotal) + '</td>'
        out << '</tr>'
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

        // get all project units of a project day and calculate the sum of their durations
        List units = functionService.findAllByLink(null, attrs.entity, metaDataService.ltProjectDayUnit)
        int duration = units*.profile.duration.sum(0)
        calendar.add(Calendar.MINUTE, duration)

        // get begin and end date of the group activity or project
        Date entityBegin = attrs.entity.profile.date
        Date entityEnd = calendar.getTime()

        // find all links the resource is already planned with
        List links = Link.findAllBySourceAndType(attrs.resource, metaDataService.ltResourcePlanned)

        // set the initial amount of how many units are available to the total amount of the resource
        int free = attrs.resource.profile.amount
        List reservedIn = []

        // now check for every link if it falls into the duration of the entity and if yes reduce the available amount
        links?.each { Link link ->
            Date resourceBegin = new Date()
            resourceBegin.setTime(link.das.beginDate.toLong() * 1000)
            Date resourceEnd = new Date()
            resourceEnd.setTime(link.das.endDate.toLong() * 1000)

            if (!(resourceBegin >= entityEnd || resourceEnd <= entityBegin)) {
                free -= link.das.amount.toInteger()
                reservedIn.add(link.target)
            }
        }

        out << body(resourceFree: free, reservedIn: reservedIn)
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

        List educators = Entity.findAllByType(metaDataService.etEducator).findAll {it.user.enabled}
        educators.each { Entity educator ->
            if (sdf.format(educator.profile.birthDate) == sdf.format(date))
                results.add(educator)
        }

        List clients = Entity.findAllByType(metaDataService.etClient).findAll {it.user.enabled}
        clients.each { Entity client ->
            if (sdf.format(client.profile.birthDate) == sdf.format(date))
                results.add(client)
        }

        out << body(entities: results)
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
                out << message(code: attrs.event.type.toString(), args: ['<a class="largetooltip" data-idd="' + who.id + '" href="' + createLink(controller: who.type.supertype.name + 'Profile', action: 'show', id: who.id, params: [entity: who.id]) + '"><span class="bold">' + who.profile.fullName + '</span></a>', '<a class="largetooltip" data-idd="' + what.id + '" href="' + createLink(controller: 'helper', action: 'list') + '"><span class="bold">' + what.title + '</span></a>']).decodeHTML()
        }
        else
        if (who && what)
            out << message(code: attrs.event.type.toString(), args: ['<a class="largetooltip" data-idd="' + who.id + '" href="' + createLink(controller: who.type.supertype.name + 'Profile', action: 'show', id: who.id, params: [entity: who.id]) + '"><span class="bold">' + who.profile.fullName + '</span></a>', '<a class="largetooltip" data-idd="' + what.id + '" href="' + createLink(controller: what.type.supertype.name + 'Profile', action: 'show', id: what.id, params: [entity: what.id]) + '"><span class="bold">' + what.profile.fullName + '</span></a>']).decodeHTML()
    }

    /**
     * Renders the profile image
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity to render the profile image of
     */
    def profileImage = {attrs ->
        def imgattrs = [:]
        AssetStorage store = assetService.findStorage(attrs.entity, 'profile', 'latest')
        if (store) {
            imgattrs['src'] = g.createLink(controller: 'app', action: 'getImage', params: [type: 'profile', entity: attrs.entity.id, store: store.id])
        }
        else {
            imgattrs['src'] = g.resource(dir: 'images/default', file: attrs.entity.type.supertype.name + '.jpg')
        }
        attrs.name = attrs.entity.name
        attrs.each {key, val ->
            imgattrs[key] = val
        }
        //def mkp = new groovy.xml.MarkupBuilder(out)
        //log.info mkp { img (imgattrs) }
        //mkp { img (imgattrs) }
        out << '<img src="' + imgattrs['src'] + '" width="' + imgattrs['width'] + '" height="' + imgattrs['height'] + '" style="' + imgattrs['style'] + '" />'
    }

    /**
     * Truncates a string
     *
     * @author Alexander Zeillinger
     * @attr string REQUIRED The string to truncate
     * @attr length REQUIRED The length to truncate the string to
     */
    def truncate = {attrs ->
        out << (attrs.string.size() > attrs.int('length') ? attrs.string.substring(0, attrs.int('length')) + "..." : attrs.string)
    }

    /**
     * Retrieves all online users who were active within the last 5 minutes
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

        out << body(onlineUsers: onlineUsers)
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
        Date date2 = Date.parse("dd. MM. yy", attrs.date2)

        Entity educator = attrs.educator

        List units = []
        educator.profile.workdayunits.each { WorkdayUnit workdayUnit ->
            // check if the date of the workdayunit is between date1 and date2
            if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2 + 1) {
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
                //out << "<p>" + formatDate(date: currentUnits[0].date1, format: "EEEE, dd.MM.yyyy") + "</p>"
                out << "<table>"
                out << "<tr>"
                out << "<th width='40px'>" + message(code: 'date') + "</th>"
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
                    if (index == 0)
                        out << "<td>" + formatDate(date: unit.date1, format: 'dd.MMM', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + "</td>"
                    else
                        out << "<td></td>"
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

                out << "<tr style='background: #eee; font-weight: bold;'>"
                out << "<td style='background: #ccc;'>" + message(code: 'total') + "</td>"
                out << "<td style='background: #ccc;'>" + formatDate(date: first, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + "</td>"
                out << "<td style='background: #ccc;'>" + formatDate(date: last, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())) + "</td>"
                out << "<td style='background-color: ${totalCreditHours < expectedHours ? '#f55' : '#5f5'}'>" + nf.format(totalCreditHours) + "</td>"
                out << "<td style='background: #ccc;'></td>"
                out << "<td style='background: #ccc;'>" + message(code: 'debit.hours') + ": " + nf.format(expectedHours) + "</td>"
                out << "</tr>"

                out << "</table>"
            }

            calendarStart.add(Calendar.DATE, 1)
        }

        BigDecimal th = calculateTotalHours(educator, date1, date2)
        BigDecimal eh = calculateExpectedHours(educator, date1, date2)
        out << "<table style='margin-top: 20px;'>"
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
            out << "${message(code: 'no')}" + link(controller: 'msg', action: 'create', id: educator.id, params: [subject: 'Erinnerung Zeitaufzeichnung', content: attrs.date1 + ' - ' + attrs.date2]) {' (Erinnern)'}
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
            if (category?.counts) {
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
            if (category?.counts) {
                // check if the date of the workdayunit the chosen date range
                if (date1 != null && date2 != null) {
                    if (workdayUnit.date1 >= date1 && workdayUnit.date2 <= date2 + 1) {
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
     * Custom remoteField tag for as long as the official implementation is broken with jQuery, see http://jira.codehaus.org/browse/GRAILS-2512
     * checked on 24.04.2012, not resolved yet
     *
     * @author Alexander Zeillinger
     */
    def remoteField = { attrs, body ->
        def params = attrs['params'] ?: null
        if (params) {
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
     * Returns the local tags of a given entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity to find the tags of
     * @attr target REQUIRED The target the entity is linked to
     */
    def getLocalTags = {attrs, body ->
        Entity entity = attrs.entity
        Entity target = attrs.target

        List tags = []

        def resulta = Link.createCriteria().get {
            eq('source', entity)
            eq('target', target)
            eq('type', metaDataService.ltAbsent)
        }
        if (resulta)
            tags.add(true)
        else
            tags.add(false)

        def resultb = Link.createCriteria().get {
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
     * Returns the global tags of a given entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity to find the tags of
     */
    def getTags = {attrs, body ->
        Entity entity = attrs.entity
        List tags = entity.tagslinks*.tag
        out << body(tags: tags)
    }

    /**
     * Checks whether to render a tag button
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity to check
     */
    def showTagButton = {attrs, body ->
        List tags = attrs.tags
        List tagnames = tags*.name
        if (!tagnames.contains(attrs.button))
            out << body()
    }

    /**
     * Finds all links to and from an entity and returns a confirmation message
     *
     * @author Alexander Zeillinger
     * @attr id REQUIRED An entity id
     */
    def getLinks = {attrs ->
        Integer id = attrs.id
        Entity entity = Entity.get(id)

        def linksTarget = Link.findAllByTarget(entity)
        List sourceNames = linksTarget*.source.profile

        def linksSource = Link.findAllBySource(entity)
        List targetNames = linksSource*.target.profile

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
     * @author Alexander Zeillinger
     * @attr entity The entity which should be checked for access, defaults to current entity
     * @attr types The types to check against
     * @attr roles The roles to check against
     * @attr checkoperator Check if the entity is an operator
     * @attr creatorof Check if the entity is creator of this
     * @attr me Check if the entity is the currently logged in entity
     * @attr checkstatus Check if the entity is open for editing
     * @attr log Enables logging for current taglib call
     */
    def accessCheck = {attrs, body ->
        Entity entity = attrs.entity ?: entityHelperService.loggedIn

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
            if (checkstatus?.profile?.status && checkstatus?.profile?.status == 'notDoneOpen')
                result = true
        }

        return result
    }

    // checks if a given entity is creator of another given entity
    boolean accessIsCreatorOf(Entity entity, def creatorof) {

        def result = null
        if (creatorof instanceof Entity) {
            if (creatorof.type.id == metaDataService.etAppointment.id) {
                result = Link.createCriteria().get {
                    eq('source', creatorof)
                    eq('target', entity)
                    eq('type', metaDataService.ltAppointment)
                }
            }
            else {
                result = Link.createCriteria().get {
                    eq('source', entity)
                    eq('target', creatorof)
                    eq('type', metaDataService.ltCreator)
                }
            }
        }
        else if (creatorof instanceof Publication) {
            if (creatorof.creator)
                result = (creatorof?.creator?.id == entity.id)
            else
                result = false
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
     * Returns the filetype of a publication
     * Reference: http://en.wikipedia.org/wiki/Internet_media_type
     *
     * @author Alexander Zeillinger
     * @attr type REQUIRED The file media type
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
     * Finds all parents of a given client
     *
     * @author Alexander Zeillinger
     * @attr client REQUIRED The client to find the parents of
     */
    def getParentsOfClient = {attrs, body ->
        Entity family = linkDataService.getFamily(attrs.client)

        // if there is a family, find parents
        List parents = functionService.findAllByLink(null, family, metaDataService.ltGroupMemberParent)

        out << body(parents: parents)
    }

    /**
     * Finds the amount of units linked to a project template
     *
     * @author Alexander Zeillinger
     * @attr template REQUIRED The project template
     */
    def getProjectTemplateUnitsCount = {attrs, body ->
        def units = Link.countByTargetAndType(attrs.template, metaDataService.ltProjectUnitTemplate)
        out << units
    }

    /**
     * Finds the amount of clients linked to a client group
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The client group
     */
    def getGroupClientsCount = {attrs, body ->
        def clients = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberClient)
        out << clients
    }

    /**
     * Finds the project a project day belongs to
     *
     * @author Alexander Zeillinger
     * @attr day REQUIRED The project day
     */
    def getProjectOfDay= {attrs ->

        Entity project = functionService.findByLink(attrs.day, null, metaDataService.ltProjectMember)
        out << message(code: 'project') + ": " + project?.profile?.fullName ?: 'not found'

    }

    /**
     * Finds all templates linked to a group activity template
     *
     * @author Alexander Zeillinger
     * @attr groupActivityTemplate REQUIRED The group activity template
     */
    def getTemplatesOfGroupActivityTemplate = {attrs, body ->
        List templates = functionService.findAllByLink(null, attrs.groupActivityTemplate, metaDataService.ltGroupMember)

        if (templates)
            out << body(templates: templates)
        else
            out << body(templates: null)
    }

    /**
     * Finds all project units linked to a project day
     *
     * @author Alexander Zeillinger
     * @attr projectDay REQUIRED The project day
     */
    def getProjectDayUnits = {attrs, body ->
        //List projectDayUnits = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayUnit)

        List projectDayUnits = []
        attrs.projectDay.profile.units.each {
            projectDayUnits.add(Entity.get(it))
        }

        if (projectDayUnits)
            out << body(units: projectDayUnits)
        else
            out << body(units: null)
    }

    /**
     * Finds all educators linked to a project day
     *
     * @author Alexander Zeillinger
     * @attr projectDay REQUIRED The project day
     * @return educators a list of educators
     */
    def getProjectDayEducators = {attrs, body ->
        List projectDayEducators = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayEducator)
        if (projectDayEducators)
            out << body(educators: projectDayEducators)
        else
            out << '<span class="italic red">' + message(code: 'educators.choose') + '</span>'
    }

    /**
     * Finds all supplemental educators linked to a project day
     *
     * @author Alexander Zeillinger
     * @attr projectDay REQUIRED The project day
     */
    def getProjectDaySubstitutes = {attrs, body ->
        List projectDaySubstitutes = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDaySubstitute)
        if (projectDaySubstitutes)
            out << body(substitutes: projectDaySubstitutes)
        else
            out << '<span class="italic red">' + message(code: 'substitutes.choose') + '</span>'
    }

    /**
     * Finds all clients linked to a project day
     *
     * @author Alexander Zeillinger
     * @attr projectDay REQUIRED The project day
     */
    def getProjectDayClients = {attrs, body ->
        List projectDayClients = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltGroupMemberClient)
        projectDayClients.sort {it.profile.firstName}
        if (projectDayClients)
            out << body(clients: projectDayClients)
        else
            out << '<span class="italic red">' + message(code: 'clients.choose') + '</span>'
    }

    /**
     * Finds all resources linked to a project day
     *
     * @author Alexander Zeillinger
     * @attr projectDay REQUIRED The project day
     */
    def getProjectDayResources = {attrs, body ->
        List projectDayResources = functionService.findAllByLink(null, attrs.projectDay, metaDataService.ltProjectDayResource)
        if (projectDayResources)
            out << body(resources: projectDayResources)
        else
            out << '<span class="italic">' + message(code: 'resources.notAssigned') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
    }

    /**
     * Finds all activities linked to a project unit
     *
     * @author Alexander Zeillinger
     * @attr projectUnit REQUIRED The project unit
     */
    def getProjectUnitActivities = {attrs, body ->
        List projectUnitActivities = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltGroupMember)
        if (projectUnitActivities)
            out << body(activities: projectUnitActivities)
        else
            out << '<span class="italic">' + message(code: "activityTemplates.notFound") + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
    }

    /**
     * Finds all parents linked to a project unit
     *
     * @author Alexander Zeillinger
     * @attr projectUnit REQUIRED The project unit
     */
    def getProjectUnitParents = {attrs, body ->
        List projectUnitParents = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitParent)
        if (projectUnitParents)
            out << body(parents: projectUnitParents)
        else
            out << '<span class="italic red">' + message(code: 'parents.choose') + '</span>'
    }

    /**
     * Finds the number of parents linked to a project unit
     *
     * @author Alexander Zeillinger
     * @attr projectUnit REQUIRED The project unit
     */
    def getProjectUnitParentsCount = {attrs, body ->
        List projectUnitParents = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitParent)
        out << "(" + projectUnitParents.size() + ")"
    }

    /**
     * Finds all partners linked to a project unit
     *
     * @author Alexander Zeillinger
     * @attr projectUnit REQUIRED The project unit
     */
    def getProjectUnitPartners = {attrs, body ->
        List projectUnitPartners = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltProjectUnitPartner)
        if (projectUnitPartners)
            out << body(partners: projectUnitPartners)
        else
            out << '<span class="italic red">' + message(code: 'partners.choose') + '</span>'
    }

    /**
     * Finds all activity templates linked to a project unit
     *
     * @author Alexander Zeillinger
     * @attr projectUnit REQUIRED The project unit
     */
    def getActivityTemplates = {attrs, body ->
        List activityTemplates = functionService.findAllByLink(null, attrs.projectUnit, metaDataService.ltGroupMember)

        out << render(template:'/projectProfile/activityTemplates', model: [activityTemplates: activityTemplates, unit: attrs.projectUnit, i: attrs.i, project: attrs.project])

        /*<g:render template="/projectProfile/activityTemplates", model: [activityTemplates: activityTemplates, unit: attrs.unit, i: attrs.i, project: attrs.project]"/>
        </erp:getActivityTemplates>
        if (activityTemplates)
            out << body(activityTemplates: activityTemplates)
        else
            out << '<span class="italic red" style="margin-left: 15px">' + message(code: 'activityTemplates.notAssigned') + '</span>'*/
    }

    /**
     * Finds all resources linked to an entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity to find the linked resources from
     */
    def getResources = {attrs, body ->
        List resources = functionService.findAllByLink(null, attrs.entity, metaDataService.ltResource)
        if (resources)
            out << body(resources: resources)
        else
            out << '<span class="italic">' + message(code: 'resources.notAssigned') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
    }

    /**
     * Finds all group members of a given group
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity
     */
    def getGroup = {attrs, body ->
        List groups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
        if (groups)
            out << body(members: groups)
        else
            out << '<span class="italic">Diese Gruppe ist leer</span>'
    }

    /**
     * Returns the size of a group
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity
     */
    def getGroupSize = {attrs, body ->
        def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
        if (result == 0)
            out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
        else
            out << result
    }

    /**
     * Returns the amount of facilities linked to a group
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The group
     */
    def getGroupFacilities = {attrs, body ->
        def result = Link.countBySourceAndType(attrs.entity, metaDataService.ltGroupMemberFacility)
        if (result == 0)
            out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
        else
            out << result
    }

    /**
     * Returns all resources linked to a group
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The group
     */
    def getGroupResources = {attrs, body ->
        def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltResource)
        if (result == 0)
            out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
        else
            out << result
    }

    /**
     * Returns the total duration of the activities within a group
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The group
     */
    def getGroupDuration = {attrs, body ->
        List groups = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)
        def duration = 0
        if (groups)
            groups.each {duration += it.profile.duration}
        out << duration
    }

    /**
     * Returns the entity a resource is linked to - which is either a facility or colony
     *
     * @author Alexander Zeillinger
     * @attr resource REQUIRED The resource
     */
    def resourceCreatedIn = {attrs, body ->
        def result = functionService.findByLink(attrs.resource, null, metaDataService.ltResource)
        if (result)
            out << body(source: result)
    }

    /**
     * Returns the template to a given activity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The activity
     */
    def getTemplate = {attrs, body ->
        Entity template = functionService.findByLink(null, attrs.entity, metaDataService.ltActTemplate)
        if (template)
            out << body(template: template)
        else
            out << '<span class="italic">keine Vorlage vorhanden</span>'
    }

    /**
     * Returns all clients to a given activity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The activity
     */
    def getClients = {attrs, body ->
        List clients = functionService.findAllByLink(null, attrs.entity, metaDataService.ltActClient)
        if (clients)
            out << body(clients: clients)
        else
            out << '<span class="italic">' + message(code: 'clients.empty') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    }

    /**
     * Returns all clients linked to a given pate
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The pate
     */
    def getPateClients = {attrs, body ->
        List pateClients = functionService.findAllByLink(null, attrs.entity, metaDataService.ltPate)
        if (pateClients)
            out << body(clients: pateClients)
        else
            out << '<span class="italic">' + message(code: 'pate.profile.gcs_empty') + '</span>'
    }

    /**
     * Returns all educators linked to a given activity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The activity
     */
    def getEducators = {attrs, body ->
        List educators = functionService.findAllByLink(null, attrs.entity, metaDataService.ltActEducator)
        if (educators)
            out << body(educators: educators)
        else
            out << '<span class="italic">' + message(code: 'educators.empty') + '</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    }

    /**
     * Returns the facility linked to a given activity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The activity
     */
    def getFacility = {attrs, body ->
        Entity facility = functionService.findByLink(null, attrs.entity, metaDataService.ltActFacility)
        if (facility)
            out << body(facility: facility)
        else
            out << '<span class="italic">' + message(code: 'notAssignedToFacility') + '</span>'
    }

    /**
     * Returns the facilities linked to an entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity
     */
    def getFacilitiesOfEducator = {attrs, body ->
        List facilities = functionService.findAllByLink(attrs.entity, null, metaDataService.ltWorking)
        if (facilities)
            out << body(facilities: facilities)
        else
            out << '<span class="italic">' + message(code: 'noData') + '</span>'
    }

    /**
     * Returns the facility linked to a given project
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The project
     */
    def getFacilityOfProject = {attrs, body ->
        Entity facilityOfProject = functionService.findByLink(attrs.entity, null, metaDataService.ltGroupMemberFacility)
        if (facilityOfProject)
            out << body(facility: facilityOfProject)
        else
            out << '<span class="italic">' + message(code: 'notAssignedToFacility') + '</span>'
    }

    /**
     * Returns all subthemes of a given theme
     *
     * @author Alexander Zeillinger
     * @attr theme REQUIRED The theme
     */
    def getSubThemes = {attrs, body ->
        List subThemes = functionService.findAllByLink(null, attrs.theme, metaDataService.ltSubTheme)
        if (subThemes)
            out << body(subthemes: subThemes)
    }

    /**
     * Returns the creator of an entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity
     */
    def createdBy = {attrs, body ->
        def result = functionService.findByLink(null, attrs.entity, metaDataService.ltCreator)
        if (result)
            out << body(creator: result)
    }

    /**
     * Returns the creator (entity) to a given ID
     *
     * @author Alexander Zeillinger
     * @attr id REQUIRED The id of an entity
     */
    def getCreator = {attrs, body ->
        out << body(creator: Entity.get(attrs.id))
    }

    /**
     * Sets the active state of a letter of the glossary
     *
     * @author Alexander Zeillinger
     * @attr glossary REQUIRED The glossary letter
     * @attr letter REQUIRED The current letter
     */
    def active = {attrs ->
        if (attrs.glossary == attrs.letter)
            out << '<span style="background: #050; padding: 1px 3px; color: #fff;">' << attrs.letter << '</span>'
        else
            out << attrs.letter
    }

    /**
     * Finds the colony linked to a given entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity
     */
    def getColony = {attrs, body ->
        out << body(colony: functionService.findByLink(null, attrs.entity, metaDataService.ltColonia))
    }

    /**
     * Returns the gender
     *
     * @author Alexander Zeillinger
     * @attr gender REQUIRED The gender code
     */
    def showGender = {attrs ->
        if (attrs.gender == 1)
            out << message(code: 'male')
        else
            out << message(code: 'female')
    }

    /**
     * Returns the number of new private messages
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity
     */
    def getNewInboxMessages = {attrs, body ->
        def result = Msg.createCriteria().list {
            eq('entity', attrs.entity)
            ne('sender', attrs.entity)
            eq('read', false)
        }

        out << body(result: result.size())
    }

    /**
     * Returns the number of current appointments
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity
     */
    def getCurrentAppointments = {attrs, body ->

        List result = functionService.findAllByLink(null, attrs.entity, metaDataService.ltAppointment)
        result = result.findAll {it.profile.endDate > new Date()}

        out << body(result: result.size())
    }

    /**
     * Returns the number of publications of an entity
     *
     * @author Alexander Zeillinger
     * @attr entity REQUIRED The entity
     */
    def getPublicationCount = {attrs ->
        long m = Publication.countByEntity(attrs.entity)

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

            groupactivitytemplates.each { Entity gat ->
                m += Publication.countByEntity(gat)
            }

            List activitytemplates = []
            groupactivitytemplates.each { Entity gat ->
                def bla = functionService.findAllByLink(null, gat, metaDataService.ltGroupMember)
                bla.each {
                    if (!activitytemplates.contains(it)) // filter duplicate activity templates
                        activitytemplates << it
                }
            }

            activitytemplates.each { Entity at ->
                m += Publication.countByEntity(at)
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

                groupactivitytemplates.each { Entity gat ->
                    m += Publication.countByEntity(gat)
                }

                List activitytemplates = []
                groupactivitytemplates.each { Entity gat ->
                    def bla = functionService.findAllByLink(null, gat, metaDataService.ltGroupMember)
                    bla.each {
                        if (!activitytemplates.contains(it)) // filter duplicate activity templates
                            activitytemplates << it
                    }
                }

                activitytemplates.each { Entity at ->
                    m += Publication.countByEntity(at)
                }
            }
        }

        out << "(" + m + ")"
    }

    /**
     * Returns the link (relationship) type between two given entities
     *
     * @author Alexander Zeillinger
     * @attr source REQUIRED The link source
     * @attr target REQUIRED The link target
     */
    def getRelationship = {attrs ->
        out << Link.findBySourceAndTarget(Entity.findByName(attrs.source), Entity.findByName(attrs.target)).type.name
    }

    /**
     * Starbox rating used for rating elements of methods
     *
     * @author Alexander Zeillinger
     * @attr element REQUIRED The element
     */
    def starBox = {attrs ->

        Entity currentEntity = entityHelperService.loggedIn

        Element element = Element.get(attrs.element)

        def star = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star.png' />"
        def star_empty = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star_empty.png' />"

        def updateDiv = "starBox${element.id}"
        def vote = element.voting

        out << '<span>'
        // if the current entity is admin, operator or the creator display this
        if (currentEntity.user.authorities.find {it.authority == 'ROLE_ADMIN'} || currentEntity.type.id == metaDataService.etOperator.id || accessIsCreatorOf(currentEntity, attrs.template)) {
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
        out << '</span> ' + element.name

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

    def isEnabled = {attrs, body ->
        if (attrs?.entity?.user?.enabled)
            out << body()
    }

    def notEnabled = {attrs, body ->
        if (!attrs?.entity?.user?.enabled)
            out << body()
    }

    def isSystemAdmin = {attrs, body ->
        Entity entity = attrs.entity ?: entityHelperService.loggedIn
        if (entity.user.authorities.find {it.authority == 'ROLE_SYSTEMADMIN'})
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

    def getEvaluationCountForClientAndDay = {attrs ->
        out << Evaluation.countByOwnerAndLinkedTo(attrs.client, attrs.day)
    }

}