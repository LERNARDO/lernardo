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

<g:formRemote name="updateAttendance" update="attendance${i}" url="[action: 'updateAttendance', id: attendance.id, params: [i: i]]">
  <table class="default-table">
      <tr>
        <td valign="top" width="250px">${attendance.client.profile}</td>
        <td width="500px">
          <table class="simpleTable">
            <tr>
                <th>&nbsp;</th>
                <th><g:message code="monday.short"/></th>
                <th><g:message code="tuesday.short"/></th>
                <th><g:message code="wednesday.short"/></th>
                <th><g:message code="thursday.short"/></th>
                <th><g:message code="friday.short"/></th>
                <th><g:message code="saturday.short"/></th>
                <th><g:message code="sunday.short"/></th>
            </tr>
            <tr>
                <td>Anwesend?</td>
                <td><g:checkBox name="monday" value="${attendance.monday}"/></td>
                <td><g:checkBox name="tuesday" value="${attendance.tuesday}"/></td>
                <td><g:checkBox name="wednesday" value="${attendance.wednesday}"/></td>
                <td><g:checkBox name="thursday" value="${attendance.thursday}"/></td>
                <td><g:checkBox name="friday" value="${attendance.friday}"/></td>
                <td><g:checkBox name="saturday" value="${attendance.saturday}"/></td>
                <td><g:checkBox name="sunday" value="${attendance.sunday}"/></td>
            </tr>
            <tr>
                <td><g:message code="from"/></td>
                <td><g:textField name="mondayFrom" class="timepick" size="4" value="${formatDate(date: attendance.mondayFrom, format: 'HH:mm')}"/></td>
                <td><g:textField name="tuesdayFrom" class="timepick" size="4" value="${formatDate(date: attendance.tuesdayFrom, format: 'HH:mm')}"/></td>
                <td><g:textField name="wednesdayFrom" class="timepick" size="4" value="${formatDate(date: attendance.wednesdayFrom, format: 'HH:mm')}"/></td>
                <td><g:textField name="thursdayFrom" class="timepick" size="4" value="${formatDate(date: attendance.thursdayFrom, format: 'HH:mm')}"/></td>
                <td><g:textField name="fridayFrom" class="timepick" size="4" value="${formatDate(date: attendance.fridayFrom, format: 'HH:mm')}"/></td>
                <td><g:textField name="saturdayFrom" class="timepick" size="4" value="${formatDate(date: attendance.saturdayFrom, format: 'HH:mm')}"/></td>
                <td><g:textField name="sundayFrom" class="timepick" size="4" value="${formatDate(date: attendance.sundayFrom, format: 'HH:mm')}"/></td>
            </tr>
            <tr>
                <td><g:message code="to"/></td>
                <td><g:textField name="mondayTo" class="timepick" size="4" value="${formatDate(date: attendance.mondayTo, format: 'HH:mm')}"/></td>
                <td><g:textField name="tuesdayTo" class="timepick" size="4" value="${formatDate(date: attendance.tuesdayTo, format: 'HH:mm')}"/></td>
                <td><g:textField name="wednesdayTo" class="timepick" size="4" value="${formatDate(date: attendance.wednesdayTo, format: 'HH:mm')}"/></td>
                <td><g:textField name="thursdayTo" class="timepick" size="4" value="${formatDate(date: attendance.thursdayTo, format: 'HH:mm')}"/></td>
                <td><g:textField name="fridayTo" class="timepick" size="4" value="${formatDate(date: attendance.fridayTo, format: 'HH:mm')}"/></td>
                <td><g:textField name="saturdayTo" class="timepick" size="4" value="${formatDate(date: attendance.saturdayTo, format: 'HH:mm')}"/></td>
                <td><g:textField name="sundayTo" class="timepick" size="4" value="${formatDate(date: attendance.sundayTo, format: 'HH:mm')}"/></td>
            </tr>
        </table>
        <div style="text-align: right; margin-top: 5px;">
          <g:submitButton name="submit" value="OK"/>
        </div>
      </td>
    </tr>
  </table>
</g:formRemote>
