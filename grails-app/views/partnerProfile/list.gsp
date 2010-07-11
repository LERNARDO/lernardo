<head>
  <meta name="layout" content="private"/>
  <title><g:message code="partner"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="partner"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${partnerTotal} <g:message code="partner.profile.c_total"/></p>
    <g:if test="${partnerTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'partner.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${partnerList}" status="i" var="partner">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${partner.id}" params="[entity: partner.id]">${fieldValue(bean: partner, field: 'profile.fullName')}</g:link></td>
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

    <app:isOperator entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="partner.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>
    
  </div>
</div>
</body>