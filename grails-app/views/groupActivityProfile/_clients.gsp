<g:if test="${clients}">
  <ul>
  <g:each in="${clients}" var="client" status="i">
    <li>
      <g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}" params="[entity:client.id]">${client.profile.fullName}</g:link> <app:isCreator entity="${group}"><g:remoteLink action="removeClient" update="clients2" id="${group.id}" params="[client: client.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Betreuten entfernen" align="top"/></g:remoteLink></app:isCreator>
      %{--<span id="tagclient${i}">
        <app:getTags entity="${client}">
          <g:render template="/app/tags" model="[entity: client, tags: tags, update: 'tagclient'+ i]"/>
        </app:getTags>
      </span>--}%
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Keine Betreuten zugewiesen! %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>