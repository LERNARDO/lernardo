<g:if test="${projectTemplate.profile.labels}">
  <g:each in="${projectTemplate.profile.labels}" var="label">
    <ul style="padding-bottom: 5px; margin-bottom: 5px; border-bottom: 1px dashed #ccc">
      <li><span class="bold">${label.name}</span> <erp:accessCheck types="['Betreiber','Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><g:remoteLink action="removeLabel" update="labels2" id="${projectTemplate.id}" params="[label: label.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </ul>
  </g:each> 
</g:if>
<g:else>
  <span class="italic red"><g:message code="labels.empty"/></span>
</g:else>