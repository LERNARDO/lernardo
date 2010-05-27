<head>
  <meta name="layout" content="private"/>
  <title>User</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>User</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${userTotal} User insgesamt vorhanden</p>
    <g:if test="${userTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'user.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${userList}" status="i" var="user">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${user.id}">${fieldValue(bean: user, field: 'profile.lastName')} ${fieldValue(bean: user, field: 'profile.firstName')}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${userTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${userTotal}"/>
        </div>
      </g:if>
    </g:if>

    <div class="buttons">
      <g:link class="buttonGreen" action="create">Neuen User anlegen</g:link>
      <div class="spacer"></div>
    </div>
    
  </div>
</div>
</body>