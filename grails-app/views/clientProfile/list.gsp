<head>
  <meta name="layout" content="database"/>
  <title>${message(code: 'clients')}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1>${message(code: 'client')}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalClients, message(code: 'clients')]"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities}">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'client')])}" /></div>
        </g:form>
        <div class="spacer"></div>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[client: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="firstName" title="${message(code:'firstName')}"/>
        <g:sortableColumn property="lastName" title="${message(code:'lastName')}"/>
        <g:sortableColumn property="birthDate" title="${message(code:'birthDate')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${clients}" status="i" var="client">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>
            <erp:profileImage entity="${client}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${client.id}" params="[entity: client.id]">${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}</g:link>
          </td>
          <td>${fieldValue(bean: client, field: 'profile.lastName').decodeHTML()}</td>
          <td><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy" /></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalClients}"/>
    </div>

  </div>
</div>
</body>