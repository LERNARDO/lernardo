<head>
  <meta name="layout" content="private"/>
  <title><g:message code="parents"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="parents"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${parentTotal} <g:message code="parent.profile.c_total"/></p>
    <g:if test="${parentTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="lastName" title="${message(code:'parent.profile.name')}"/>
          </tr>
          </thead>
          <tbody>
          <g:each in="${parentList}" status="i" var="parent">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${parent.id}" params="[entity: parent.id]">${fieldValue(bean: parent, field: 'profile.fullName').decodeHTML()}</g:link></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>

      <g:if test="${parentTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${parentTotal}"/>
        </div>
      </g:if>
    </g:if>

    <app:isOperator entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="parent.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>
    
  </div>
</div>
</body>