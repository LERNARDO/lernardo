<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Paten</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Paten</h1>
  </div>
  <div class="boxGray">
    <div class="body">
      <p>${pateTotal} Paten insgesamt vorhanden</p>
      <g:if test="${pateTotal > 0}">
        <div id="body-list">
                <table>
                    <thead>
                        <tr>
                   	        <g:sortableColumn property="lastName" title="${message(code:'pateProfile.lastName.label', default:'Last Name')}" />
                            <g:sortableColumn property="firstName" title="${message(code:'pateProfile.firstName.label', default:'First Name')}" />
                   	        <g:sortableColumn property="PLZ" title="${message(code:'pateProfile.nationality.label', default:'nationality')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pateList}" status="i" var="pate">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${pate.id}">${fieldValue(bean:pate, field:'profile.lastName')}</g:link></td>
                            <td>${fieldValue(bean:pate, field:'profile.firstName')}</td>
                            <td>${fieldValue(bean:pate, field:'profile.nationality')}</td>                      
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        <g:if test="${pateTotal > 20}">
          <div class="paginateButtons">
            <g:paginate total="${pateTotal}" />
          </div>
        </g:if>
        </g:if>

        <g:link class="buttonBlue" action="create">Neuen Paten anlegen</g:link>
      <div class="spacer"></div>
    </div>
  </div>
