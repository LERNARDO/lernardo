<head>
  <meta name="layout" content="private"/>
  <title><g:message code="paten"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="paten"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalPates, message(code: 'paten')]"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'pate')])}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[pate: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
        <g:sortableColumn property="country" title="${message(code:'country')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${pates}" status="i" var="pate">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>
            <erp:profileImage entity="${pate}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${pate.id}" params="[entity: pate.id]">${fieldValue(bean: pate, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td>${pate.profile.country}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalPates}"/>
    </div>

  </div>
</div>
</body>