<head>
  <meta name="layout" content="private"/>
  <title>Familien</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Familien</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${groupTotal} Familien insgesamt vorhanden</p>
    <g:if test="${groupTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'groupFamily.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${groups}" status="i" var="group">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${group.id}">${fieldValue(bean: group, field: 'profile.fullName')}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>

      <g:if test="${groupTotal > 10}">
        <div class="paginateButtons">
          <g:paginate total="${groupTotal}"/>
        </div>
      </g:if>
    </g:if>

    <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neue Familie anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:hasRoleOrType>

  </div>
</div>
</body>
