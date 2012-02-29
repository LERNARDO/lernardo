<head>
  <meta name="layout" content="database"/>
  <title><g:message code="users"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="users"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalUsers, message(code: 'users')]"/>
    </div>

    <div class="buttons">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'user')])}"/></div>
        <div class="clear"></div>
      </g:form>
    </div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${users}" status="i" var="user">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>
            <erp:profileImage entity="${user}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${user.id}">${fieldValue(bean: user, field: 'profile.lastName').decodeHTML()} ${fieldValue(bean: user, field: 'profile.firstName').decodeHTML()}</g:link>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalUsers}"/>
    </div>

  </div>
</div>
</body>