<g:if test="${projectDays}">

  <div>
    <g:each in="${projectDays}" var="projectDay" status="i">
      %{--<div class="daybox ${projectDay.id.toString() == active.toString() ? 'activebox' : ''}"><g:remoteLink update="projectDay" action="setprojectday" id="${projectDay.id}" params="[project: project.id]" before="showspinner('#projectDay')"><g:formatDate date="${projectDay.profile.date}" format="EEEE" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/><g:formatDate date="${projectDay.profile.date}" format="dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></g:remoteLink></div>--}%
      <div class="${projectDay.profile.complete ? 'dayboxcomplete' : 'dayboxincomplete'} ${projectDay.id.toString() == active.toString() ? 'dayboxactive' : ''}"><g:remoteLink update="projectDay" action="setprojectday" id="${projectDay.id}" params="[project: project.id]" before="showspinner('#projectDay')">(${i + 1}) <g:formatDate date="${projectDay.profile.date}" format="EEEE" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/><g:formatDate date="${projectDay.profile.date}" format="dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></g:remoteLink></div>
    </g:each>
    <div class="clear"></div>
  </div>

  <div class="zusatz-show">
    <g:render template="projectday" model="[project: project, projectDay: day, resources: resources, allEducators: allEducators, allParents: allParents, units: units, plannableResources: plannableResources, requiredResources: requiredResources, outOfRange: outOfRange, conflictingDate: conflictingDate]"/>
  </div>

</g:if>