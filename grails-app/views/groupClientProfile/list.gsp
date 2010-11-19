<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupClients"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="groupClients"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    ${groupTotal} <g:message code="groupClient.profile.c_total"/>

    <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="groupClient.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'groupClient.profile.name')}"/>
        <th><g:message code="clients"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><app:getGroupClientsCount entity="${group}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${groupTotal}"/>
    </div>

  </div>
</div>
</body>
