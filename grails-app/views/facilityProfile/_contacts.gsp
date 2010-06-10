<g:if test="${facility.profile.contacts}">
  <g:each in="${facility.profile.contacts}" var="contact">
    <div style="border-bottom: 1px solid #eee; margin-bottom: 5px;">
      <ul style="padding-bottom: 5px">
        <li>${contact.firstName + ' ' + contact.lastName} <app:isOperator entity="${entity}"><g:remoteLink action="removeContact" update="contacts2" id="${facility.id}" params="[contact: contact.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ansprechperson entfernen" align="top"/></g:remoteLink></app:isOperator></li>
        <li>Land: ${contact.country}</li>
        <li>PLZ: ${contact.zip}</li>
        <li>Stadt: ${contact.city}</li>
        <li>Straße: ${contact.street}</li>
        <li>Telefon: ${contact.phone}</li>
        <li>E-Mail: ${contact.email}</li>
        <li>Funktion: ${contact.function}</li>
      </ul>
    </div>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Ansprechpersonen eingetragen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>