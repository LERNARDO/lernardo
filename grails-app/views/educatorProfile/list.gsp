<head>
  <meta name="layout" content="private"/>
  <title><g:message code="educators"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="educators"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${educatorTotal} <g:message code="educator.profile.c_total"/></p>
    <g:if test="${educatorTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'educator.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${educatorList}" status="i" var="educator">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${educator.id}" params="[entity: educator.id]">${fieldValue(bean: educator, field: 'profile.fullName')}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${educatorTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${educatorTotal}"/>
        </div>
      </g:if>
    </g:if>

    <app:isOperator entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="educator.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>
    
  </div>
</div>
</body>