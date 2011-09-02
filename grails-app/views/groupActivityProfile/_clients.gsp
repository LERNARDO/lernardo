<g:if test="${clients}">
  <ul>
  <g:each in="${clients}" var="client" status="i">
    <li>
      <g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}" params="[entity:client.id]">${client.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${group}"><g:remoteLink action="removeClient" update="clients2" id="${group.id}" params="[client: client.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>

      <span id="tagclient${i}">
        <erp:getLocalTags entity="${client}" target="${group}">
          <g:render template="/app/localtags" model="[entity: client, target: group, tags: tags, update: 'tagclient' + i, currentEntity: entity]"/>
        </erp:getLocalTags>
      </span>

      %{-- TODO: global tag example, unused currently but kept here for reference --}%
      %{--<span id="tagclient${i}">
        <erp:getTags entity="${client}">
          <g:render template="/app/tags" model="[entity: client, tags: tags, update: 'tagclient'+ i]"/>
        </erp:getTags>
      </span>--}%
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="clients.notAssigned"/></span>
</g:else>