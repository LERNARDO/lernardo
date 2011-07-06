<g:if test="${resresponsible}">
  <ul>
    <g:each in="${resresponsible}" var="responsible">
      <li><g:link controller="${responsible.type.supertype.name +'Profile'}" action="show" id="${responsible.id}" params="[entity:responsible.id]">${responsible.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${resource}"><g:remoteLink action="removeResponsible" update="responsible2" id="${resource.id}" params="[responsible: responsible.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="responsible.notAssigned"/></span>
</g:else>
