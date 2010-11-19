<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupFamilies"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="groupFamilies"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    ${groupTotal} <g:message code="groupFamily.profile.c_total"/>

    <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="groupFamily.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'groupFamily.profile.name')}"/>
        <g:sortableColumn property="amountHousehold" title="${message(code:'groupFamily.profile.amountHousehold')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>${fieldValue(bean: group, field: 'profile.amountHousehold')}</td>
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
