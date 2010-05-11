<g:if test="${methodInstance.elements}">
  <ul>
  <g:each in="${methodInstance.elements}" var="element">
    <li>${element.name} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeElement" update="elements2" id="${methodInstance.id}" params="[element: element]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Element entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Elemente eingetragen</span>
</g:else>