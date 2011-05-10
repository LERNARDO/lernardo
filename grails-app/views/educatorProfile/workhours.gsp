<head>
  <meta name="layout" content="private"/>
  <title><g:message code="educator.profile.workHours"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="educator.profile.workHours"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <table class="default-table">
      <thead>
      <tr>
        <th><g:message code="name"/></th>
        <th>Stunden</th>
        %{--<th>Arbeitstage pro Woche</th>--}%
        <th><g:message code="educator.profile.hourlyWage"/> (${grailsApplication.config.currency})</th>
        <th><g:message code="educator.profile.overtimePay"/> (${grailsApplication.config.currency})</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${educators}" status="i" var="educator">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${educator.id}" params="[entity: educator.id]">${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td id="${i}a"><g:render template="showworkhours" model="[educator: educator, i: i]"/></td>
          %{--<td id="${i}b"><g:render template="showworkdays" model="[educator: educator, i: i]"/></td>--}%
          <td id="${i}c"><g:render template="showhourlywage" model="[educator: educator, i: i]"/></td>
          <td id="${i}d"><g:render template="showovertimepay" model="[educator: educator, i: i]"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

  </div>
</div>
</body>