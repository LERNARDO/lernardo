<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Paten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Paten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${pateTotal} Paten insgesamt vorhanden</p>
    <g:if test="${pateTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'pateProfile.lastName.label', default:'Name')}"/>
            %{--<g:sortableColumn property="PLZ" title="${message(code:'pateProfile.nationality.label', default:'Nationalität')}"/>--}%
          </tr>
          </thead>
          <tbody>
          <g:each in="${pateList}" status="i" var="pate">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${pate.id}">${fieldValue(bean: pate, field: 'profile.lastName')} ${fieldValue(bean: pate, field: 'profile.firstName')}</g:link></td>
              %{--<td>${fieldValue(bean: pate, field: 'profile.nationality')}</td>--}%
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
      <g:link class="buttonBlue" action="create">Neuen Paten anlegen</g:link>
      <div class="spacer"></div>
    </div>
    
  </div>
</div>
</body>