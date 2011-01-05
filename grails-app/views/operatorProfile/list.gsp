<head>
  <meta name="layout" content="private"/>
  <title><g:message code="operator"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="operator"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${operatorTotal} <g:message code="operator.profile.c_total"/>
    </div>

    <erp:isAdmin>
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="operator.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isAdmin>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'operator.profile.name')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${operatorList}" status="i" var="operator">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${operator.id}" params="[entity: operator.id]">${fieldValue(bean: operator, field: 'profile.fullName').decodeHTML()}</g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${operatorTotal}"/>
    </div>

  </div>
</div>
</body>