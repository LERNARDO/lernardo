<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupPartners"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupPartners"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalGroupPartners, message(code: 'groupPartners')]"/>
    </div>

    <erp:accessCheck types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'groupPartner')])}"/></div>
          <div class="clear"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:if test="${groups}">

      <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[groupPartner: 'yes']]" before="showspinner('#membersearch-results')" />
      <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

      <table class="default-table">
        <thead>
        <tr>
          <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
          <g:sortableColumn property="service" title="${message(code:'groupPartner.profile.service')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${groups}" status="i" var="group">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><g:link action="show" id="${group.id}">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
            <td>${group.profile.service}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate total="${totalGroupPartners}"/>
      </div>

    </g:if>

  </div>
</div>
</body>
