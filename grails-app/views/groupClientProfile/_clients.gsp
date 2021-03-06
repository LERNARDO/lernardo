<g:if test="${clients}">
  <p><g:message code="total"/>: ${clients.size()}</p>
  <ul>
  <g:each in="${clients}" var="client">
    <li>
      <g:link controller="${client.type.supertype.name + 'Profile'}" action="show" id="${client.id}">${client.profile}</g:link>
       &nbsp;
      <erp:accessCheck types="['Betreiber']" creatorof="${group}"><g:remoteLink controller="groupClientProfile" action="removeClient" update="clients2" id="${group.id}" params="[client: client.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="clients.notAssigned"/></span>
</g:else>