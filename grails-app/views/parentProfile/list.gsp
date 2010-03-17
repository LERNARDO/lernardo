<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Erziehungsberechtigte</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Erziehungsberechtigte</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${parentTotal} Erziehungsberechtigte insgesamt vorhanden</p>
    <g:if test="${parentTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'parentProfile.lastName.label', default:'Name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${parentList}" status="i" var="parent">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${parent.id}">${fieldValue(bean: parent, field: 'profile.lastName')} ${fieldValue(bean: parent, field: 'profile.firstName')}</g:link></td>
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

    <div class="buttons">
      <g:link class="buttonBlue" action="create">Neuen Erziehungsberechtigten anlegen</g:link>
      <div class="spacer"></div>
    </div>
    
  </div>
</div>
</body>