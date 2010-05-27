<head>
  <meta name="layout" content="private"/>
  <title>Betreiber</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Betreiber</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${operatorTotal} Betreiber insgesamt vorhanden</p>
    <g:if test="${operatorTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'operator.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${operatorList}" status="i" var="operator">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${operator.id}">${fieldValue(bean: operator, field: 'profile.fullName')}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${operatorTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${operatorTotal}"/>
        </div>
      </g:if>
    </g:if>

    <div class="buttons">
      <g:link class="buttonGreen" action="create">Neuen Betreiber anlegen</g:link>
      <div class="spacer"></div>
    </div>
    
  </div>
</div>
</body>