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
  <g:each in="${partners}" status="j" var="partner">
    <h1><g:message code="partner"/> "${partner.profile}"</h1>
    <h2><g:message code="data"/></h2>
    <table>

        <tr class="prop">
            <td class="one"><g:message code="description"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.description') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="partner.profile.website"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.website') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="phone"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.phone') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="partner.profile.services"/>:</td>
            <td class="two">
                <g:if test="${partner.profile.services}">
                    <ul>
                        <g:each in="${partner.profile.services}" var="service">
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
            <td class="one"><g:message code="zip"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.zip') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="street"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="city"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.city') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="country"/>:</td>
            <td class="two">${fieldValue(bean: partner, field: 'profile.country') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

    </table>

    <h2><g:message code="partner.profile.contacts"/></h2>

    <table style="width: 100%">
        <thead>
        <tr>
          <th><g:message code="name"/></th>
          <th><g:message code="zip"/></th>
          <th><g:message code="city"/></th>
          <th><g:message code="street"/></th>
          <th><g:message code="phone"/></th>
          <th><g:message code="email"/></th>
          <th><g:message code="representatives.function"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${partner.profile.contacts}" status="i" var="representative">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td valign="top">${representative.firstName}  ${representative.lastName}</td>
            <td valign="top">${representative.zip}</td>
            <td valign="top">${representative.city}</td>
            <td valign="top">${representative.street}</td>
            <td valign="top">${representative.phone}</td>
            <td valign="top">${representative.email}</td>
            <td valign="top">${representative.function}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <g:if test="${j + 1 != partners.size()}">
        <div style="page-break-after: always"></div>
      </g:if>

  </g:each>

  </body>
</html>
