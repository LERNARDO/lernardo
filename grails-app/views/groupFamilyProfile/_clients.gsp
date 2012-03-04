<g:if test="${clients}">
  <ul>
  <g:each in="${clients}" var="client">
    <li><g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}">${client.profile.fullName.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeClient" update="clients2" id="${group.id}" params="[client: client.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false" after="${remoteFunction(action:'updateFamilyCount',update:'familyCount',id:group.id)}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="groupFamily.profile.clients.empty"/></span>
</g:else>