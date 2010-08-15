<head>
  <meta name="layout" content="private"/>
  <title><g:message code="paten"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="paten"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>${pateTotal} <g:message code="pate.profile.c_total"/></p>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'pate.profile.name')}"/>
        <g:sortableColumn property="country" title="${message(code:'pate.profile.country')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${pateList}" status="i" var="pate">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${pate.id}" params="[entity: pate.id]">${fieldValue(bean: pate, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><app:getNationalities nationality="${pate.profile.country}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${pateTotal}"/>
    </div>

    <app:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="pate.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>

  </div>
</div>
</body>