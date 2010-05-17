<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Paten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Paten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${pateTotal} Pate(n) insgesamt vorhanden</p>
    <g:if test="${pateTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'pate.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${pateList}" status="i" var="pate">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${pate.id}">${fieldValue(bean: pate, field: 'profile.fullName')}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>

      <g:if test="${pateTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${pateTotal}"/>
        </div>
      </g:if>
    </g:if>

    <div class="buttons">
      <g:link class="buttonGreen" action="create">Neuen Paten anlegen</g:link>
      <div class="spacer"></div>
    </div>
    
  </div>
</div>
</body>