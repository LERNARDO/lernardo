<g:if test="${methodInstance.elements}">
  <ul>
  <g:each in="${methodInstance.elements}" var="element">
    <li>${element.name} <app:isOperator entity="${entity}"><g:remoteLink action="removeElement" update="elements2" id="${methodInstance.id}" params="[element: element.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Element entfernen" align="top"/></g:remoteLink></app:isOperator></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Elemente eingetragen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>