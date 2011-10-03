<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.create" args="[message(code: 'appointment')]"/></title>
</head>
<body>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'appointment')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: appointmentProfileInstance]"/>

    <g:form id="${owner.id}">

      <div class="property">
        <g:message code="title"/> <br/>
        <g:textField class="countable50 ${hasErrors(bean:appointmentProfileInstance,field:'profile.fullName','errors')}" size="50" name="fullName" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.fullName').decodeHTML()}"/>
      </div>

      <div class="property">
        <g:message code="description"/> <br/>
        <g:textArea class="${hasErrors(bean:appointmentProfileInstance,field:'profile.description','errors')}" rows="5" cols="40" name="description" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.description').decodeHTML()}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.beginDate"/> <br/>
        <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.beginDate','errors')}" size="18" name="beginDate" value="${formatDate(date: appointmentProfileInstance?.profile?.beginDate, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.endDate"/> <br/>
        <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.endDate','errors')}" size="18" name="endDate" value="${formatDate(date: appointmentProfileInstance?.profile?.endDate, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.allDay"/> <br/>
        <g:checkBox name="allDay" value="${appointmentProfileInstance?.profile?.allDay}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.isPrivate"/> <br/>
        <g:checkBox name="isPrivate" value="${appointmentProfileInstance?.profile?.isPrivate}"/>
      </div>

      <div class="clear"></div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <g:link class="buttonGray" action="list" id="${currentEntity.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
