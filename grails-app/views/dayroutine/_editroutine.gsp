<script type="text/javascript">
  $(document).ready(function() {
    $('.timepick').timepicker({
      timeText: '${message(code: "time")}',
      hourText: '${message(code: "hour")}',
      minuteText: '${message(code: "minute")}',
      timeOnlyTitle: '${message(code: "chooseTime")}',
      stepMinute: 5
    });
  });
</script>

<g:formRemote name="formRemote" url="[controller: 'dayroutine', action: 'updateroutine', id: routine.id, params: [i: i]]" update="routinebox${i}">
  <table>
    <tr>
      <td class="bold"><g:message code="period"/>:</td>
      <td><g:textField name="dateFrom" class="timepick" size="4" value="${formatDate(date: routine.dateFrom, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/> <g:message code="to"/> <g:textField name="dateTo" class="timepick" size="4" value="${formatDate(date: routine.dateTo, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/> <g:message code="clock"/></td>
    </tr>
    <tr>
      <td class="bold" style="width: 150px;"><g:message code="work"/>:</td>
      <td><g:textField name="title" size="30" value="${routine.title.decodeHTML()}"/></td>
    </tr>
    <tr>
      <td class="bold"><g:message code="description"/>:</td>
      <td><g:textArea name="description" rows="4" cols="50" value="${routine.description.decodeHTML()}"/></td>
    </tr>
  </table>
  <g:submitButton name="submitButton" value="${message(code:'change')}"/>
  <div class="clear"></div>
</g:formRemote>