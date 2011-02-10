<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupColonies"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupColonies"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${groups.totalCount} <g:message code="groupColony.profile.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="groupColony.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'groupColony.profile.name')}"/>
        <th><g:message code="representantives"/></th>
        <th><g:message code="buildings"/></th>
        <th><g:message code="facilities"/></th>
        <th><g:message code="resources"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>${group.profile.representatives.size()}</td>
          <td>${group.profile.buildings.size()}</td>
          <td><erp:getGroupFacilities entity="${group}"/></td>
          <td><erp:getGroupResources entity="${group}"/></td>
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
