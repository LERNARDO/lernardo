<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Partner</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Partner</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${partnerTotal} Partner insgesamt vorhanden</p>
    <g:if test="${partnerTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'partnerProfile.fullName.label', default:'Name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${partnerList}" status="i" var="partner">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${partner.id}">${fieldValue(bean: partner, field: 'profile.fullName')}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>

      <g:if test="${partnerTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${partnerTotal}"/>
        </div>
      </g:if>
    </g:if>

    <div class="buttons">
      <g:link class="buttonBlue" action="create">Neuen Partner anlegen</g:link>
      <div class="spacer"></div>
    </div>
    
  </div>
</div>
</body>