<g:if test="${group.profile.buildings}">
  <ul>
  <g:each in="${group.profile.buildings}" var="building">
    <li>Name: ${building.name} <app:isOperator entity="${entity}"><g:remoteLink action="removeBuilding" update="buildings2" id="${group.id}" params="[building: building.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Gebäude entfernen" align="top"/></g:remoteLink></app:isOperator></li>
    <li>PLZ: ${building.zip}</li>
    <li>Stadt: ${building.city}</li>
    <li>Straße: ${building.street}</li>
    <li>Telefon: ${building.phone}</li>
    <li>E-Mail: ${building.email}</li>
    <li>Telefon: ${building.authority}</li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Gebäude eingetragen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>