<g:if test="${client.profile.status}">
  <ul>
  <g:each in="${client.profile.status}" var="performance">
    <g:if test="${performance.type == 'performance'}">
      <li><g:formatDate date="${performance.date}" format="dd. MM. yyyy"/> ${performance.text} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removePerformance" update="performances2" id="${client.id}" params="[performance: performance.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Schulleistung entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    </g:if>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="client.profile.schoolPerformance.empty"/> </span>
</g:else>

