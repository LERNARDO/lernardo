<g:if test="${clients}">
  <ul>
  <g:each in="${clients}" var="client" status="i">
    <li>
      <g:link controller="${client.type.supertype.name + 'Profile'}" action="show" id="${client.id}">${client.profile.fullName.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeClient" update="clients2" id="${project.id}" params="[client: client.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
      <span id="tagclient${i}">
        <erp:getLocalTags entity="${client}" target="${project}">
          <g:render template="/app/localtags" model="[entity: client, target: project, tags: tags, update: 'tagclient' + i]"/>
        </erp:getLocalTags>
      </span>
      %{--<span style="font-size: 10px">| <g:link controller="evaluation" action="create" id="${client.id}" params="[target: project.id]"><g:message code="evaluation.create"/></g:link></span>--}%
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="clients.choose"/></span>
</g:else>