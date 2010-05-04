<g:if test="${client.profile.status}">
  <ul>
  <g:each in="${client.profile.status}" var="health">
    <g:if test="${health.type == 'health'}">
      <li><g:formatDate date="${health.date}" format="dd. MM. yyyy"/> ${health.text}<app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeHealth" update="healths2" id="${client.id}" params="[health: health.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Health entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    </g:if>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Healths eingetragen</span>
</g:else>