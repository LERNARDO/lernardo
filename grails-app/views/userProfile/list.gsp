<head>
  <meta name="layout" content="private"/>
  <title><g:message code="user"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="user"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${users.totalCount} <g:message code="user.profile.c_total"/>
    </div>

    <div class="buttons">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'user.profile.create')}"/></div>
        <div class="spacer"></div>
      </g:form>
    </div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'user.profile.name')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${users}" status="i" var="user">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${user.id}" params="[entity: user.id]">${fieldValue(bean: user, field: 'profile.lastName').decodeHTML()} ${fieldValue(bean: user, field: 'profile.firstName').decodeHTML()}</g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${users.totalCount}"/>
    </div>

  </div>
</div>
</body>