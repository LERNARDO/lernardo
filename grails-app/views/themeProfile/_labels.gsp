<g:if test="${theme.profile.labels}">
  <g:each in="${theme.profile.labels}" var="label">
    %{--<ul style="padding-bottom: 5px; margin-bottom: 5px; border-bottom: 1px dashed #ccc">
      <li><span class="bold">${label.name}</span> <erp:accessCheck types="['Betreiber','Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><g:remoteLink action="removeLabel" update="labels2" id="${template.id}" params="[label: label.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </ul>--}%
    <span class="tag">
      <span class="tail"></span>
      <span class="hole"></span>
      ${label.name} <erp:accessCheck types="['Betreiber','Pädagoge']" creatorof="${theme}" checkoperator="true"><g:remoteLink action="removeLabel" update="labels2" id="${theme.id}" params="[label: label.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false">(entfernen)</g:remoteLink></erp:accessCheck>
    </span>
  </g:each>
  <div class="clear"></div>
</g:if>
<g:else>
  <span class="italic red"><g:message code="labels.empty"/></span>
</g:else>