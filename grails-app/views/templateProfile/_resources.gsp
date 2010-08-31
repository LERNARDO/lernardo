<g:if test="${resources}">
  <g:each in="${resources}" var="resource">
    <div style="border-bottom: 1px solid #eee; margin-bottom: 5px;">
      <ul style="padding-bottom: 5px">
        <li><g:message code="resource.profile.name"/>: <g:link controller="${resource.type.supertype.name +'Profile'}" action="show" id="${resource.id}" params="[entity:entity.id]">${resource.profile.fullName}</g:link> <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']" me="false"><g:remoteLink action="removeResource" update="resources2" id="${template.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ressource entfernen" align="top"/></g:remoteLink></app:hasRoleOrType></li>
        <li><g:message code="resource.profile.description"/>: ${resource.profile.description}</li>
      </ul>
    </div>
  </g:each>

</g:if>
<g:else>
  <span class="italic"><g:message code="resource.profile.empty"/> <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>