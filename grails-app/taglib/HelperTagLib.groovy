import at.openfactory.ep.Entity
import at.openfactory.ep.Link
import java.text.SimpleDateFormat
import org.springframework.web.servlet.support.RequestContextUtils
import lernardo.Element
import at.openfactory.ep.EntityHelperService
import standard.MetaDataService
import standard.FilterService
import at.openfactory.ep.SecHelperService
import standard.FunctionService
import lernardo.Publication
import lernardo.WorkdayCategory

class HelperTagLib {
  EntityHelperService entityHelperService
  MetaDataService metaDataService
  FilterService filterService
  SecHelperService secHelperService
  FunctionService functionService
  def securityManager
  static namespace = "app"

  def getTotalHours = { attrs, body ->
    if (attrs.date1 != null && attrs.date2 != null) {
      Date date1 = Date.parse("dd. MM. yy", attrs.date1)
      Date date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator

    int hours = 0
    educator.profile.workdayunits.each {
      // check if the date of the workdayunit is between date1 and date2
      if (attrs.date1 != null & attrs.date2 != null) {
        if (it.date1.getYear() >= date1.getYear() && it.date1.getYear() <= date2.getYear() &&
            it.date1.getMonth() >= date1.getMonth() && it.date1.getMonth() <= date2.getMonth() &&
            it.date1.getDate() >= date1.getDate() && it.date1.getDate() <= date2.getDate()) {
              hours += (it.date2.getTime() - it.date1.getTime()) / 1000 / 60 / 60
        }
      }
      else
        hours += (it.date2.getTime() - it.date1.getTime()) / 1000 / 60 / 60
    }

    out << hours
  }

  /*
   * used for time evaluation, returns the number of hours of an educator an a given category
   */
  def getHoursForCategory = { attrs, body ->
    println params
    Date date1
    Date date2
    if (attrs.date1 != "" && attrs.date2 != "") {
      date1 = Date.parse("dd. MM. yy", attrs.date1)
      date2 = Date.parse("dd. MM. yy", attrs.date2)
    }

    Entity educator = attrs.educator
    WorkdayCategory workdayCategory = attrs.category

    int hours = 0
    educator.profile.workdayunits.each {
      if (it.category == workdayCategory.name) {

        // check if the date of the workdayunit is between date1 and date2
        if (attrs.date1 != "" & attrs.date2 != "") {

          if (it.date1.getYear() >= date1.getYear() && it.date1.getYear() <= date2.getYear() &&
              it.date1.getMonth() >= date1.getMonth() && it.date1.getMonth() <= date2.getMonth() &&
              it.date1.getDate() >= date1.getDate() && it.date1.getDate() <= date2.getDate()) {
                hours += (it.date2.getTime() - it.date1.getTime()) / 1000 / 60 / 60
          }
        }
        else
          hours += (it.date2.getTime() - it.date1.getTime()) / 1000 / 60 / 60
      }
    }

    out << hours
  }

  /*
   * custom tag for as long as the official implementation is broken, see http://jira.codehaus.org/browse/GRAILS-2512--}%
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

  /*
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

  /*
   * get the tags of a given entity
   */
  def getTags = {attrs, body ->
    Entity entity = attrs.entity
    List tags = entity.tagslinks.collect {it.tag}
    out << body(tags: tags)
  }

  /*
   * checks whether to render a tag button
   */
  def showTagButton = {attrs, body ->
    List tags = attrs.tags
    List tagnames = tags.collect {it.name}
    if (!tagnames.contains(attrs.button))
      out << body()
  }

  /*
   * before deleting an entity this method finds any links to and from the entity and returns a confirmation message
   */
  def getLinks = {attrs ->
    Integer id = attrs.id
    Entity entity = Entity.get(id)

    def linksTarget = Link.findAllByTarget(entity)
    List sourceNames = linksTarget.collect {it.source.profile.fullName}

    def linksSource = Link.findAllBySource(entity)
    List targetNames = linksSource.collect {it.target.profile.fullName}

    if (sourceNames.size() == 0 && targetNames.size() == 0)
      out << "return confirm('Es bestehen keine Beziehungen! Löschen bitte bestätigen!')"
    else if (sourceNames.size() > 0 && targetNames.size() == 0)
      out << "return confirm('Es bestehen Beziehungen zu " + sourceNames + "! Löschen bitte bestätigen!')"
    else if (sourceNames.size() == 0 && targetNames.size() > 0)
      out << "return confirm('Es bestehen Beziehungen von " + targetNames + "! Löschen bitte bestätigen!')"
    else
      out << "return confirm('Es bestehen Beziehungen zu " + sourceNames + " und von " + targetNames + "! Löschen bitte bestätigen!')"
  }

  /*
   * new access control methods, separated for modular usage
   */
  def accessCheck = {attrs, body ->
    Entity entity = attrs.entity

    //log.info "----------"

    boolean hasRoles = false
    if (attrs.roles)
      hasRoles = accessHasRoles(entity, attrs.roles)
    //log.info "${entity.profile} has roles: ${hasRoles}"

    boolean hasTypes = false
    if (attrs.types)
      hasTypes = accessHasTypes(entity, attrs.types)
    //log.info "${entity.profile} has types: ${hasTypes}"

    boolean isMe = false
    if (attrs.me)
      isMe = accessIsMe(entity)
    //log.info "${entity.profile} is me: ${isMe}"

    boolean isLeadEducator = false
    if (attrs.facility)
      isLeadEducator = accessIsLeadEducator(entity, attrs.facility)
    //log.info "${entity.profile} is lead educator: ${isLeadEducator}"

    if (hasRoles || hasTypes || isMe || isLeadEducator)
      out << body()
  }

  // checks if a given entity has at least one of the given roles
  boolean accessHasRoles(Entity entity, List roles) {

    def result = false

    if (entity.user) {
      result = roles.findAll { entity.user?.authorities*.authority.contains(it) }
    }

    return result ? true : false
  }

  // checks if a given entity is of one of the given types
  boolean accessHasTypes(Entity entity, List types) {

    def result = types.findAll { entity.type?.name == it }

    return result ? true : false
  }

  // checks if a given entity is the currently logged in entity
  boolean accessIsMe(Entity entity) {

    def result = entity == entityHelperService.loggedIn

    return result
  }

  // checks if a given entity is lead educator of a given facility
  boolean accessIsLeadEducator(Entity entity, Entity facility) {

    def c = Link.createCriteria()
    def link = c.get {
      eq('source', entity)
      eq('target', facility)
      eq('type', metaDataService.ltLeadEducator)
    }

    def result = link ? true : false

    return result
  }
  /*
   * receives a family status ID and renders either the german or spanish word for it
   */
  def getFamilyStatus = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.familyRelation_de[attrs.status]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.familyRelation_es[attrs.status]
  }

