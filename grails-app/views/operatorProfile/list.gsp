<head>
  <meta name="layout" content="database"/>
  <title><g:message code="operator"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="operator"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalOperators, message(code: 'operators')]"/>
    </div>

    <erp:accessCheck roles="['ROLE_ADMIN']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'operator')])}"/></div>
          <div class="clear"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <div class="graypanel">
      <g:formRemote name="formRemote" url="[controller: 'operatorProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="active"/></td>
            <td valign="top" class="value">
              <g:checkBox name="active" value="true"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <td valign="top" class="value">
              <g:textField name="name" size="30"/>
            </td>
          </tr>

        </table>

        <g:submitButton name="button" value="${message(code:'define')}"/>
        <div class="clear"></div>
      </g:formRemote>
    </div>

    <div id="searchresults"></div>

    %{--<table class="default-table">
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
            <g:link action="show" id="${operator.id}">${fieldValue(bean: operator, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalOperators}"/>
    </div>--}%

  </div>
</div>
</body>