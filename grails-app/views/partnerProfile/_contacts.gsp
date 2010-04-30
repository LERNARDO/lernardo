<g:if test="${partner.profile.contacts}">
  <ul>
  <g:each in="${partner.profile.contacts}" var="contact">
    <li>${contact.firstName + ' ' + contact.lastName}<app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeContact" update="contacts2" id="${partner.id}" params="[contact: contact.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Ansprechperson entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Ansprechpersonen eingetragen</span>
</g:else>