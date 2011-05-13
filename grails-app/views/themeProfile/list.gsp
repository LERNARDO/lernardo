<head>
  <meta name="layout" content="private"/>
  <title><g:message code="themes"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="themes"/></h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    %{--${themeTotal} Themen insgesamt vorhanden--}%

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities ?: null}" >
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'theme.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <div id="themelist">
      <g:render template="themes" model="[themes:themes]"/>
    </div>

    %{--<table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'theme.profile.name')}"/>
        --}%%{--<th>Typ</th>--}%%{--
        <g:sortableColumn property="startDate" title="${message(code:'theme.profile.startDate')}"/>
        <g:sortableColumn property="endDate" title="${message(code:'theme.profile.endDate')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${themeList}" status="i" var="theme">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${theme.id}">${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</g:link></td>
          --}%%{--<td>${theme.profile.type}</td>--}%%{--
          <td><g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
          <td><g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${themeTotal}"/>
    </div>--}%

  </div>
</div>
</body>