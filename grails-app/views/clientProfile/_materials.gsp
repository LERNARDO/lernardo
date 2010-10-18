<g:if test="${client.profile.materials}">
  <ul>
  <g:each in="${client.profile.materials}" var="material">
    <li><span class="bold"><g:formatDate date="${material.date}" format="dd. MM. yyyy"/> - </span> ${material.text} <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><g:remoteLink action="removeMaterial" update="materials2" id="${client.id}" params="[material: material.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Material entfernen" align="top"/></g:remoteLink></app:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="client.profile.materials.empty"/></span>
</g:else>