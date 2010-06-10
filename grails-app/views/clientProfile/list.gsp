<head>
  <meta name="layout" content="private"/>
  <title>Betreute</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Betreute</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${clientTotal} Betreute insgesamt vorhanden</p>
    <g:if test="${clientTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'client.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${clientList}" status="i" var="client">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${client.id}" params="[entity: client.id]">${fieldValue(bean: client, field: 'profile.fullName')}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${clientTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${clientTotal}"/>
        </div>
      </g:if>
    </g:if>

    <app:isOperator entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neuen Betreuten anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>
    
  </div>
</div>
</body>