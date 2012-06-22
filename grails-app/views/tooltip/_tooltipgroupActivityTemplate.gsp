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
    <td class="one"><g:message code="groupActivityTemplate.profile.realDuration"/></td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.realDuration')} min</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
    <td class="two">${entity?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="activityTemplate.ageTo"/></td>
    <td class="two">${entity?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>

  %{--anzahl aktivitäten--}%

  %{--labels--}%

</table>

