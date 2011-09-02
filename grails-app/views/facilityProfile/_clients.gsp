<g:if test="${clients}">
  <ul>
  <g:each in="${clients}" var="client">
    <li><g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}" params="[entity:client.id]">${client.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" facilities="[facility]"><g:remoteLink action="removeClient" update="clients2" id="${facility.id}" params="[client: client.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="clients.empty"/></span>
</g:else>