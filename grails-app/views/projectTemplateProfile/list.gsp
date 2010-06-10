<head>
  <meta name="layout" content="private" />
  <title>Projektvorlagen</title>
</head>
<body>
  <div class="headerGreen">
    <div class="second">
      <h1>Projektvorlagen</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <p>${projectTemplateTotal} Projektvorlagen(n) insgesamt vorhanden</p>
      <g:if test="${projectTemplateTotal > 0}">
        <div id="body-list">
          <table>
            <thead>
              <tr>
                <g:sortableColumn property="fullName" title="${message(code:'projectTemplate.profile.name')}" />
               </tr>
            </thead>
            <tbody>
            <g:each in="${projectTemplateList}" status="i" var="project">
              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td><g:link action="show" id="${project.id}" params="[entity: project.id]">${fieldValue(bean:project, field:'profile.fullName')}</g:link></td>
              </tr>
            </g:each>
            </tbody>
          </table>
        </div>

        <g:if test="${projectTemplateTotal > 20}">
          <div class="paginateButtons">
            <g:paginate total="${projectTemplateTotal}" />
          </div>
        </g:if>
      </g:if>

      <app:isEducator entity="${entity}">
        <g:link class="buttonGreen" action="create">Neue Projektvorlage anlegen</g:link>
        <div class="spacer"></div>
      </app:isEducator>

    </div>
  </div>
</body>
