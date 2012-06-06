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
    <td class="one"><g:message code="educator.profile.education"/>:</td>
    <td class="two">${entity.profile.education.decodeHTML() ?: '<div class="italic">' + message(code: "noData") + '</div>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="educator.profile.employment"/>:</td>
    <td class="two">${entity.profile.employment.decodeHTML() ?: '<div class="italic">' + message(code: "noData") + '</div>'}</td>
  </tr>
</table>

