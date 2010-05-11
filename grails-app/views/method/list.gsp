<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Bewertungsmethoden</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Bewertungsmethoden</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${methodInstanceTotal} Bewertungsmethoden insgesamt vorhanden</p>
    <g:if test="${methodInstanceTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'method.name')}"/>
            <th>Elemente</th>
          </tr>
          </thead>
          <tbody>
          <g:each in="${methodInstanceList}" status="i" var="method">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${method.id}">${fieldValue(bean: method, field: 'name')}</g:link></td>
              <td>${method.elements.size()}</td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <g:if test="${methodInstanceTotal > 20}">
        <div class="paginateButtons">
          <g:paginate total="${methodInstanceTotal}"/>
        </div>
      </g:if>
    </g:if>

    <div class="buttons">
      <g:link class="buttonBlue" action="create">Neue Bewertungsmethode anlegen</g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>