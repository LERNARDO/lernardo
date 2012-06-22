<table>
  <tr class="prop">
    <td class="one"><g:message code="type"/>:</td>
    <td class="two"><g:message code="${entity.type.supertype.name}"/></td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="name"/>:</td>
    <td class="two">${fieldValue(bean: entity, field: 'profile.fullName').decodeHTML()}</td>
  </tr>

  %{--vorlage--}%

  <tr class="prop">
    <td class="one"><g:message code="date"/>:</td>
    <td class="two"><g:formatDate date="${entity?.profile?.date}" format="dd. MMMM yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
  </tr>

  %{--einrichtung--}%

  %{--pädagoginnen--}%

  %{--betreute (anzahl)--}%

</table>

