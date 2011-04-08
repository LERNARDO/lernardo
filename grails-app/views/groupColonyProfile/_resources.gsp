<g:if test="${resources}">
  <ul>
  <g:each in="${resources}" var="resource">
    <li><g:link controller="${resource.type.supertype.name +'Profile'}" action="show" id="${resource.id}" params="[entity:resource.id]">${resource.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN']" types="['Betreiber']"><g:remoteLink action="removeResource" update="resources2" id="${group.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ressource entfernen" align="top"/></g:remoteLink></erp:accessCheck></li>
    <li><g:message code="description"/>: ${resource.profile.description}</li>
    <li><g:message code="class"/>: <g:message code="resourceclass.${resource.profile.classification}"/></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.empty"/></span>
</g:else>