<g:if test="${substitutes}">
  <ul>
  <g:each in="${substitutes}" var="substitute" status="i">
    <li>
      <g:link controller="${substitute.type.supertype.name +'Profile'}" action="show" id="${substitute.id}">${substitute.profile.fullName.decodeHTML()}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${group}"><g:remoteLink action="removeSubstitute" update="substitutes2" id="${group.id}" params="[substitute: substitute.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
      <span id="tagsubstitute${i}">
        <erp:getLocalTags entity="${substitute}" target="${group}">
          <g:render template="/app/localtags" model="[entity: substitute, target: group, tags: tags, update: 'tagsubstitute' + i, currentEntity: entity]"/>
        </erp:getLocalTags>
      </span>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="substitutes.notAssigned"/></span>
</g:else>