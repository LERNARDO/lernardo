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

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'parent.profile.name')}"/>
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

    <div class="paginateButtons">
      <g:paginate total="${parentTotal}"/>
    </div>

    <app:isOperator entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="parent.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>

  </div>
</div>
</body>