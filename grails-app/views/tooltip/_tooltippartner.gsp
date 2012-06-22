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
    <td class="one"><g:message code="partner.profile.services"/>:</td>
    <td class="two">
      <g:if test="${entity.profile.services}">
        <ul>
          <g:each in="${entity.profile.services}" var="service">
            <li>${service}</li>
          </g:each>
        </ul>
      </g:if>
      <g:else>
        <div class="italic"><g:message code="none"/></div>
      </g:else>
    </td>
  </tr>
  <tr class="prop">
    <td class="one"><g:message code="street"/>:</td>
    <td class="two">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
  </tr>

  %{--gemeinde--}%

</table>

