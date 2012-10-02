<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="methods"/></title>
</head>
<body>

<div class="tabInactive">
    <h1><g:link controller="setup" action="show">Setup</g:link></h1>
</div>

<div class="tabActive">
    <h1><g:message code="methods"/></h1>
</div>

<div class="tabInactive">
    <h1><g:link controller="label" action="index"><g:message code="labels"/></g:link></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

    <div class="info-msg">
      <g:message code="object.total" args="[methodInstanceTotal, message(code: 'methods')]"/>
    </div>

     <erp:accessCheck types="['Betreiber']">
      <div class="buttons cleared">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'method')])}"/></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="name" title="${message(code:'name')}"/>
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
</body>