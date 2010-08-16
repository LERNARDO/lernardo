<g:if test="${educator.profile.dates}">
  <ul>
  <g:each in="${educator.profile.dates}" var="date" status="i">
    <li><g:formatDate date="${date.date}" format="dd. MM. yyyy"/> (${date.type})<g:if test="${i + 1 == educator.profile.dates.size()}"> <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><g:remoteLink action="removeDate" update="dates2" id="${educator.id}" params="[date: date.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Datum entfernen" align="top"/></g:remoteLink></app:hasRoleOrType></g:if></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="educator.profile.inOut.empty"/></span>
</g:else>