<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title><g:message code="timeEvaluation"/></title>
  <style>
  @page {
    <erp:setPageFormat format="${pageformat}"/>
  }

  body {
    font-size: 12px;
  }

  table {
    border-collapse: collapse;
  }

  th {
    background: #cc5;
    padding: 2px;
    border: 1px solid #aa3;
  }

  td {
    background: #eee;
    padding: 2px;
    border: 1px solid #999;
  }

  h1 {
    font-size: 11px;
    color: #aaa;
    font-weight: normal;
    text-align: right;
  }

  h2 {
    color: #44f;
    border-bottom: 1px solid #66f;
  }

  .bold {
    font-weight: bold;
  }

  .unit {
    border: 1px solid #ccc;
    padding: 5px;
    margin-bottom: 5px;
  }

  .gray {
    color: #aaa;
  }
  </style>
</head>

<body>
<h1><g:message code="educator.timeschedule.export.period" args="[date1, date2]"/><br/><g:message code="educator.timeschedule.export.from" args="[entity.profile.fullName]"/> <g:formatDate
    date="${new Date()}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message code="atTime"/> <g:formatDate date="${new Date()}"
                                                                                                                                                                           format="HH:mm"
                                                                                                                                                                           timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message
    code="clock"/></h1>

<h2><g:message code="profile.overview"/></h2>
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
          <td>${fieldValue(bean: person, field: 'profile.fullName').decodeHTML()}</td>
          <g:each in="${workdaycategories}" var="category">
            <td><erp:getHoursForCategory category="${category}" educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          </g:each>
          <td><erp:getTotalHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getExpectedHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getSalary educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getHoursConfirmed educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        </tr>
      </erp:showHours>
    </g:each>
    </tbody>
  </table>
</g:each>

<g:each in="${educators}" var="subeducators">
  <g:each in="${subeducators.value}" status="i" var="person">
    <erp:showHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}">
      <h1 style="page-break-before: always"><g:message code="educator.timeschedule.export.period" args="[date1, date2]"/></h1>
      <h2><g:message code="detailed.info"/></h2>
      <h3>${person.profile.fullName}</h3>
      <erp:getWorkdayUnits educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/>
    </erp:showHours>
  </g:each>
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
        <td><g:link controller="${person.type.supertype.name + 'Profile'}" action="show" id="${person.id}"
                    params="[entity: person.id]">${fieldValue(bean: person, field: 'profile.firstName').decodeHTML()} ${fieldValue(bean: person, field: 'profile.lastName').decodeHTML()}</g:link></td>
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

<g:each in="${users}" status="i" var="person">
  <erp:showHours educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}">
    <h1 style="page-break-before: always"><g:message code="educator.timeschedule.export.period" args="[date1, date2]"/></h1>

    <h2><g:message code="detailed.info"/></h2>

    <h3>${person.profile.fullName}</h3>
    <erp:getWorkdayUnits educator="${person}" date1="${date1 ?: null}" date2="${date2 ?: null}"/>
  </erp:showHours>
</g:each>

</body>
</html>
