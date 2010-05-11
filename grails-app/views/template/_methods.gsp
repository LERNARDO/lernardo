<g:if test="${template.profile.methods}">
  <ul>
  <g:each in="${template.profile.methods}" var="method">
    <li>${method.name} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeMethod" update="methods2" id="${template.id}" params="[method: method.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Bewertungsmethode entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    <li>${method.description}</li>
    <g:each in="${method.elements}" var="element">
      <li>${element.name} <div id="starBox${element.id}" class="starbox"><app:starBox element="${element.id}"/></div></li>  
    </g:each>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Bewertungsmethoden eingetragen</span>
</g:else>