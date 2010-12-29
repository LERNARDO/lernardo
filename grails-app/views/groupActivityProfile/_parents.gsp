<g:if test="${parents}">
  <ul>
  <g:each in="${parents}" var="parent" status="i">
    <li>
      <g:link controller="${parent.type.supertype.name +'Profile'}" action="show" id="${parent.id}" params="[parent:parent.id]">${parent.profile.fullName}</g:link> <erp:isCreator entity="${group}"><g:remoteLink action="removeParent" update="parents2" id="${group.id}" params="[parent: parent.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Erziehungsberechtigten entfernen" align="top"/></g:remoteLink></erp:isCreator>
      <span id="tagparent${i}">
        <erp:getLocalTags entity="${parent}" target="${group}">
          <g:render template="/app/localtags" model="[entity: parent, target: group, tags: tags, update: 'tagparent' + i]"/>
        </erp:getLocalTags>
      </span>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="parents.notAssigned"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>