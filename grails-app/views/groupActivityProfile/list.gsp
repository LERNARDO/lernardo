<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivities"/></title>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="groupActivityTemplateProfile" action="index"><g:message code="groupActivityTemplates"/></g:link></h1>
  </div>
</div>
<div class="tabGreen">
  <div class="second">
    <h1><g:message code="groupActivities"/></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg" style="margin-bottom: 5px;">
      ${totalGroupActivities} <g:message code="groupActivities.c_total"/>
    </div>

    <g:formRemote name="formRemote" url="[action: 'searchbydate']" update="membersearch-results">
      <g:message code="searchForDate"/>:
      <g:message code="from"/>: <g:textField class="datepicker" name="beginDate" size="10" value=""/>
      <g:message code="to"/>: <g:textField class="datepicker" name="endDate" size="10" value=""/>
      <g:submitButton name="submit" value="OK"/>
    </g:formRemote>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[groupActivity: 'yes']]" before="showspinner('#membersearch-results')" />

    <g:formRemote name="formRemote2" url="[action: 'searchbytheme']" update="membersearch-results">
      <g:message code="searchForTheme"/>:
      <g:select name="theme" from="${themes}" optionKey="id" optionValue="profile"/>
      <g:submitButton name="submit" value="OK"/>
    </g:formRemote>

    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <g:if test="${groups}">
      <table class="default-table">
        <thead>
        <tr>
          <g:sortableColumn property="fullName" title="${message(code:'groupActivity.profile.name')}"/>
          <g:sortableColumn property="date" title="${message(code:'groupActivity.profile.date')}"/>
          <th><g:message code="creator"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${groups}" status="i" var="group">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
            <td><g:formatDate date="${group.profile.date}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            <td><erp:createdBy entity="${group}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate total="${totalGroupActivities}"/>
      </div>
    </g:if>

  </div>
</div>
</body>
