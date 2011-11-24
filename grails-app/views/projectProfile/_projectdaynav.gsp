<g:if test="${projectDays}">

  <div>
    <g:each in="${projectDays}" var="projectDay">
      <div class="daybox ${projectDay.id.toString() == active.toString() ? 'activebox' : ''}"><g:remoteLink update="projectDay" action="updateprojectday" id="${projectDay.id}" params="[project: project.id]" before="showspinner('#projectDay')"><g:formatDate date="${projectDay.profile.date}" format="EEEE" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/><g:formatDate date="${projectDay.profile.date}" format="dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></g:remoteLink></div>
    </g:each>
    <div class="spacer"></div>
  </div>

  <div class="zusatz-show">
    <g:render template="projectday" model="[project: project, projectDay: day, resources: resources, allEducators: allEducators, allParents: allParents, units: units, entity: entity, plannableResources: plannableResources, requiredResources: requiredResources]"/>
  </div>

</g:if>