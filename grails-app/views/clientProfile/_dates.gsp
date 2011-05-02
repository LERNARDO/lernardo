<g:if test="${client.profile.dates}">
  <ul>
  <g:each in="${client.profile.dates}" var="date" status="i">
    <li><g:formatDate date="${date.date}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> (<g:message code="client.date.${date.type}"/>)<g:if test="${i + 1 == client.profile.dates.size()}"> <erp:accessCheck entity="${entity}" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeDate" update="dates2" id="${client.id}" params="[date: date.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Datum entfernen" align="top"/></g:remoteLink></erp:accessCheck></g:if></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="client.profile.inOut.empty"/></span>
</g:else>