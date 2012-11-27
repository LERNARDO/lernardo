<g:if test="${resowner}">
  <ul>
    <g:each in="${resowner}" var="sowner">
      <li><g:link controller="${sowner.type.supertype.name + 'Profile'}" action="show" id="${sowner.id}">${sowner.profile}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${resourceInstance}"><g:remoteLink action="removeOwner" update="owner2" id="${resourceInstance.id}" params="[owner: sowner.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="owner.notAssigned"/></span>
</g:else>
