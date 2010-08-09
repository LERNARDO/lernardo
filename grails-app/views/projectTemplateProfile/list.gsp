<head>
  <meta name="layout" content="private" />
  <title>Projektvorlagen</title>
</head>
<body>
  <div class="tabGreen">
    <div class="second">
      <h1>Projektvorlagen</h1>
    </div>
  </div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="projectProfile" action="list">Projekte</g:link></h1>
  </div>
</div>
<div class="clearFloat"> </div>

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
                <td><g:link action="show" id="${project.id}" params="[entity: project.id]">${fieldValue(bean:project, field:'profile.fullName').decodeHTML()}</g:link></td>
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

      <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
        <g:link class="buttonGreen" action="create">Neue Projektvorlage anlegen</g:link>
        <div class="spacer"></div>
      </app:hasRoleOrType>

    </div>
  </div>
</body>
