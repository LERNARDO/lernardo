<g:if test="${resources}">
  <g:each in="${resources}" var="resource">
    <div style="border-bottom: 1px solid #eee; margin-bottom: 5px;">
      <ul style="padding-bottom: 5px">
        <li>Name: <g:link controller="${resource.type.supertype.name +'Profile'}" action="show" id="${resource.id}" params="[entity:entity.id]">${resource.profile.fullName}</g:link> <erp:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeResource" update="resources2" id="${facility.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ressource entfernen" align="top"/></g:remoteLink></erp:isMeOrAdmin></li>
        <li>Beschreibung: ${resource.profile.description}</li>
        <li>Klasse: <g:message code="resourceclass.${resource.profile.classification}"/></li>
      </ul>
    </div>
  </g:each>  
</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.empty"/></span>
</g:else>