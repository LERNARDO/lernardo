<g:each in="${educators}" var="subeducators">
  <p><g:message code="educators"/> ${subeducators?.value[0]?.profile?.employment?.decodeHTML()}</p>
  <table class="default-table" style="margin-bottom: 10px;">
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
      <g:each in="${subeducators.value}" status="i" var="person">
        <erp:showHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><g:link controller="${person.type.supertype.name + 'Profile'}" action="show" id="${person.id}" params="[entity: person.id]">${fieldValue(bean: person, field: 'profile.firstName').decodeHTML()} ${fieldValue(bean: person, field: 'profile.lastName').decodeHTML()}</g:link></td>
            <g:each in="${workdaycategories}" var="category">
              <td><erp:getHoursForCategory category="${category}" educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
            </g:each>
            <td><erp:getTotalHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
            <td><erp:getExpectedHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
            <td><erp:getHoursConfirmed educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
            <td><erp:getSalary educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          </tr>
        </erp:showHours>
      </g:each>
    </tbody>
  </table>
</g:each>

<p><g:message code="users"/></p>
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
  <g:each in="${users}" status="i" var="person">
    <erp:showHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td><g:link controller="${person.type.supertype.name + 'Profile'}" action="show" id="${person.id}" params="[entity: person.id]">${fieldValue(bean: person, field: 'profile.firstName').decodeHTML()} ${fieldValue(bean: person, field: 'profile.lastName').decodeHTML()}</g:link></td>
        <g:each in="${workdaycategories}" var="category">
          <td><erp:getHoursForCategory category="${category}" educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        </g:each>
        <td><erp:getTotalHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        <td><erp:getExpectedHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        <td><erp:getHoursConfirmed educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        <td><erp:getSalary educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
      </tr>
    </erp:showHours>
  </g:each>
  </tbody>
</table>

<br/>
<g:link action="pdf" params="[date1: date1, date2: date2]"><img src="${g.resource(dir: 'images/icons', file: 'icon_pdf.png')}" alt="PDF" align="top"/> PDF</g:link>