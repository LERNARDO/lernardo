<g:formRemote name="formRemote" url="[controller:'dayroutine', action:'updateroutine', id:routine.id, params:[i: i]]" update="routinebox${i}">
    <table>
      <tr>
        <td>
          Name: <g:textField name="title" size="25" value="${routine.title.decodeHTML()}"/><br/>
          von <g:select name="dateFromHour" from="${0..23}" value="${routine.dateFrom.getHours()}"/>:<g:select name="dateFromMinute" from="${0..59}" value="${routine.dateFrom.getMinutes()}"/> Uhr bis <g:select name="dateToHour" from="${0..23}" value="${routine.dateTo.getHours()}"/>:<g:select name="dateToMinute" from="${0..59}" value="${routine.dateTo.getMinutes()}"/> Uhr</td>
        <td>
          <g:textArea name="description" rows="4" cols="50" value="${routine.description.decodeHTML()}"/>
        </td>
      </tr>
    </table>
    <g:submitButton name="submitButton" value="${message(code:'change')}"/>
    <div class="clear"></div>
  </g:formRemote>