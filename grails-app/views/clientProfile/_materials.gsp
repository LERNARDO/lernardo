<g:if test="${client.profile.materials}">
  <ul>
  <g:each in="${client.profile.materials}" var="material">
    %{--
    <li><span class="bold"><g:formatDate date="${material.date}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> - </span> ${material.text} <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeMaterial" update="materials2" id="${client.id}" params="[material: material.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    --}%
    <li><span class="bold"><g:formatDate date="${material.date}" format="dd. MM. yyyy" /> - </span> ${material.text} <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeMaterial" update="materials2" id="${client.id}" params="[material: material.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="client.profile.materials.empty"/></span>
</g:else>