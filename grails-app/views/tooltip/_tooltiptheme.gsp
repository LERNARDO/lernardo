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
    <td class="one"><g:message code="begin"/>:</td>
    <td class="two"><g:formatDate date="${entity.profile.startDate}" format="dd. MMMM yyyy" /></td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="end"/>:</td>
    <td class="two"><g:formatDate date="${entity.profile.endDate}" format="dd. MMMM yyyy" /></td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="description"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>

  %{--projekte--}%

  %{--aktivitätsblöcke--}%

</table>

