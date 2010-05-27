<head>
  <meta name="layout" content="private" />
  <title>Ressourcen</title>
</head>
<body>
  <div class="headerGreen">
    <div class="second">
      <h1>Ressourcen</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <p>${resourceTotal} Ressource(n) insgesamt vorhanden</p>
      <g:if test="${resourceTotal > 0}">
        <div id="body-list">
          <table>
            <thead>
              <tr>
                <g:sortableColumn property="fullName" title="${message(code:'resource.profile.name')}" />
               </tr>
            </thead>
            <tbody>
            <g:each in="${resourceList}" status="i" var="resource">
              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td><g:link action="show" id="${resource.id}">${fieldValue(bean:resource, field:'profile.fullName')}</g:link></td>
              </tr>
            </g:each>
            </tbody>
          </table>
        </div>

        <g:if test="${resourceTotal > 20}">
          <div class="paginateButtons">
            <g:paginate total="${resourceTotal}" />
          </div>
        </g:if>
      </g:if>

      <g:link class="buttonGreen" action="create">Neue Ressource anlegen</g:link>
      <div class="spacer"></div>
      
    </div>
  </div>
</body>
