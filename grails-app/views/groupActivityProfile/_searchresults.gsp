<div class="info-msg">
  <g:message code="object.found" args="[groups.size(), message(code: 'groupActivities')]"/>
</div>

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
        <td><g:link action="show" id="${group.id}">${fieldValue(bean: group, field: 'profile').decodeHTML()}</g:link></td>
        <td><g:formatDate date="${group.profile.date}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        <td><erp:createdBy entity="${group}">${creator?.profile?.decodeHTML()}</erp:createdBy></td>
      </tr>
    </g:each>
    </tbody>
  </table>
</g:if>