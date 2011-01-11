<head>
  <meta name="layout" content="private"/>
  <title><g:message code="educators"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="educators"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${educators.totalCount} <g:message code="educator.profile.c_total"/>
    </div>

    <erp:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="educator.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isOperator>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'educator.profile.name')}"/>
        <g:sortableColumn property="education" title="${message(code:'educator.profile.education')}"/>
        <g:sortableColumn property="employment" title="${message(code:'educator.profile.employment')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${educators}" status="i" var="educator">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${educator.id}" params="[entity: educator.id]">${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><g:message code="education.${educator.profile.education}"/></td>
          <td><g:message code="employment.${educator.profile.employment}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${educators.totalCount}"/>
    </div>

  </div>
</div>
</body>