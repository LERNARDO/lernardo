<g:formRemote name="formRemote" url="[controller:'dayroutine', action:'updateroutine', id:routine.id, params:[i: i]]" update="routinebox${i}">
  <table>
    <tr>
      <td class="bold"><g:message code="period"/>:</td>
      <td><g:select name="dateFromHour" from="${0..23}" value="${formatDate(date: routine?.dateFrom, format: 'HH', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>:<g:select name="dateFromMinute" from="${0..59}" value="${formatDate(date: routine?.dateFrom, format: 'mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/> <g:message code="to"/> <g:select name="dateToHour" from="${0..23}" value="${formatDate(date: routine?.dateTo, format: 'HH', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>:<g:select name="dateToMinute" from="${0..59}" value="${formatDate(date: routine?.dateTo, format: 'mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/> <g:message code="clock"/></td>
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