<g:formRemote name="myForm" url="[action:'updateRepresentative', id:group.id, params:[representative: representative.id]]" update="representatives2">
  <table>
    <tr class="prop">
      <td valign="top" class="italic" width="100"><g:message code="representantives.name"/>:</td>
      <td colspan="6" class="value"><g:textField size="20" name="firstName" value="${representative.firstName}"/> <g:textField size="20" name="lastName" value="${representative.lastName}"/></td>
      <td><app:isOperator entity="${entity}"><g:submitButton name="button" value="${message(code:'change')}"/></app:isOperator></td></tr>
    <tr class="prop">
      <td valign="top" class="italic"><g:message code="representantives.adr"/>:</td>
      <td colspan="6" class="value"><g:textField size="5" name="zip" value="${representative.zip}"/> <g:textField size="15" name="city" value="${representative.city}"/>, <g:textField size="20" name="street" value="${representative.street}"/>, <g:textField size="15" name="country" value="${representative.country}"/></td></tr>
    <tr class="prop">
      <td valign="top" class="italic"><g:message code="representantives.phone"/>:</td>
      <td class="value" width="150"><g:textField size="10" name="phone" value="${representative.phone}"/></td>
      <td valign="top" class="italic" width="60"><g:message code="representantives.email"/>:</td>
      <td class="value" width="160"><g:textField size="15" name="email" value="${representative.email}"/></td>
      <td valign="top" class="italic" width="100"><g:message code="representantives.function"/>:</td>
      <td class="value"><g:textField size="30" name="function" value="${representative.function}"/></td>
    </tr>
  </table>
</g:formRemote>
