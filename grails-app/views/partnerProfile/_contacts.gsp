<g:if test="${partner.profile.contacts}">
  <ul>
  <g:each in="${partner.profile.contacts}" var="contact">
    <li><g:message code="partner.profile.contactName"/>: ${contact.firstName + ' ' + contact.lastName} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeContact" update="contacts2" id="${partner.id}" params="[contact: contact.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ansprechperson entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    <li><g:message code="partner.profile.contactCountry"/>: ${contact.country}</li>
    <li><g:message code="partner.profile.contactZip"/>: ${contact.zip}</li>
    <li><g:message code="partner.profile.contactCity"/>: ${contact.city}</li>
    <li><g:message code="partner.profile.contactStreet"/>: ${contact.street}</li>
    <li><g:message code="partner.profile.contactPhone"/>: ${contact.phone}</li>
    <li><g:message code="partner.profile.contactEmail"/>: ${contact.email}</li>
    <li><g:message code="partner.profile.contactFunction"/>: ${contact.function}</li>
    <hr />
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="partner.profile.contact.empty"/> <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>