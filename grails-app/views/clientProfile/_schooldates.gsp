<g:if test="${client.profile.schooldates}">
  <ul>
  <g:each in="${client.profile.schooldates}" var="date" status="i">
    <li><span class="gray"><g:formatDate date="${date.date}" format="dd. MM. yyyy" /> - </span> <g:message code="client.date.${date.type}"/> - ${date.reason} <g:if test="${i + 1 == client.profile.schooldates.size()}"> <erp:accessCheck types="['Betreiber','Pädagoge']"><g:remoteLink action="removeSchoolDate" update="schooldates2" id="${client.id}" params="[date: date.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></g:if></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="client.profile.inOut.empty"/></span>
</g:else>