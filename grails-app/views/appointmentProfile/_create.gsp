<script type="text/javascript">
    $(document).ready(function() {
        $('.datetimepicker2').datetimepicker({
            timeText: '${message(code: "time")}',
            hourText: '${message(code: "hour")}',
            minuteText: '${message(code: "minute")}',
            dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
                '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
                '${message(code: "saturday.short")}'],
            monthNames: ['${message(code: "january")}', '${message(code: "february")}', '${message(code: "march")}',
                '${message(code: "april")}', '${message(code: "may")}', '${message(code: "june")}',
                '${message(code: "july")}', '${message(code: "august")}', '${message(code: "september")}',
                '${message(code: "october")}', '${message(code: "november")}', '${message(code: "december")}'],
            dateFormat: 'dd. mm. yy,',
            timeFormat: 'hh:mm',
            stepMinute: 5
        });
    });
</script>

<h4><g:message code="object.create" args="[message(code: 'appointment')]"/></h4>

<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: appointmentProfileInstance]"/>

    <g:formRemote name="formRemote" url="[controller: 'appointmentProfile', action: 'save', id: createdFor.id]" update="content">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="title"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean:appointmentProfileInstance,field:'profile','errors')}" size="50" name="fullName" value="${fieldValue(bean:appointmentProfileInstance,field:'profile').decodeHTML()}"/>
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
          <td class="name"><g:message code="private"/></td>
          <td class="value">
            <g:checkBox name="isPrivate" value="${appointmentProfileInstance?.profile?.isPrivate}"/>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'save')}" /></div>
        <g:remoteLink update="content" class="buttonGray" action="list"><g:message code="cancel"/></g:remoteLink>
      </div>

    </g:formRemote>

</div>