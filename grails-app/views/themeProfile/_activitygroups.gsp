<g:if test="${activitygroups}">
  <ul>
  <g:each in="${activitygroups}" var="activitygroup">
    <li><g:link controller="${activitygroup.type.supertype.name + 'Profile'}" action="show" id="${activitygroup.id}">${activitygroup.profile}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeActivityGroup" update="activitygroups2" id="${activitygroup.id}" params="[activitygroup: activitygroup.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="groupActivities.notAssigned"/></span>
</g:else>