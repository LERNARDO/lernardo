<head>
  <meta name="layout" content="database"/>
  <title><g:message code="educators"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="educators"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalEducators, message(code: 'educators')]"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'educator')])}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[educator: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
        <g:sortableColumn property="education" title="${message(code:'educator.profile.education')}"/>
        <g:sortableColumn property="employment" title="${message(code:'educator.profile.employment')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${educators}" status="i" var="educator">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>
            <erp:profileImage entity="${educator}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${educator.id}">${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td>
            ${educator.profile.education.decodeHTML() ?: '<span class="italic">' + message(code: 'noData') + '<span>'}
          </td>
          <td>
            ${educator.profile.employment.decodeHTML() ?: '<span class="italic">' + message(code: 'noData') + '<span>'}
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalEducators}"/>
    </div>

  </div>
</div>
</body>