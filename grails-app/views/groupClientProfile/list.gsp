<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupClients"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupClients"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${totalGroupClients} <g:message code="groupClient.profile.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'groupClient.profile.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[groupClient: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'groupClient.profile.name')}"/>
        <th><g:message code="clients"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="createpdf" id="${group.id}"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/></g:link> <g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><erp:getGroupClientsCount entity="${group}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalGroupClients}"/>
    </div>

  </div>
</div>
</body>
