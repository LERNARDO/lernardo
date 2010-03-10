<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Betreute</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Betreute</h1>
  </div>
  <div class="boxGray">
    <div class="body">
      <p>${clientTotal} Betreute insgesamt vorhanden</p>
      <g:if test="${clientTotal > 0}">
        <div id="body-list">
                <table>
                    <thead>
                        <tr>
                          <g:sortableColumn property="lastName" title="${message(code:'clientProfile.lastName.label', default:'Nachname')}" />
                 	      <g:sortableColumn property="firstName" title="${message(code:'clientProfile.firstName.label', default:'Vorname')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${clientList}" status="i" var="client">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${client.id}">${fieldValue(bean:client, field:'profile.lastName')}</g:link></td>
                            <td>${fieldValue(bean:client, field:'firstName')}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
         <g:if test="${clientTotal > 20}">
          <div class="paginateButtons">
            <g:paginate total="${clientTotal}" />
          </div>
        </g:if>
        </g:if>

        <g:link class="buttonBlue" action="create">Neuen Betreuten anlegen</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</body>