<table class="default-table">
  <thead>
  <tr>
    <th><g:message code="name"/></th>
    <g:each in="${workdaycategories}" var="category">
      <th>${category.name} (h)</th>
    </g:each>
    <th><g:message code="credit.hours"/></th>
    <th><g:message code="debit.hours"/></th>
    <th><g:message code="approved"/></th>
    <th><g:message code="payout"/> (${grailsApplication.config.currency})</th>
  </tr>
  </thead>
  <tbody>
  <g:each in="${educators}" status="i" var="educator">
    <erp:showHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td><g:link action="show" id="${educator.id}" params="[entity: educator.id]">${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</g:link></td>
        <g:each in="${workdaycategories}" var="category">
          <td><erp:getHoursForCategory category="${category}" educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        </g:each>
        <td><erp:getTotalHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        <td><erp:getExpectedHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        <td><erp:getHoursConfirmed educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        <td><erp:getSalary educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
      </tr>
    </erp:showHours>
  </g:each>
  </tbody>
</table>

<br/>
<g:link action="createpdf" id="${entity.id}" params="[date1: date1, date2: date2]"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</g:link>