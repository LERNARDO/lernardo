<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Themen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Themen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${themeTotal} Themen insgesamt vorhanden</p>
    <g:if test="${themeTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'theme.profile.name')}"/>
            <th>Typ</th>
          </tr>
          </thead>
          <tbody>
          <g:each in="${themeList}" status="i" var="theme">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${theme.id}">${fieldValue(bean: theme, field: 'profile.fullName')}</g:link></td>
              <td>${theme.profile.type}</td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${themeTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${themeTotal}"/>
        </div>
      </g:if>
    </g:if>

    <div class="buttons">
      <g:link class="buttonBlue" action="create">Neues Thema anlegen</g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>