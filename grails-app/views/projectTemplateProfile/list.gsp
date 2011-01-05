<head>
  <meta name="layout" content="private"/>
  <title><g:message code="projectTemplates"/></title>
</head>
<body>
<div class="tabGreen">
  <div class="second">
    <h1><g:message code="projectTemplates"/></h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="projectProfile" action="list"><g:message code="projects"/></g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${projectTemplateTotal} <g:message code="projectTemplates.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="projectTemplate.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:accessCheck>

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
          <td><erp:getProjectTemplateUnitsCount template="${project}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${projectTemplateTotal}"/>
    </div>

  </div>
</div>
</body>
