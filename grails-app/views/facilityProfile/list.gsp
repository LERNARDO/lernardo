<head>
  <meta name="layout" content="private"/>
  <title>Einrichtungen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Einrichtungen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${facilityTotal} Einrichtung(en) insgesamt vorhanden</p>
    <g:if test="${facilityTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'facility.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${facilities}" status="i" var="facility">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${facility.id}" params="[entity: facility.id]">${fieldValue(bean: facility, field: 'profile.fullName')}</g:link></td>
              <td>${fieldValue(bean: facility, field: 'profile.street') ?: '<div class="italic">---</div>'}</td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>

      <g:if test="${facilityTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${facilityTotal}"/>
        </div>
      </g:if>
    </g:if>

    <app:isOperator entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neue Einrichtung anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>
    
  </div>
</div>
</body>