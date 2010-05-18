<g:if test="${facilities}">
  <ul>
  <g:each in="${facilities}" var="facility">
    <li><g:link controller="${facility.type.supertype.name +'Profile'}" action="show" id="${facility.id}" params="[entity:facility.id]">${facility.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeFacility" update="facilities2" id="${operator.id}" params="[facility: facility.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Einrichtung entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Einrichtungen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>