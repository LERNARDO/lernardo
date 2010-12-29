<g:if test="${clients}">
  <ul>
  <g:each in="${clients}" var="client" status="i">
    <li>
      <g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}" params="[entity:client.id]">${client.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeClient" update="clients2" id="${project.id}" params="[client: client.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Betreuten entfernen" align="top"/></g:remoteLink></erp:accessCheck>
      <span id="tagclient${i}">
        <erp:getLocalTags entity="${client}" target="${project}">
          <g:render template="/app/localtags" model="[entity: client, target: project, tags: tags, update: 'tagclient' + i]"/>
        </erp:getLocalTags>
      </span>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Bitte die Betreuten auswählen, die an diesem Projekt teilnehmen!%{--Keine Betreuten zugewiesen--}% %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>