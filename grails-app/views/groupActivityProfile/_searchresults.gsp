<g:if test="${groups}">
  <table class="default-table">
    <thead>
    <tr>
      <th><g:message code="name"/></th>
      <th><g:message code="date"/></th>
      <th><g:message code="creator"/></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${groups}" status="i" var="group">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
        <td><g:formatDate date="${group.profile.date}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        <td><erp:createdBy entity="${group}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></td>
      </tr>
    </g:each>
    </tbody>
  </table>
</g:if>