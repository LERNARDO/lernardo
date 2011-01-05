<head>
  <meta name="layout" content="private"/>
  <title><g:message code="children"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="children"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${childTotal} <g:message code="child.profile.c_total"/>
    </div>

    <erp:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="child.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isOperator>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'child.profile.name')}"/>
        <g:sortableColumn property="birthDate" title="${message(code:'child.profile.birthDate')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${childList}" status="i" var="child">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${child.id}" params="[entity: child.id]">${fieldValue(bean: child, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${childTotal}"/>
    </div>

  </div>
</div>
</body>