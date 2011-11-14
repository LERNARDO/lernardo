<head>
  <meta name="layout" content="private"/>
  <title><g:message code="operator"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="operator"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalOperators, message(code: 'operators')]"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'operator')])}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${operators}" status="i" var="operator">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>
            <erp:profileImage entity="${operator}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${operator.id}" params="[entity: operator.id]">${fieldValue(bean: operator, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalOperators}"/>
    </div>

  </div>
</div>
</body>