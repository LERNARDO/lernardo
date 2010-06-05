<g:if test="${partner.profile.contacts}">
  <ul>
  <g:each in="${partner.profile.contacts}" var="contact">
    <li>Name: ${contact.firstName + ' ' + contact.lastName} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeContact" update="contacts2" id="${partner.id}" params="[contact: contact.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ansprechperson entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    <li>Land: ${contact.country}</li>
    <li>PLZ: ${contact.zip}</li>
    <li>Stadt: ${contact.city}</li>
    <li>Straße: ${contact.street}</li>
    <li>Telefon: ${contact.phone}</li>
    <li>E-Mail: ${contact.email}</li>
    <li>Funktion: ${contact.function}</li>
    <hr />
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Ansprechpersonen eingetragen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>