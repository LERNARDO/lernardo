<g:if test="${resources}">
  <ul>
    <g:each in="${resources}" var="resource">
      <li><g:link controller="${resource.type.supertype.name +'Profile'}" action="show" id="${resource.id}" params="[entity:resource.id]">${resource.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeResource" update="resources2" id="${projectDay.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="resources.notAssigned"/></span>
</g:else>