  /*
   *  receives a nationality ID and renders either the german or spanish word for it
   */
  def getNationalities = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.nationalities_de[attrs.nationality]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.nationalities_es[attrs.nationality]
  }

  /*
   * receives a language ID and renders either the german or spanish word for it
   */
  def getLanguages = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.languages_de[attrs.language]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.languages_es[attrs.language]
  }

  def getLanguagesNoe = {attrs ->
    out << grailsApplication.config.languages[attrs.language]
  }

  /*
   * receives a inChargeOf ID and renders either the german or spanish word for it
   */
  def getInChargeOf = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.inchargeof_de[attrs.inchargeof]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.inchargeof_es[attrs.inchargeof]
  }

  /*
   * receives a partner service ID and renders either the german or spanish word for it
   */
  def getPartnerService = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.partner_de[attrs.service]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.partner_es[attrs.service]
  }

  /*
   * receives a school level ID and renders either the german or spanish word for it
   */
  def getSchoolLevel = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.schoolLevels_de[attrs.level]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.schoolLevels_es[attrs.level]
  }

  def getSchoolLevelNoe = {attrs ->
    out << grailsApplication.config.schoolLevels[attrs.level]
  }

  /*
   * receives a maritalStatus ID and renders either the german or spanish word for it
   */
  def getMaritalStatus = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.maritalStatus_de[attrs.level]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.maritalStatus_es[attrs.level]
  }

  /*
   * receives a familyProblem ID and renders either the german or spanish word for it
   */
  def getFamilyProblem = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.problems_de[attrs.problem]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.problems_es[attrs.problem]
  }

  /*
   * receives a jobType ID and renders either the german or spanish word for it
   */
  def getJobType = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.jobs_de[attrs.job]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.jobs_es[attrs.job]
  }

  def getJobTypeNoe = {attrs ->
    out << grailsApplication.config.jobs[attrs.job]
  }

  /*
   * receives a profileType Name and renders either the german or spanish word for it     # hafo
   */
  def getProfileTypeName = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.profileType_de[attrs.name]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.profileType_es[attrs.name]
  }

  /*
   * receives a dateType and renders either the german or spanish word for it     # hafo
   */
  def getDateType = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.dateType_de[attrs.name]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.dateType_es[attrs.name]
  }

  /*
   * receives a education ID and renders either the german or spanish word for it
   */
  def getEducation = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.education_de[attrs.education]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.education_es[attrs.education]
  }

  def getEducationNoe = {attrs ->
    out << grailsApplication.config.education[attrs.education]
  }

  /*
   * receives a classification ID and renders either the german or spanish word for it
   */
  def getClassification = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.resourceclasses_de[attrs.classification]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.resourceclasses_es[attrs.classification]
  }

  /*
   * receives an employment ID and renders either the german or spanish word for it
   */
  def getEmployment = {attrs ->
    Locale locale = RequestContextUtils.getLocale(request) ?: new Locale("de", "DE")
    if (locale.toString() == "de" || locale.toString() == "de_DE")
      out << grailsApplication.config.employment_de[attrs.employment]
    if (locale.toString() == "es" || locale.toString() == "es_ES")
      out << grailsApplication.config.employment_es[attrs.employment]
  }

  def getEmploymentNoe = {attrs ->
    out << grailsApplication.config.employment[attrs.employment]
  }

  /*
   * outputs selectbox items for each language
   */
  def localeSelect = {attrs ->
    attrs['from'] = grailsApplication.config.locales
    attrs['value'] = (attrs['value'] ? attrs['value'] : RequestContextUtils.getLocale(request))
    // set the key as a closure that formats the locale
    attrs['optionKey'] = {"${it.language}_${it.country}"}
    // set the option value as a closure that formats the locale for display
    attrs['optionValue'] = {"${it.displayLanguage}"}

    // use generic select
    out << select(attrs)
  }

  /*
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

  /*
   * finds the number of units linked to a project template
   */
  def getProjectTemplateUnitsCount = {attrs, body ->
    def units = Link.countByTargetAndType(attrs.template, metaDataService.ltProjectUnitTemplate)
    out << units
  }

  /*
   * finds the number of clients linked to a client group
   */
  def getGroupClientsCount = {attrs, body ->
    def clients = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberClient)
    out << clients
  }

  /*
   * finds all project units linked to a project day
   */
  def getProjectDayUnits = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayUnit)
    if (link)
      link.each {out << body(units: it.source)}
    else
      out << '<span class="italic red">Bitte die Projekteinheiten auswählen, die an diesem Projekttag stattfinden sollen!</span></span>'
  }

  /*
   * finds all educators linked to a project day
   */
  def getProjectDayEducators = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayEducator)
    if (link)
      link.each {out << body(educators: it.source)}
    else
      out << '<span class="italic red">Bitte die Pädagogen auswählen, die an diesem Projekttag teilnehmen!</span></span>'
  }

  /*
   * finds all supplemental educators linked to a project day
   */
  def getProjectDaySubstitutes = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDaySubstitute)
    if (link)
      link.each {out << body(educators: it.source)}
    else
      out << '<span class="italic red">Bitte die Ersatzpädagogen auswählen, die an diesem Projekttag teilnehmen!</span></span>'
  }

  /*
   * finds all resources linked to a project day
   */
  def getProjectDayResources = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectDay, metaDataService.ltProjectDayResource)
    if (link)
      link.each {out << body(resources: it.source)}
    else
      out << '<span class="italic">Keine Resourcen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all activity groups linked to a project unit
   */
  def getProjectUnitActivityGroups = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnit)
    if (link)
      link.each {out << body(activityGroups: it.source)}
    else
      out << '<span class="italic">Keine Aktivitätsblockvorlagen gefunden</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all parents linked to a project unit
   */
  def getProjectUnitParents = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitParent)
    if (link)
      link.each {out << body(parents: it.source)}
    else
      out << '<span class="italic red">Bitte die Erziehungsberechtigten auswählen, die an dieser Projekteinheit teilnehmen!</span></span>'
  }

  /*
   * finds all partners linked to a project unit
   */
  def getProjectUnitPartners = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitPartner)
    if (link)
      link.each {out << body(partners: it.source)}
    else
      out << '<span class="italic red">Bitte die Partner auswählen, die an dieser Projekteinheit teilnehmen!</span></span>'
  }

  /*
   * finds all group activity templates linked to a project unit
   */
  def getGroupActivityTemplates = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.projectUnit, metaDataService.ltProjectUnitMember)
    if (link)
      link.each {out << body(groupActivityTemplates: it.source)}
    else
      out << '<span class="italic red" style="margin-left: 15px">Keine Aktivitätsblockvorlagen zugewiesen!</span></span>'
  }

  /*
   * finds all resources linked to an entity
   */
  def getResources = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltResource)
    if (link)
      link.each {out << body(resources: it.source)}
    else
      out << '<span class="italic">Keine Ressourcen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * finds all group members of a given group
   */
  def getGroup = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    if (link)
      link.each {out << body(members: it.source)}
    else
      out << '<span class="italic">Diese Gruppe ist leer</span>'
  }

  /*
   * returns the size of a group
   */
  def getGroupSize = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMember)

    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /*
   * returns all facilities linked to a group
   */
  def getGroupFacilities = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltGroupMemberFacility)

    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /*
   * returns all resources linked to a group
   */
  def getGroupResources = {attrs, body ->
    def result = Link.countByTargetAndType(attrs.entity, metaDataService.ltResource)

    if (result == 0)
      out << '0 <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/>'
    else
      out << result
  }

  /*
   * returns the total duration of the activities within a group
   */
  def getGroupDuration = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltGroupMember)
    def duration = 0
    if (link)
      link.each {duration += it.source.profile.duration}
    out << duration
  }

  /*
   * returns the entity a resource is linked to - which is either a facility or colony
   */
  def resourceCreatedIn = {attrs, body ->
    def result = functionService.findByLink(attrs.resource, null, metaDataService.ltResource)
    if (result)
      out << body(source: result)
  }

  /*
   * returns the template to a given activity
   */
  def getTemplate = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltActTemplate)
    if (link)
      out << body(template: link.source)
    else
      out << '<span class="italic">keine Vorlage vorhanden</span>'
  }

  /*
   * returns all clients to a given activity
   */
  def getClients = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltActClient)
    if (link)
      link.each {out << body(clients: it.source)}
    else
      out << '<span class="italic">keine Betreuten zugewiesen <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns all clients linked to a given pate
   */
  def getPateClients = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltPate)
    if (link)
      link.each {out << body(clients: it.source)}
    else
      out << '<span class="italic">keine Betreuten zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns all educators linked to a given activity
   */
  def getEducators = {attrs, body ->
    def link = Link.findAllByTargetAndType(attrs.entity, metaDataService.ltActEducator)
    if (link)
      link.each {out << body(educators: it.source)}
    else
      out << '<span class="italic">keine Pädagogen zugewiesen</span> <img src="' + g.resource(dir: 'images/icons', file: 'icon_warning.png') + '" alt="toolTip" align="top"/></span>'
  }

  /*
   * returns the facility linked to a given activity
   */
  def getFacility = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltActFacility)
    if (link)
      out << body(facility: link.source)
    else
      out << '<span class="italic">keiner Einrichtung zugewiesen</span>'
  }

  /*
   * returns the facility linked to a given activity
   */
  def getFacilityOfProject = {attrs, body ->
    def link = Link.findByTargetAndType(attrs.entity, metaDataService.ltGroupMemberFacility)
    if (link)
      out << body(facility: link.source)
    else
      out << '<span class="italic">keiner Einrichtung zugewiesen</span>'
  }

  /*
   * returns all subthemes of a given activity
   */
  def getSubThemes = {attrs, body ->
    def links = Link.findAllByTargetAndType(attrs.theme, metaDataService.ltSubTheme)
    if (links)
      links.each {out << body(subthemes: it.source)}
  }

  /*
   * returns the creator (entity) to a given ID
   */
  def getCreator = {attrs, body ->
    out << body(creator: Entity.get(attrs.id))
  }

  /*
   * checks whether the given entity is a parent (or has the admin role)
   */
  def isParent = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etParent.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is a pate (or has the admin role)
   */
  def isPate = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etPate.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is a partner (or has the admin role)
   */
  def isPartner = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etPartner.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is a client (or has the admin role)
   */
  def isClient = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etClient.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is a facility (or has the admin role)
   */
  def isFacility = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etFacility.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is an educator (or has the admin role)
   */
  def isEducator = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etEducator.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity is an operator (or has the admin role)
   */
  def isOperator = {attrs, body ->
    if (attrs.entity.type.name == metaDataService.etOperator.name || secHelperService.isAdmin())
      out << body()
  }

  /*
   * checks whether the given entity was created by the current user
   */
  def isCreator = {attrs, body ->
    Entity currentEntity = entityHelperService.loggedIn
    def c = Link.createCriteria()
    def link = c.get {
      eq('source', currentEntity)
      eq('target', attrs.entity)
      eq('type', metaDataService.ltCreator)
    }
    // show also when the current user is an operator, admin or sysadmin
    if (link || currentEntity.type.name == metaDataService.etOperator.name || secHelperService.isAdmin() || secHelperService.hasRole('ROLE_SYSTEMADMIN'))
      out << body()
  }

  /*
   * sets the active state of each letter of the glossary
   */
  def active = {attrs ->
    if (attrs.glossary == attrs.letter)
      out << '<span style="background: #050; padding: 1px 3px; color: #fff;">' << attrs.letter << '</span>'
    else
      out << attrs.letter
  }

  /*
   * returns the quote of the day
   */
  def getQuoteOfTheDay = {
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat("dd")
    String day = df.format(myDate)
    out << '<span class="quote">"' + grailsApplication.config.quotesMap[day] + '"</span>'
    out << '<p class="quoter">von ' + grailsApplication.config.quoterMap[day] + '</p>'
  }

  /*
   * returns the pic of the day
   */
  def getPicOfTheDay = { attrs, body ->
    Date myDate = new Date()
    SimpleDateFormat df = new SimpleDateFormat("dd")
    String day = df.format(myDate)
    out << body(day)
  }

  /*
   * returns the gender
   */
  def showGender = {attrs ->
    if (attrs.gender == 1)
      out << message(code: 'male')
    else
      out << message(code: 'female')
  }

  /*
   * returns the number of new private messages through a service
   */
  def getNewInboxMessages = {attrs ->
    int m = filterService.getNewInboxMessages(attrs.entity.id.toInteger())
    if (m > 0)
      out << "(" + m + ")"
  }

  /*
   * returns the number of publications of an entity
   */
  def getPublicationCount = {attrs ->
    int m = Publication.countByEntity(attrs.entity)

    // group activity template
    if (attrs.entity.type.id == metaDataService.etGroupActivityTemplate.id) {
      List activitytemplates = functionService.findAllByLink(null, attrs.entity, metaDataService.ltGroupMember)

      activitytemplates.each {
        m += Publication.countByEntity(it as Entity)
      }
    }

    // group activity
    if (attrs.entity.type.id == metaDataService.etGroupActivity.id) {
      Entity groupactivitytemplate = functionService.findByLink(null, attrs.entity, metaDataService.ltTemplate)

      m += Publication.countByEntity(groupactivitytemplate)

      List activitytemplates = functionService.findAllByLink(null, groupactivitytemplate, metaDataService.ltGroupMember)

      activitytemplates.each {
        m += Publication.countByEntity(it as Entity)
      }
    }

    // project template
    if (attrs.entity.type.id == metaDataService.etProjectTemplate.id) {
      List projectUnits = functionService.findAllByLink(null, attrs.entity, metaDataService.ltProjectUnit)

      List groupactivitytemplates = []
      projectUnits.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnitMember)
        bla.each {
          if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
            groupactivitytemplates << it
        }
      }

      groupactivitytemplates.each {
        m += Publication.countByEntity(it)
      }

      List activitytemplates = []
      groupactivitytemplates.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltGroupMember)
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
    if (attrs.entity.type.id == metaDataService.etProject.id) {
      Entity projectTemplate = functionService.findByLink(null, attrs.entity, metaDataService.ltProjectTemplate)

      m += Publication.countByEntity(projectTemplate)

      List projectUnits = functionService.findAllByLink(null, projectTemplate, metaDataService.ltProjectUnit)

      List groupactivitytemplates = []
      projectUnits.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltProjectUnitMember)
        bla.each {
          if (!groupactivitytemplates.contains(it)) // filter duplicate group activity templates
            groupactivitytemplates << it
        }
      }

      groupactivitytemplates.each {
        m += Publication.countByEntity(it)
      }

      List activitytemplates = []
      groupactivitytemplates.each {
        def bla = functionService.findAllByLink(null, it as Entity, metaDataService.ltGroupMember)
        bla.each {
          if (!activitytemplates.contains(it)) // filter duplicate activity templates
            activitytemplates << it
        }
      }

      activitytemplates.each {
        m += Publication.countByEntity(it) 
      }
    }
    
    out << "(" + m + ")"
  }

  /*
   * returns the link (relationship) type between two given entities
   */
  def getRelationship = {attrs ->
    out << Link.findBySourceAndTarget(Entity.findByName(attrs.source), Entity.findByName(attrs.target)).type.name
  }

  /*
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
    if (Entity.get(attrs.entity.id).user.enabled)
      out << body()
  }

  def notEnabled = {attrs, body ->
    if (!Entity.get(attrs.entity.id).user.enabled)
      out << body()
  }

  def isAdmin = {attrs, body ->
    if (secHelperService.isAdmin())
      out << body()
  }

  def notAdmin = {attrs, body ->
    if (!secHelperService.isAdmin())
      out << body()
  }

  def isMeOrAdmin = {attrs, body ->
    if (secHelperService.isMeOrAdmin(attrs.entity))
      out << body()
  }

  def isMeOrAdminOrOperator = {attrs, body ->
    if (secHelperService.isMeOrAdmin(attrs.entity) || entityHelperService.loggedIn.type.id == metaDataService.etOperator.id)
      out << body()
  }

  def isSysAdmin = {attrs, body ->
    // "secHelperService.hasRole" is broken so let's use this
    def entity = attrs.entity ?: entityHelperService.loggedIn

    entity.user.authorities.each {
      if (it.authority == "ROLE_SYSTEMADMIN")
        out << body()
        return
    }
  }

  def isMe = {attrs, body ->
    if (entityHelperService.loggedIn?.id == attrs.entity.id)
      out << body()
  }

  def notMe = {attrs, body ->
    if (secHelperService.isNotMe(attrs.entity))
      out << body()
  }

  def hasNotRoles = {attrs, body ->
    def entity = attrs.entity ?: entityHelperService.loggedIn

    def res = !attrs.roles.find { entity.user.authorities*.authority.contains(it) }
    if (res)
      out << body()
  }

  def hasRoles = {attrs, body ->
    def entity = attrs.entity ?: entityHelperService.loggedIn

    def res = attrs.roles.findAll { entity.user.authorities*.authority.contains(it) }
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

  /*
   * starbox rating used for rating elements of methods
   */
  def starBox = {attrs ->

    Element element = Element.get(attrs.element)

    def star = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star.png'/>"
    def star_empty = "<img src='${grailsAttributes.getApplicationUri(request)}/images/icons/icon_star_empty.png'/>"

    def updateDiv = "starBox${element.id}"
    def vote = element.voting

    out << '<div>'
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 1]) { vote > 0 ? star : star_empty }
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 2]) { vote > 1 ? star : star_empty }
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 3]) { vote > 2 ? star : star_empty }
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 4]) { vote > 3 ? star : star_empty }
    out << remoteLink(update: updateDiv, controller: 'templateProfile', action: 'vote', params: [element: element.id, val: 5]) { vote > 4 ? star : star_empty }
    out << '</div>'

  }

  def getActiveEducator = {attrs, body ->

    // For some weird reason all but the last element in the list are of type String and the last element is not of type String so both types
    // need to be checked... WTF Groovy?!?
    def result = attrs.educators.contains(attrs.id.toString()) || attrs.educators.contains(attrs.id)

    out << body(active: result)
  }

}
