<g:if test="${clients}">
  <ul>
  <g:each in="${clients}" var="client">
    <li><g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}" params="[entity:client.id]">${client.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN']" types="['Betreiber']"><g:remoteLink action="removeClient" update="clients2" id="${group.id}" params="[client: client.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false" after="${remoteFunction(action:'updateFamilyCount',update:'familyCount',id:group.id)}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Betreuten entfernen" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="groupFamily.profile.clients.empty"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>