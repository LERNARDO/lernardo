<g:if test="${group.profile.labels}">
  <g:each in="${group.profile.labels}" var="label">
    <ul style="padding-bottom: 5px; margin-bottom: 5px; border-bottom: 1px dashed #ccc">
      <li><span class="bold">${label.name}</span> <erp:accessCheck entity="${entity}" types="['Betreiber','Pädagoge']" creatorof="${group}" checkstatus="${group}"><g:remoteLink action="removeLabel" update="labels2" id="${group.id}" params="[label: label.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </ul>
  </g:each> 
</g:if>
<g:else>
  <span class="italic red"><g:message code="labels.empty"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>