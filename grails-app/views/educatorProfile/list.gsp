<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Pädagogen</title>
</head>
<body>
<div class="headerBlue">
  <h1>Pädagogen</h1>
</div>
<div class="boxGray">
  <div class="body">
    <p>${educatorTotal} Pädagogen insgesamt vorhanden</p>
    <g:if test="${educatorTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'educatorProfile.lastName.label', default:'Nachname')}"/>
            <g:sortableColumn property="firstName" title="${message(code:'educatorProfile.firstName.label', default:'Vorname')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${educatorList}" status="i" var="educator">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${educator.id}">${fieldValue(bean: educator, field: 'profile.lastName')}</g:link></td>
              <td>${fieldValue(bean: educator, field: 'profile.firstName')}</td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${educatorTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${educatorTotal}"/>
        </div>
      </g:if>
    </g:if>

    <g:link class="buttonBlue" action="create">Neuen Pädagogen anlegen</g:link>
    <div class="spacer"></div>
  </div>
</div>
</body>