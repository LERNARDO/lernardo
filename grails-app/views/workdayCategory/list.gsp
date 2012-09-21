<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="workdayCategories"/></title>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="timeEvaluation"><g:message code="timeEvaluation"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="workdayCategories"/></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="workdayUnit" action="workhours"><g:message code="educator.profile.workHours"/></g:link></h1>
  </div>
</div>

<div class="clear"></div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.found" args="[workdayCategoryInstanceTotal, message(code: 'workdayCategories')]"/>
    </div>

    <erp:accessCheck types="['Betreiber']">
      <div class="buttons cleared">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'workdayCategory')])}"/></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="name" title="${message(code:'workdayCategory.name')}"/>
        <g:sortableColumn property="count" title="${message(code:'workdayCategory.count')}"/>
        <g:sortableColumn property="beginDate" title="${message(code:'begin')}"/>
        <g:sortableColumn property="endDate" title="${message(code:'end')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${workdayCategoryInstanceList}" status="i" var="workdayCategoryInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${workdayCategoryInstance.id}">${fieldValue(bean: workdayCategoryInstance, field: 'name')}</g:link></td>
          <td><g:formatBoolean boolean="${workdayCategoryInstance.counts}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
          <td><g:formatDate date="${workdayCategoryInstance.beginDate}" format="dd. MM. yyyy" /></td>
          <td><g:formatDate date="${workdayCategoryInstance.endDate}" format="dd. MM. yyyy" /></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${workdayCategoryInstanceTotal}"/>
    </div>

  </div>
</div>
</body>