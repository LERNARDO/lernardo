<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Colonias</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Colonias</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${groupTotal} Colonias insgesamt vorhanden</p>
    <g:if test="${groupTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'groupColony.profile.name')}"/>
            <th>Repräsentanten</th>
            <th>Gebäude</th>
            <th>Einrichtungen</th>
            <th>Ressourcen</th>
          </tr>
          </thead>
          <tbody>
          <g:each in="${groups}" status="i" var="group">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${group.id}">${fieldValue(bean: group, field: 'profile.fullName')}</g:link></td>
              <td>${group.profile.representatives.size()}</td>
              <td>${group.profile.buildings.size()}</td>
              <td>-</td>
              <td>-</td>
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

    <div class="buttons">
      <g:link class="buttonBlue" action="create">Neue Colonia anlegen</g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>
