<head>
  <meta name="layout" content="private"/>
  <title><g:message code="appointment"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="appointment"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${appointmentProfileInstanceTotal} <g:message code="appointment.profile.c_total"/>
    </div>

    <div class="buttons">
      <g:link class="buttonGreen" action="create"><g:message code="appointment.profile.create"/></g:link>
      <div class="spacer"></div>
    </div>

    <g:if test="${appointmentProfileInstanceList}">
      <table class="default-table">
        <thead>
        <tr>
          <g:sortableColumn property="fullName" title="${message(code:'appointmentProfile.fullName.label', default:'Titel')}"/>
          <g:sortableColumn property="beginDate" title="${message(code:'appointmentProfile.beginDate.label', default:'Beginn')}"/>
          <g:sortableColumn property="endDate" title="${message(code:'appointmentProfile.endDate.label', default:'Ende')}"/>
          <g:sortableColumn property="allDay" title="${message(code:'appointmentProfile.allDay.label', default:'Ganztägig')}"/>
          <g:sortableColumn property="isPrivate" title="${message(code:'appointmentProfile.isPrivate.label', default:'Privat')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${appointmentProfileInstanceList}" status="i" var="appointmentProfileInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><g:link action="show" id="${appointmentProfileInstance.id}">${fieldValue(bean: appointmentProfileInstance, field: 'profile.fullName')}</g:link></td>
            <td><g:formatDate date="${appointmentProfileInstance.profile.beginDate}" format="dd. MM. yyyy, HH:mm"/></td>
            <td><g:formatDate date="${appointmentProfileInstance.profile.endDate}" format="dd. MM. yyyy, HH:mm"/></td>
            <td><g:formatBoolean boolean="${appointmentProfileInstance.profile.allDay}" true="Ja" false="Nein"/></td>
            <td><g:formatBoolean boolean="${appointmentProfileInstance.profile.isPrivate}" true="Ja" false="Nein"/></td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate total="${appointmentProfileInstanceTotal}"/>
      </div>
    </g:if>

  </div>
</div>
</body>
