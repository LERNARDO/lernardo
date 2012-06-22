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
    <td class="one"><g:message code="groupFamily.profile.socioeconomicData"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.socioeconomicData').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="groupFamily.profile.otherInfo"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.otherInfo').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
  </tr>

  %{--gemeinde--}%

</table>

