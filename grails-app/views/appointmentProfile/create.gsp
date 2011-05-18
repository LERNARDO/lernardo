<head>
  <meta name="layout" content="private"/>
  <title><g:message code="appointment.profile.create"/></title>
</head>
<body>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="appointment.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: appointmentProfileInstance]"/>

    <g:form>

      <div class="property">
        <g:message code="appointment.profile.fullName"/> <br/>
        <g:textField class="countable50 ${hasErrors(bean:appointmentProfileInstance,field:'profile.fullName','errors')}" size="50" name="fullName" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.fullName').decodeHTML()}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.description"/> <br/>
        <g:textArea class="${hasErrors(bean:appointmentProfileInstance,field:'profile.description','errors')}" rows="5" cols="40" name="description" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.description').decodeHTML()}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.beginDate"/> <br/>
        <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.beginDate','errors')}" size="18" name="beginDate" value="${formatDate(date: appointmentProfileInstance?.profile?.beginDate, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.endDate"/> <br/>
        <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.endDate','errors')}" size="18" name="endDate" value="${formatDate(date: appointmentProfileInstance?.profile?.beginDate, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
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
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
