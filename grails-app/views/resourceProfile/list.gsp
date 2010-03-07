<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Ressourcen</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Ressourcen</h1>
  </div>
  <div class="boxGray">
    <div class="body">
      <p>${resourceProfileInstanceTotal} Ressource(n) insgesamt vorhanden</p>
      <g:if test="${resourceProfileInstanceTotal > 0}">
        <div id="body-list">
          <table>
            <thead>
              <tr>
                <g:sortableColumn property="fullName" title="${message(code:'resourceProfile.fullName.label', default:'Name')}" />
                <g:sortableColumn property="description" title="${message(code:'resourceProfile.description.label', default:'Beschreibung')}" />
              </tr>
            </thead>
            <tbody>
            <g:each in="${resourceProfileInstanceList}" status="i" var="resourceProfileInstance">
              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td><g:link action="show" id="${resourceProfileInstance.id}">${fieldValue(bean:resourceProfileInstance, field:'profile.fullName')}</g:link></td>
                <td>${fieldValue(bean:resourceProfileInstance, field:'profile.description')}</td>
              </tr>
            </g:each>
            </tbody>
          </table>
        </div>

        <g:if test="${resourceProfileInstanceTotal > 20}">
          <div class="paginateButtons">
            <g:paginate total="${resourceProfileInstanceTotal}" />
          </div>
        </g:if>
      </g:if>

      <g:link class="buttonBlue" action="create">Neue Ressource anlegen</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</body>
