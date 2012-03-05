<g:formRemote name="myForm" url="[action:'updateRepresentative', id:group.id, params:[representative: representative.id]]" update="representatives2">
  <div><g:textField size="30" name="firstName" value="${representative.firstName}" placeholder="${message(code: 'firstName')}"/></div>
  <div><g:textField size="30" name="lastName" value="${representative.lastName}" placeholder="${message(code: 'lastName')}"/></div>
  <div><g:textField size="5" name="zip" value="${representative.zip}" placeholder="${message(code: 'zip')}"/></div>
  <div><g:textField size="30" name="city" value="${representative.city}" placeholder="${message(code: 'city')}"/></div>
  <div><g:textField size="30" name="street" value="${representative.street}" placeholder="${message(code: 'street')}"/></div>
  <div><g:textField size="30" name="country" value="${representative.country}" placeholder="${message(code: 'country')}"/></div>
  <div><g:textField size="30" name="phone" value="${representative.phone}" placeholder="${message(code: 'phone')}"/></div>
  <div><g:textField size="30" name="email" value="${representative.email}" placeholder="${message(code: 'email')}"/></div>
  <div><g:textField size="30" name="function" value="${representative.function}" placeholder="${message(code: 'contact.function')}"/></div>
  <erp:accessCheck types="['Betreiber']"><g:submitButton name="button" value="${message(code:'change')}"/></erp:accessCheck>
  <div class="clear"></div>
</g:formRemote>
