<g:if test="${projectDays}">

  <div>
    <g:each in="${projectDays}" var="projectDay">
      <div class="daybox ${projectDay.id.toString() == active.toString() ? 'activebox' : ''}"><g:remoteLink update="projectDay" action="updateprojectday" id="${projectDay.id}" params="[project: project.id]" before="showspinner('#projectDay')"><g:formatDate date="${projectDay.profile.date}" format="EEEE" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/><g:formatDate date="${projectDay.profile.date}" format="dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></g:remoteLink></div>
    </g:each>
    <div class="clear"></div>
  </div>

  <erp:accessCheck types="['Betreiber']" creatorof="${project}">
    <g:if test="${projectDays.size() > 1}">
      <div class="buttons">
        <g:link class="buttonRed" controller="projectProfile" action="deleteProjectDay" id="${day.id}" params="[project: project.id]" onclick="return confirm('${message(code: 'sure')}');">Projekttag löschen</g:link>
        <div class="clear"></div>
      </div>
    </g:if>
  </erp:accessCheck>

  <div class="zusatz-show">
    <g:render template="projectday" model="[project: project, projectDay: day, resources: resources, allEducators: allEducators, allParents: allParents, units: units, plannableResources: plannableResources, requiredResources: requiredResources, outOfRange: outOfRange, conflictingDate: conflictingDate]"/>
  </div>

</g:if>