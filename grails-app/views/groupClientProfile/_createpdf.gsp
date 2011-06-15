<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><g:message code="timeEvaluation"/></title>
    <style>
      body {
          font-size: 12px;
      }
      .default-table th {
        border-bottom: 1px solid #000;
      }
      h2 {
        color: #44f;
        border-bottom: 1px solid #66f;
      }
      .gray {
        color: #aaa;
      }
      .one {
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <h1><g:message code="groupClient"/> "${group.profile.fullName}"</h1>
    <p class="gray"><g:message code="createdBy" args="[entity.profile.fullName, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>
    <h2><g:message code="data"/></h2>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="groupClient.profile.name"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupClient.profile.description"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

    </table>

    <h2><g:message code="clients"/></h2>
    <table class="default-table">
        <thead>
        <tr>
          <th><g:message code="client.profile.name"/></th>
          <th><g:message code="client.profile.birthDate"/></th>
          <th><g:message code="client.profile.currentStreet"/></th>
          <th><g:message code="client.profile.currentColonia"/></th>
          <th><g:message code="client.profile.currentCountry"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${clients}" status="i" var="client">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td>${fieldValue(bean: client, field: 'profile.fullName').decodeHTML()}</td>
            <td><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy" /></td>
            <td>${fieldValue(bean: client, field: 'profile.currentStreet') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td><erp:getColony entity="${client}">${fieldValue(bean: colony, field: 'profile.fullName').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</erp:getColony></td>
            <td>${fieldValue(bean: client, field: 'profile.currentCountry') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

  </body>
</html>
