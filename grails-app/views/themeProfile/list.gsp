<head>
  <meta name="layout" content="private"/>
  <title>Themen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Themen</h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    ${themeTotal} Themen insgesamt vorhanden

    <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']" me="false">
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neues Thema anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'theme.profile.name')}"/>
        %{--<th>Typ</th>--}%
        <g:sortableColumn property="startDate" title="${message(code:'theme.profile.startDate')}"/>
        <g:sortableColumn property="endDate" title="${message(code:'theme.profile.endDate')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${themeList}" status="i" var="theme">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${theme.id}">${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</g:link></td>
          %{--<td>${theme.profile.type}</td>--}%
          <td><g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy"/></td>
          <td><g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${themeTotal}"/>
    </div>

  </div>
</div>
</body>