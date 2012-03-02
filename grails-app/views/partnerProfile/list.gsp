<head>
  <meta name="layout" content="database"/>
  <title><g:message code="partner"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="partner"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalPartners, message(code: 'partners')]"/>
    </div>

    <erp:accessCheck types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'partner')])}"/></div>
          <div class="clear"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[partner: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
        <g:sortableColumn property="services" title="${message(code:'partner.profile.services')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${partners}" status="i" var="partner">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>
            <erp:profileImage entity="${partner}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
            <g:link action="show" id="${partner.id}">${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td>
            <g:if test="${partner.profile.services}">
              <g:join in="${partner.profile.services}" delimiter=", "/>
            </g:if>
            <g:else>
              <span class="italic"><g:message code="noData"/></span>
            </g:else>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalPartners}"/>
    </div>

  </div>
</div>
</body>