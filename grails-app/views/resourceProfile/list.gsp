<head>
  <meta name="layout" content="database"/>
  <title><g:message code="resource.management"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="resource.management"/></h1>
</div>
<div class="boxContent">

    <div class="info-msg">
      <g:message code="object.total" args="[resourceTotal, message(code: 'resources')]"/>
    </div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
        <th><g:message code="createdIn"/></th>
        <th><g:message code="resource.profile.amount"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${resourceList}" status="i" var="resource">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${resource.id}">${fieldValue(bean: resource, field: 'profile').decodeHTML()}</g:link></td>
          <td>
            <erp:resourceCreatedIn resource="${resource}">
              <g:link controller="${source.type.supertype.name + 'Profile'}" action="show" id="${source.id}">${source.profile}</g:link>
            </erp:resourceCreatedIn>
          </td>
          <td>${fieldValue(bean: resource, field: 'profile.amount').decodeHTML()}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${resourceTotal}"/>
    </div>

</div>
</body>
