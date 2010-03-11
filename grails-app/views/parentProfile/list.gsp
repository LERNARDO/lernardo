<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Erziehungsberechtigte</title>
</head>
<body>
<div class="headerBlue">
  <h1>Erziehungsberechtigte</h1>
</div>
<div class="boxGray">
  <div class="body">
    <p>${parentTotal} Erziehungsberechtigte insgesamt vorhanden</p>
    <g:if test="${parentTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'parentProfile.lastName.label', default:'Nachname')}"/>
            <g:sortableColumn property="firstName" title="${message(code:'parentProfile.firstName.label', default:'Vorname')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${parentList}" status="i" var="parent">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${parent.id}">${fieldValue(bean: parent, field: 'profile.lastName')}</g:link></td>
              <td>${fieldValue(bean: parent, field: 'profile.firstName')}</td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>

      <g:if test="${parentTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${parentTotal}"/>
        </div>
      </g:if>
    </g:if>

    <g:link class="buttonBlue" action="create">Neuen Erziehungsberechtigten anlegen</g:link>
    <div class="spacer"></div>
  </div>
</div>
</body>