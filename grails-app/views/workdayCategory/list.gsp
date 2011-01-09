<head>
  <meta name="layout" content="private"/>
  <title><g:message code="workdayCategory"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="workdayCategory"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${workdayCategoryInstanceTotal} <g:message code="workdayCategory.c_total"/>
    </div>

    <erp:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="create"><g:message code="workdayCategory.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isOperator>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="name" title="${message(code:'workdayCategory.name', default:'Bezeichnung')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${workdayCategoryInstanceList}" status="i" var="workdayCategoryInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${workdayCategoryInstance.id}">${fieldValue(bean: workdayCategoryInstance, field: 'name')}</g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${workdayCategoryInstanceTotal}"/>
    </div>

  </div>
</div>
</body>