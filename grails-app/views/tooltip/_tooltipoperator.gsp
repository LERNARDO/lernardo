<table>
  <tr class="prop">
    <td class="one"><g:message code="type"/>:</td>
    <td class="two"><g:message code="${entity.type.supertype.name}"/></td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="name"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.fullName').decodeHTML()}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="zip"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.zip') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>

  <tr class="prop">
    <td class="one"><g:message code="city"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.city') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>

  <tr class="prop">
    <td class="one"><g:message code="street"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.street') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>
</table>

