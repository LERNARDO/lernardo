<g:if test="${group.profile.resources}">
  <g:each in="${group.profile.resources}" var="resource">
    <div style="margin-bottom: 5px;">
      <ul style="padding-bottom: 5px">
        <li><g:message code="name"/>: ${resource.name} <erp:accessCheck entity="${entity}" types="['Betreiber', 'Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true"><g:remoteLink action="removeResource" update="resources2" id="${group.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
        <li><g:message code="description"/>: ${resource.description}</li>
      </ul>
    </div>
  </g:each>

</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.empty"/></span>
</g:else>