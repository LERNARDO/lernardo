<g:if test="${client.profile.healths}">
  <ul>
  <g:each in="${client.profile.healths}" var="health">
    <li><span class="gray"><g:formatDate date="${health.date}" format="dd. MM. yyyy" /> - </span> ${health.text} <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeHealth" update="healths2" id="${client.id}" params="[health: health.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="client.profile.healthNotes.empty"/></span>
</g:else>