<head>
  <meta name="layout" content="private"/>
  <title>Betreute</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>${message(code: 'client')}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>${clientTotal} <g:message code="client.profile.c_total"/></p>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'client.profile.name')}"/>
        <g:sortableColumn property="currentStreet" title="${message(code:'client.profile.currentStreet')}"/>
        <g:sortableColumn property="currentCity" title="${message(code:'client.profile.currentCity')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${clientList}" status="i" var="client">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${client.id}" params="[entity: client.id]">${fieldValue(bean: client, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>${fieldValue(bean: client, field: 'profile.currentStreet')}</td>
          <td>${fieldValue(bean: client, field: 'profile.currentCity')}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${clientTotal}"/>
    </div>

    <app:isOperator entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="client.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isOperator>

  </div>
</div>
</body>