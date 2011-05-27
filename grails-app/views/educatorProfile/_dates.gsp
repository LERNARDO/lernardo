<g:if test="${educator.profile.dates}">
  <ul>
  <g:each in="${educator.profile.dates}" var="date" status="i">
    %{--
    <li><g:formatDate date="${date.date}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> (<g:message code="client.date.${date.type}"/>)<g:if test="${i + 1 == educator.profile.dates.size()}"> <erp:accessCheck entity="${entity}" types="['Betreiber']"><g:remoteLink action="removeDate" update="dates2" id="${educator.id}" params="[date: date.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></g:if></li>
    --}%
    <li><g:formatDate date="${date.date}" format="dd. MM. yyyy" /> (<g:message code="client.date.${date.type}"/>)<g:if test="${i + 1 == educator.profile.dates.size()}"> <erp:accessCheck entity="${entity}" types="['Betreiber']"><g:remoteLink action="removeDate" update="dates2" id="${educator.id}" params="[date: date.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></g:if></li>


  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="educator.profile.inOut.empty"/></span>
</g:else>