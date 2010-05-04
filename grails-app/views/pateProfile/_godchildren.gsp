<g:if test="${godchildren}">
  <ul>
  <g:each in="${godchildren}" var="child">
    <li><g:link controller="${child.type.supertype.name +'Profile'}" action="show" id="${child.id}" params="[entity:child.id]">${child.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeGodchildren" update="godchildren2" id="${child.id}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Patenkind entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Patenkinder zugewiesen</span>
</g:else>