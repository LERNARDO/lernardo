<g:if test="${client.profile.status}">
  <ul>
  <g:each in="${client.profile.status}" var="material">
    <g:if test="${material.type == 'material'}">
      <li><g:formatDate date="${material.date}" format="dd. MM. yyyy"/> ${material.text} <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><g:remoteLink action="removeMaterial" update="materials2" id="${client.id}" params="[material: material.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Material entfernen" align="top"/></g:remoteLink></app:hasRoleOrType></li>
    </g:if>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Materialien erhalten</span>
</g:else>