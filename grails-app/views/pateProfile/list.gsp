<head>
  <meta name="layout" content="private"/>
  <title><g:message code="paten"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="paten"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${pates.totalCount} <g:message code="pate.profile.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'pate.profile.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'pate.profile.name')}"/>
        <g:sortableColumn property="country" title="${message(code:'pate.profile.country')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${pates}" status="i" var="pate">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${pate.id}" params="[entity: pate.id]">${fieldValue(bean: pate, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><g:message code="nationality.${pate.profile.country}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${pates.totalCount}"/>
    </div>

  </div>
</div>
</body>