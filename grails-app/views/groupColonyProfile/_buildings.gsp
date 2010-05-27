<g:if test="${group.profile.buildings}">
  <ul>
  <g:each in="${group.profile.buildings}" var="building">
    <li>${building.name} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeBuilding" update="buildings2" id="${group.id}" params="[building: building.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Gebäude entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Gebäude eingetragen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>