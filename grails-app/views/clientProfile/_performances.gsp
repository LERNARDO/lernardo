<g:if test="${client.profile.performances}">
  <ul>
  <g:each in="${client.profile.performances}" var="performance">
    <li>
      <span class="gray"><g:formatDate date="${performance.date}" format="dd. MM. yyyy" /> - </span> ${performance.text} <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><g:remoteLink action="removePerformance" update="performances2" id="${client.id}" params="[performance: performance.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="client.profile.schoolPerformance.empty"/></span>
</g:else>

