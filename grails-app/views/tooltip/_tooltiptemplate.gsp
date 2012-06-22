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
    <td class="one"><g:message code="activityTemplate.goal"/></td>
    <td class="two">${entity?.profile?.goal?.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="duration"/></td>
    <td class="two">${entity.profile.duration} <g:message code="minutes"/></td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
    <td class="two">${entity?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="activityTemplate.ageTo"/></td>
    <td class="two">${entity?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="activityTemplate.socialForm"/></td>
    <td class="two"><g:message code="socialForm.${entity.profile.socialForm}"/></td>
  </tr>

  %{--labels--}%

</table>

