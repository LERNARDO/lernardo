<g:if test="${group.profile.representatives}">
  <ul>
  <g:each in="${group.profile.representatives}" var="representative">
    <li>Name: ${representative.firstName} ${representative.lastName} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeRepresentative" update="representatives2" id="${group.id}" params="[representative: representative.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Repräsentant entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    <li>Land: ${representative.country}</li>
    <li>PLZ: ${representative.zip}</li>
    <li>Stadt: ${representative.city}</li>
    <li>Straße: ${representative.street}</li>
    <li>Telefon: ${representative.phone}</li>
    <li>E-Mail: ${representative.email}</li>
    <li>Funktion: ${representative.function}</li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Repräsentanten eingetragen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>