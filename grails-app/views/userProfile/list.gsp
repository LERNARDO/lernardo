<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | User</title>
</head>
<body>
<div class="headerBlue">
  <h1>User</h1>
</div>
<div class="boxGray">
  <div class="body">
    <p>${userTotal} User insgesamt vorhanden</p>
    <g:if test="${userTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'userProfile.lastName.label', default:'Nachname')}"/>
            <g:sortableColumn property="firstName" title="${message(code:'userProfile.firstName.label', default:'Vorname')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${userList}" status="i" var="user">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${user.id}">${fieldValue(bean: user, field: 'profile.lastName')}</g:link></td>
              <td>${fieldValue(bean: user, field: 'profile.firstName')}</td>
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

    <g:link class="buttonBlue" action="create">Neuen User anlegen</g:link>
    <div class="spacer"></div>
  </div>
</div>
</body>