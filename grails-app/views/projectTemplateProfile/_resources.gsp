<g:if test="${group.profile.resources}">
  <g:each in="${group.profile.resources}" var="resource">
    <div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
      <ul>
        <li><span class="bold"><g:message code="name"/>:</span> ${resource.name} <erp:accessCheck entity="${entity}" types="['Betreiber', 'Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true"><g:remoteLink action="removeResource" update="resources2" id="${group.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
        <li><g:message code="description"/>: ${resource.description}</li>
        <li><g:message code="resource.profile.amount"/>: ${resource.amount}</li>
      </ul>
    </div>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.empty"/></span>
</g:else>