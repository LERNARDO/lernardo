<head>
  <meta name="layout" content="database"/>
  <title>${message(code: 'clients')}</title>
</head>
<body>

<div class="tabInactive">
    <h1><g:link controller="clientProfile" action="list"><g:message code="clients.active"/></g:link></h1>
</div>

<div class="tabActive">
    <h1><g:message code="clients.inactive"/></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

    <div class="info-msg">
      <g:message code="object.total" args="[totalClients, message(code: 'clients')]"/>
    </div>

    <erp:accessCheck types="['Betreiber']" facilities="${facilities}">
      <div class="buttons cleared">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'client')])}" /></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller: 'overview', action: 'searchMe', params: [client: 'yes', enabled: 'false']]" before="showspinner('#membersearch-results')" />
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
            <erp:profileImage entity="${client}" width="30" height="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${client.id}">${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}</g:link>
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
</body>