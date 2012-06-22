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
    <td class="one"><g:message code="street"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.street') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="zip"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.zip') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="city"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.city') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="country"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.country') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
  </tr>

  %{--leitende Pädagogen--}%

  %{--Pädagogen--}%

</table>

