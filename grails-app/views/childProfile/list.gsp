<head>
  <meta name="layout" content="private"/>
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
      ${totalChildren} <g:message code="child.profile.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'child.profile.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[child: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'child.profile.name')}"/>
        <g:sortableColumn property="birthDate" title="${message(code:'child.profile.birthDate')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${children}" status="i" var="child">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${child.id}" params="[entity: child.id]">${fieldValue(bean: child, field: 'profile.fullName').decodeHTML()}</g:link></td>
          %{--
          <td><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
          --}%
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