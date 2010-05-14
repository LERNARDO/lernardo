<g:if test="${resources}">
  <ul>
  <g:each in="${resources}" var="resource">
    <li><g:link controller="${resource.type.supertype.name +'Profile'}" action="show" id="${resource.id}" params="[entity:entity.id]">${resource.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeResource" update="resources2" id="${facility.id}" params="[resource: resource.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ressource entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Ressourcen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>