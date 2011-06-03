<head>
  <meta name="layout" content="private"/>
  <title><g:message code="projects"/></title>
</head>
<body>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="projectTemplateProfile" action="list"><g:message code="projectTemplates"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="projects"/></h1>
  </div>
</div>
<div class="clearFloat"></div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${projects.totalCount} <g:message code="projects.c_total"/>
    </div>

    <g:if test="${projects}">
      <table class="default-table">
        <thead>
        <tr>
          <g:sortableColumn property="fullName" title="${message(code:'project.profile.name')}"/>
          <g:sortableColumn property="startDate" title="${message(code:'project.profile.startDate')}"/>
          <g:sortableColumn property="endDate" title="${message(code:'project.profile.endDate')}"/>
          <th><g:message code="facility"/></th>
          <th><g:message code="creator"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${projects}" status="i" var="project">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']"><g:link action="del" id="${project.id}" onclick="${erp.getLinks(id: project.id)}"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code:'delete')}" valign="top"/></g:link></erp:accessCheck> <g:link action="show" id="${project.id}" params="[entity: project.id]">${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}</g:link></td>
            %{--
            <td><g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            <td><g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            --}%
            <td><g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy"/></td>
            <td><g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy" /></td>
            <td>
              <erp:getFacilityOfProject entity="${project}">
                <g:link controller="facilityProfile" action="show" id="${facility.id}" params="[entity: facility.id]">${facility.profile.fullName.decodeHTML()}</g:link>
              </erp:getFacilityOfProject>
            </td>
            <td><erp:createdBy entity="${project}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate total="${projects.totalCount}"/>
      </div>
    </g:if>

  </div>
</div>
</body>
