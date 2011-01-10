<head>
  <meta name="layout" content="private"/>
  <title><g:message code="methods"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="methods"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${methodInstanceTotal} <g:message code="method.c_total"/>
    </div>

     <erp:isAdmin entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="method.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isAdmin>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="name" title="${message(code:'method.name')}"/>
        <th><g:message code="elements"/></th>
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

  </div>
</div>
</body>