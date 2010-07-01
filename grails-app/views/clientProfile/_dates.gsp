<g:if test="${client.profile.dates}">
  <ul>
  <g:each in="${client.profile.dates}" var="date" status="i">
    <li><g:formatDate date="${date.date}" format="dd. MM. yyyy"/> (${date.type})<g:if test="${i + 1 == client.profile.dates.size()}"> <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><g:remoteLink action="removeDate" update="dates2" id="${client.id}" params="[date: date.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Datum entfernen" align="top"/></g:remoteLink></app:hasRoleOrType></g:if></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="client.profile.inOut.empty"/></span>
</g:else>