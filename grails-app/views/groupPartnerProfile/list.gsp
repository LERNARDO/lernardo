<head>
  <meta name="layout" content="private"/>
  <title>Sponsorennetzwerke</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Sponsorennetzwerke</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>${groupTotal} Sponsorennetzwerke insgesamt vorhanden</p>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'groupPartner.profile.name')}"/>
        <g:sortableColumn property="service" title="${message(code:'groupPartner.profile.service')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><app:getPartnerService service="${group.profile.service}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${groupTotal}"/>
    </div>

    <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neues Sponsorennetzwerk anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:hasRoleOrType>

  </div>
</div>
</body>
