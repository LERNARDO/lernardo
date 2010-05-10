<g:if test="${group.profile.representatives}">
  <ul>
  <g:each in="${group.profile.representatives}" var="representative">
    <li>${representative.firstName} ${representative.lastName} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeRepresentative" update="representatives2" id="${group.id}" params="[representative: representative.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Repräsentant entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Repräsentanten eingetragen</span>
</g:else>