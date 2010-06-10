<head>
  <meta name="layout" content="private" />
  <title>Projekte</title>
</head>
<body>
  <div class="headerBlue">
    <div class="second">
      <h1>Projekte</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <p>${projectTotal} Projekt(e) insgesamt vorhanden</p>
      <g:if test="${projectTotal > 0}">
        <div id="body-list">
          <table>
            <thead>
              <tr>
                <g:sortableColumn property="fullName" title="${message(code:'project.profile.name')}" />
               </tr>
            </thead>
            <tbody>
            <g:each in="${projectList}" status="i" var="project">
              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td><g:link action="show" id="${project.id}" params="[entity: project.id]">${fieldValue(bean:project, field:'profile.fullName')}</g:link></td>
              </tr>
            </g:each>
            </tbody>
          </table>
        </div>

        <g:if test="${projectTotal > 20}">
          <div class="paginateButtons">
            <g:paginate total="${projectTotal}" />
          </div>
        </g:if>
      </g:if>

      %{--<g:link class="buttonBlue" action="create">Neue Projektvorlage anlegen</g:link>--}%
      <div class="spacer"></div>

    </div>
  </div>
</body>
