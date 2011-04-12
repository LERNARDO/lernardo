<g:if test="${methodInstance.elements}">
  <ul>
  <g:each in="${methodInstance.elements}" var="element">
    <li>${element.name} <erp:accessCheck entity="${entity}" types="['Betreiber']"><g:remoteLink action="removeElement" update="elements2" id="${methodInstance.id}" params="[element: element.id]" before="if(!confirm('${message(code:'delete.warn')}') return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Element entfernen" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="elements.notAssigned"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>