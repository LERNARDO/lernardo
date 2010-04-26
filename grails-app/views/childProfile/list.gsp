<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Kinder</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Kinder</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${childTotal} Kinder insgesamt vorhanden</p>
    <g:if test="${childTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'childProfile.lastName.label', default:'Name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${childList}" status="i" var="child">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${child.id}">${fieldValue(bean: child, field: 'profile.lastName')} ${fieldValue(bean: child, field: 'profile.firstName')}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${childTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${childTotal}"/>
        </div>
      </g:if>
    </g:if>

    <div class="buttons">
      <g:link class="buttonBlue" action="create">Neues Kind anlegen</g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>