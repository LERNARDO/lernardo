<head>
  <meta name="layout" content="private"/>
  <title>Projekte</title>
</head>
<body>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="projectTemplateProfile" action="list">Projektvorlagen</g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1>Projekte</h1>
  </div>
</div>
<div class="clearFloat"></div>
<div class="boxGray">
  <div class="second">

    <p>${projectTotal} Projekt(e) insgesamt vorhanden</p>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'project.profile.name')}"/>
        <g:sortableColumn property="startDate" title="${message(code:'project.profile.startDate')}"/>
        <g:sortableColumn property="endDate" title="${message(code:'project.profile.endDate')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${projectList}" status="i" var="project">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${project.id}" params="[entity: project.id]">${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy"/></td>
          <td><g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${projectTotal}"/>
    </div>

  </div>
</div>
</body>
