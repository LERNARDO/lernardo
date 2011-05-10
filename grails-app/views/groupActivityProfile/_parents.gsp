<g:if test="${parents}">
  <ul>
  <g:each in="${parents}" var="parent" status="i">
    <li>
      <g:link controller="${parent.type.supertype.name +'Profile'}" action="show" id="${parent.id}" params="[parent:parent.id]">${parent.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${group}"><g:remoteLink action="removeParent" update="parents2" id="${group.id}" params="[parent: parent.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
      <span id="tagparent${i}">
        <erp:getLocalTags entity="${parent}" target="${group}">
          <g:render template="/app/localtags" model="[entity: parent, target: group, tags: tags, update: 'tagparent' + i, currentEntity: entity]"/>
        </erp:getLocalTags>
      </span>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="parents.notAssigned"/></span>
</g:else>