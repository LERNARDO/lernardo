<head>
  <meta name="layout" content="private"/>
  <title><g:message code="children"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="children"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${childTotal} <g:message code="child.profile.c_total"/></p>
    <g:if test="${childTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'child.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${childList}" status="i" var="child">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${child.id}" params="[entity: child.id]">${fieldValue(bean: child, field: 'profile.fullName').decodeHTML()}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${childTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${childTotal}"/>
        </div>
      </g:if>
    </g:if>

    <app:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="child.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>

  </div>
</div>
</body>