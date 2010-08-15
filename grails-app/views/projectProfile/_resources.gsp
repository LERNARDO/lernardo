<g:if test="${resources}">
  <ul>
    <g:each in="${resources}" var="resource">
      <li><g:link controller="${resource.type.supertype.name +'Profile'}" action="show" id="${resource.id}" params="[entity:resource.id]">${resource.profile.fullName}</g:link> <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeResource" update="resources2" id="${projectDay.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ressource entfernen" align="top"/></g:remoteLink></app:hasRoleOrType></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Ressourcen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>