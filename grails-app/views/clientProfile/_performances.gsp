<g:if test="${client.profile.performances}">
  <ul>
  <g:each in="${client.profile.performances}" var="performance">
    <li><span class="bold"><g:formatDate date="${performance.date}" format="dd. MM. yyyy"/> - </span> ${performance.text} <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><g:remoteLink action="removePerformance" update="performances2" id="${client.id}" params="[performance: performance.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Schulleistung entfernen" align="top"/></g:remoteLink></app:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="client.profile.schoolPerformance.empty"/></span>
</g:else>

