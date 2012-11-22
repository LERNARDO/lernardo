<g:if test="${parent.profile.dates}">
  <ul>
  <g:each in="${parent.profile.dates}" var="date" status="i">
    <li><span class="gray"><g:formatDate date="${date.date}" format="dd. MM. yyyy" /> - </span> <g:message code="client.date.${date.type}"/> <g:if test="${i + 1 == parent.profile.dates.size()}"> <erp:accessCheck types="['Betreiber','Pädagoge']"><g:remoteLink action="removeDate" update="dates2" id="${parent.id}" params="[date: date.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></g:if></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="client.profile.inOut.empty"/></span>
</g:else>