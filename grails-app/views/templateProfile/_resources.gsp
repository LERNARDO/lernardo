<g:if test="${resources}">
  <g:each in="${resources}" var="resource">
    <div style="margin-bottom: 5px;">
      <ul style="padding-bottom: 5px">
        <li><g:link controller="${resource.type.supertype.name +'Profile'}" action="show" id="${resource.id}" params="[entity:entity.id]">${resource.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${template}"><g:remoteLink action="removeResource" update="resources2" id="${template.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ressource entfernen" align="top"/></g:remoteLink></erp:accessCheck></li>
        <li>${resource.profile.description}</li>
      </ul>
    </div>
  </g:each>

</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.empty"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>