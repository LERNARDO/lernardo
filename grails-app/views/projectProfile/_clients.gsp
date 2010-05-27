<g:if test="${clients}">
  <ul>
  <g:each in="${clients}" var="client">
    <li><g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}" params="[entity:client.id]">${client.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeClient" update="clients2" id="${project.id}" params="[client: client.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Betreuten entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Betreuten zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>