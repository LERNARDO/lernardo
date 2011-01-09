<head>
  <meta name="layout" content="private"/>
  <title><g:message code="facilities"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="facilities"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${facilities.totalCount} <g:message code="facility.profile.c_total"/>
    </div>

    <erp:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="facility.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isOperator>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'facility.profile.name')}"/>
        <th>${message(code: 'facility.profile.street')}</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${facilities}" status="i" var="facility">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${facility.id}" params="[entity: facility.id]">${fieldValue(bean: facility, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>${fieldValue(bean: facility, field: 'profile.street') ?: '<div class="italic">---</div>'}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${facilities.totalCount}"/>
    </div>

  </div>
</div>
</body>