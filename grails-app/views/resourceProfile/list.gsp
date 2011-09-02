<head>
  <meta name="layout" content="private"/>
  <title>Ressourcen</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1>Ressourcen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${resourceTotal} Ressource(n) insgesamt vorhanden
    </div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'resource.profile.name')}"/>
        <th>Erstellt in</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${resourceList}" status="i" var="resource">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${resource.id}">${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>
            <erp:resourceCreatedIn resource="${resource}">
              <g:link controller="${source.type.supertype.name +'Profile'}" action="show" id="${source.id}" params="[entity: source.id]">${source.profile.fullName}</g:link>
            </erp:resourceCreatedIn>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${resourceTotal}"/>
    </div>

  </div>
</div>
</body>
