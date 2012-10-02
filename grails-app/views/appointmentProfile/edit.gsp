<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'appointment')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1 style="float: left"><g:message code="object.edit" args="[message(code: 'appointment')]"/></h1>
  <div class="icons" style="text-align: right;">
    <g:link action="show" id="${appointmentProfileInstance.id}"><img src="${resource(dir: 'images/icons', file: 'icon_cancel.png')}" alt="${message(code: 'cancel')}" align="top"/></g:link>
  </div>
</div>
<div class="boxContent" style="clear: both;">

    <g:render template="/templates/errors" model="[bean: appointmentProfileInstance]"/>

    <g:form id="${appointmentProfileInstance.id}">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="title"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean:appointmentProfileInstance,field:'profile.fullName','errors')}" size="50" name="fullName" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <g:textArea class="${hasErrors(bean:appointmentProfileInstance,field:'profile.description','errors')}" rows="5" cols="50" name="description" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.description').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="begin"/></td>
          <td class="value">
            <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.beginDate','errors')}" name="beginDate" value="${formatDate(date: appointmentProfileInstance?.profile?.beginDate, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="end"/></td>
          <td class="value">
            <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.endDate','errors')}" name="endDate" value="${formatDate(date: appointmentProfileInstance?.profile?.endDate, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="appointment.profile.allDay"/></td>
          <td class="value">
            <g:checkBox name="allDay" value="${appointmentProfileInstance?.profile?.allDay}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="appointment.profile.isPrivate"/></td>
          <td class="value">
            <g:checkBox name="isPrivate" value="${appointmentProfileInstance?.profile?.isPrivate}"/>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
      </div>

    </g:form>

</div>
</body>
