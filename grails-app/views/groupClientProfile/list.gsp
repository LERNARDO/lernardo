<head>
  <meta name="layout" content="private"/>
  <title>Betreutengruppen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Betreutengruppen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>${groupTotal} Betreutengruppen insgesamt vorhanden</p>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'groupClient.profile.name')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${groupTotal}"/>
    </div>

    <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neue Betreutengruppe anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:hasRoleOrType>

  </div>
</div>
</body>
