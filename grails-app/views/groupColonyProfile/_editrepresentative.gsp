<g:formRemote name="myForm" url="[action:'updateRepresentative', id:group.id, params:[representative: representative.id]]" update="representatives2">
  <div><g:textField size="30" name="firstName" value="${representative.firstName}" placeholder="${message(code: 'contact.firstName')}"/></div>
  <div><g:textField size="30" name="lastName" value="${representative.lastName}" placeholder="${message(code: 'contact.lastName')}"/></div>
  <div><g:textField size="5" name="zip" value="${representative.zip}" placeholder="${message(code: 'contact.zip')}"/></div>
  <div><g:textField size="30" name="city" value="${representative.city}" placeholder="${message(code: 'contact.city')}"/></div>
  <div><g:textField size="30" name="street" value="${representative.street}" placeholder="${message(code: 'contact.street')}"/></div>
  <div><g:textField size="30" name="country" value="${representative.country}" placeholder="${message(code: 'contact.country')}"/></div>
  <div><g:textField size="30" name="phone" value="${representative.phone}" placeholder="${message(code: 'contact.phone')}"/></div>
  <div><g:textField size="30" name="email" value="${representative.email}" placeholder="${message(code: 'contact.email')}"/></div>
  <div><g:textField size="30" name="function" value="${representative.function}" placeholder="${message(code: 'contact.function')}"/></div>
  <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN']" types="['Betreiber']"><g:submitButton name="button" value="${message(code:'change')}"/></erp:accessCheck>
  <div class="clear"></div>
</g:formRemote>
