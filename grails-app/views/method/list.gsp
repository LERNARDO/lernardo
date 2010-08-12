<head>
  <meta name="layout" content="private"/>
  <title>Bewertungsmethoden</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Bewertungsmethoden</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>${methodInstanceTotal} Bewertungsmethoden insgesamt vorhanden</p>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="name" title="${message(code:'method.name')}"/>
        <th>Elemente</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${methodInstanceList}" status="i" var="method">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${method.id}">${fieldValue(bean: method, field: 'name').decodeHTML()}</g:link></td>
          <td>${method.elements.size()}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${methodInstanceTotal}"/>
    </div>

    <app:isAdmin>
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neue Bewertungsmethode anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:isAdmin>

  </div>
</div>
</body>