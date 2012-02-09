<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupColonies"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupColonies"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalGroupColonies, message(code: 'groupColonies')]"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'groupColony')])}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[colony: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
        <th><g:message code="representatives"/></th>
        <th><g:message code="buildings"/></th>
        <th><g:message code="facilities"/></th>
        <th><g:message code="resources"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>${group.profile.representatives.size()}</td>
          <td>${group.profile.buildings.size()}</td>
          <td><erp:getGroupFacilities entity="${group}"/></td>
          <td><erp:getGroupResources entity="${group}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalGroupColonies}"/>
    </div>

  </div>
</div>
</body>
