<g:if test="${template.profile.methods}">
  <g:each in="${template.profile.methods}" var="method">
    <ul style="padding-bottom: 5px; margin-bottom: 5px; border-bottom: 1px dashed #ccc">
      <li><span class="bold">${method.name}</span> <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']" me="false"><g:remoteLink action="removeMethod" update="methods2" id="${template.id}" params="[method: method.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Bewertungsmethode entfernen" align="top"/></g:remoteLink></app:hasRoleOrType></li>
      %{--<li>${method.description}</li>--}%
      <g:each in="${method.elements}" var="element">
        <li>${element.name} <div id="starBox${element.id}" class="starbox"><app:starBox element="${element.id}"/></div></li>
    </g:each>
    </ul>
  </g:each> 
</g:if>
<g:else>
  <span class="italic">Keine Bewertungsmethoden eingetragen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>