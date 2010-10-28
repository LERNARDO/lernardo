<head>
  <meta name="layout" content="private"/>
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
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <p>${projectTemplateTotal} Projektvorlagen(n) insgesamt vorhanden</p>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'projectTemplate.profile.name')}"/>
        <g:sortableColumn property="status" title="${message(code:'projectTemplate.profile.status')}"/>
        <th>Projekteinheitenvorlagen</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${projectTemplateList}" status="i" var="project">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${project.id}" params="[entity: project.id]">${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>${fieldValue(bean: project, field: 'profile.status')}</td>
          <td><app:getProjectTemplateUnitsCount template="${project}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${projectTemplateTotal}"/>
    </div>

    <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neue Projektvorlage anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:accessCheck>

  </div>
</div>
</body>
