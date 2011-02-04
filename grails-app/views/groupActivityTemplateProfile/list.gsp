<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivityTemplates"/></title>
</head>
<body>
<div class="tabGreen">
  <div class="second">
    <h1><g:message code="groupActivityTemplates"/></h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="groupActivityProfile" action="index"><g:message code="groupActivities"/></g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${groups.totalCount} <g:message code="groupActivityTemplate.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="groupActivityTemplate.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'groupActivityTemplate.profile.name')}"/>
        <th><g:message code="numberOfActivityTemplates"/></th>
        <th><g:message code="totalDuration"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><erp:getGroupSize entity="${group}"/></td>
          <td>${fieldValue(bean: group, field: 'profile.realDuration')}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${groups.totalCount}"/>
    </div>

  </div>
</div>
</body>
