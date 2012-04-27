<head>
  <meta name="layout" content="database"/>
  <title><g:message code="facilities"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="facilities"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalFacilities, message(code: 'facilities')]"/>
    </div>

    <erp:accessCheck types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'facility')])}"/></div>
          <div class="clear"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[facility: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
        <th>${message(code: 'street')}</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${facilities}" status="i" var="facility">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${facility.id}">${fieldValue(bean: facility, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td>${fieldValue(bean: facility, field: 'profile.street') ?: '<div class="italic">---</div>'}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalFacilities}"/>
    </div>

  </div>
</div>
</body>