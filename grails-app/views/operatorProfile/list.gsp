<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Betreiber</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Betreiber</h1>
  </div>
  <div class="boxGray">
    <div class="body">
      <p>${operatorTotal} Betreiber insgesamt vorhanden</p>
      <g:if test="${operatorTotal > 0}">
        <div id="body-list">
                <table>
                    <thead>
                        <tr>
                   	        <g:sortableColumn property="fullName" title="${message(code:'operatorProfile.fullName.label', default:'Name')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${operatorList}" status="i" var="operator">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${operator.id}">${fieldValue(bean:operator, field:'profile.fullName')}</g:link></td>                       
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
         <g:if test="${operatorTotal > 20}">
          <div class="paginateButtons">
            <g:paginate total="${operatorTotal}" />
          </div>
        </g:if>
        </g:if>

        <g:link class="buttonBlue" action="create">Neuen Betreiber anlegen</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</body>