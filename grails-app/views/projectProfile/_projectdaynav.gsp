<g:if test="${projectDays}">

  <div style="margin-left: 5px">
    <g:each in="${projectDays}" var="projectDay">
      <div class="daybox ${projectDay.id.toString() == active.toString() ? 'activebox' : ''}"><g:remoteLink update="projectDay" action="updateprojectday" id="${projectDay.id}" params="[project: project.id]" before="showspinner('#projectDay')"><g:formatDate date="${projectDay.profile.date}" format="EEEE"/><br/><g:formatDate date="${projectDay.profile.date}" format="dd. MMMM yyyy"/></g:remoteLink></div>
    </g:each>
    <div class="spacer"></div>
  </div>

  <div class="zusatz-show">
    <g:render template="projectday" model="[projectDay: day, allResources: allResources, allEducators: allEducators, allParents: allParents, units: units, entity: entity]"/>
  </div>

</g:if>