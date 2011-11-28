<head>
  <meta name="layout" content="database"/>
  <title><g:message code="children"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="children"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalChildren, message(code: 'children')]"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'child')])}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[child: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
        <g:sortableColumn property="birthDate" title="${message(code:'birthDate')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${children}" status="i" var="child">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>
            <erp:profileImage entity="${child}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${child.id}" params="[entity: child.id]">${fieldValue(bean: child, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy" /></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalChildren}"/>
    </div>

  </div>
</div>
</body>