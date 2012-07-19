<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'appointment')]"/></title>
</head>
<body>

<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'appointment')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: appointmentProfileInstance]"/>

    <g:form action="save" id="${createdFor.id}">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="title"/></td>
          <td valign="top" class="value">
            <g:textField data-counter="50" class="${hasErrors(bean:appointmentProfileInstance,field:'profile.fullName','errors')}" size="50" name="fullName" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <g:textArea class="${hasErrors(bean:appointmentProfileInstance,field:'profile.description','errors')}" rows="5" cols="50" name="description" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.description').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="begin"/></td>
          <td valign="top" class="value">
            <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.beginDate','errors')}" name="beginDate" value="${formatDate(date: appointmentProfileInstance?.profile?.beginDate, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="end"/></td>
          <td valign="top" class="value">
            <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.endDate','errors')}" name="endDate" value="${formatDate(date: appointmentProfileInstance?.profile?.endDate, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="appointment.profile.allDay"/></td>
          <td valign="top" class="value">
            <g:checkBox name="allDay" value="${appointmentProfileInstance?.profile?.allDay}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="appointment.profile.isPrivate"/></td>
          <td valign="top" class="value">
            <g:checkBox name="isPrivate" value="${appointmentProfileInstance?.profile?.isPrivate}"/>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'save')}" /></div>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="clear"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
