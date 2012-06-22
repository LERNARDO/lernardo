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
    <td class="one"><g:message code="begin"/></td>
    <td class="two"><g:formatDate date="${entity.profile.startDate}" format="dd. MM. yyyy" /></td>
  </tr>

  <tr class="prop">
    <td class="one"><g:message code="end"/></td>
    <td class="two"><g:formatDate date="${entity.profile.endDate}" format="dd. MM. yyyy" /></td>
  </tr>

  %{--einrichtung--}%

  %{--pädagogen--}%

  %{--betreute anzahl--}%

  %{--projekttage (MO, DI..)--}%

  %{--projekttage anzahl--}%

</table>

