<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="educator.profile.workHours"/></title>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="workdayUnit" action="evaluation"><g:message code="timeEvaluation"/></g:link></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="workdayCategory" action="index"><g:message code="privat.workdaycategories"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="educator.profile.workHours"/></h1>
  </div>
</div>

<div class="clear"></div>

<div class="boxGray">
  <div class="second">

    <table class="default-table">
      <thead>
      <tr>
        <th><g:message code="name"/></th>
        <th><g:message code="hours"/></th>
        %{--<th>Arbeitstage pro Woche</th>--}%
        <th><g:message code="educator.profile.hourlyWage"/> (${grailsApplication.config.currency})</th>
        <th><g:message code="educator.profile.overtimePay"/> (${grailsApplication.config.currency})</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${persons}" status="i" var="person">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>
            <erp:profileImage entity="${person}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${person.id}" params="[entity: person.id]">${fieldValue(bean: person, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td id="${i}a"><g:render template="showworkhours" model="[person: person, i: i]"/></td>
          %{--<td id="${i}b"><g:render template="showworkdays" model="[educator: educator, i: i]"/></td>--}%
          <td id="${i}c"><g:render template="showhourlywage" model="[person: person, i: i]"/></td>
          <td id="${i}d"><g:render template="showovertimepay" model="[person: person, i: i]"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

  </div>
</div>
</body>