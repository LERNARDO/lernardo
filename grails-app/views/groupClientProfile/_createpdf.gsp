<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><g:message code="groupClient"/></title>
    <style>
      @page {
        <erp:setPageFormat format="${pageformat}"/>
      }
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
    <h1><g:message code="groupClient"/> "${group.profile}"</h1>
    <p class="gray"><g:message code="createdBy" args="[entity.profile, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>
    <h2><g:message code="data"/></h2>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="name"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
      </tr>

    </table>

    <h2><g:message code="clients"/></h2>
    <table style="width: 100%">
        <thead>
        <tr>
          <th><g:message code="name"/></th>
          <th><g:message code="birthDate"/></th>
          <th><g:message code="street"/></th>
          <th><g:message code="groupColony"/></th>
          <th><g:message code="parents"/> &amp; <g:message code="phone"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${clients}" status="i" var="client">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td valign="top">${fieldValue(bean: client, field: 'profile').decodeHTML()}</td>
            <td valign="top"><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy" /></td>
            <td valign="top">${fieldValue(bean: client, field: 'profile.currentStreet').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
            <td valign="top"><erp:getColony entity="${client}">${fieldValue(bean: colony, field: 'profile').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</erp:getColony></td>
            <td valign="top">
              <erp:getParentsOfClient client="${client}">
                <g:each in="${parents}" var="parent">
                  ${parent.profile}: ${parent.profile.phone}<br/>
                </g:each>
              </erp:getParentsOfClient>
              </td>
          </tr>
        </g:each>
        </tbody>
      </table>

  </body>
</html>
