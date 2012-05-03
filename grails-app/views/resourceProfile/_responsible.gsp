<g:if test="${resresponsible}">
  <ul>
    <g:each in="${resresponsible}" var="responsible">
      <li><g:link controller="${responsible.type.supertype.name + 'Profile'}" action="show" id="${responsible.id}">${responsible.profile.fullName}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${resourceInstance}"><g:remoteLink action="removeResponsible" update="responsible2" id="${resourceInstance.id}" params="[responsible: responsible.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="responsible.notAssigned"/></span>
</g:else>
