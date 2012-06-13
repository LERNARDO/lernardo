<%@ page import="at.uenterprise.erp.WorkdayCategory" %>

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

<g:formRemote name="formRemote" url="[controller: 'timeRecording', action: 'updateRecord', id: workdayUnit.id, params: [i: i, entity: entity.id]]" update="unit-${i}" before="showspinner('#unit-${i}')">

  <div class="gray" style="width: 200px; float: left;">
    <g:message code="from"/>: <g:textField name="from" class="timepick" size="4" value="${formatDate(date: workdayUnit.date1, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/> <g:message code="to"/>: <g:textField name="to" class="timepick" size="4" value="${formatDate(date: workdayUnit.date2, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
  </div>
  <div class="gray" style="width: 300px; float: left;"><g:message code="category"/>: <g:select from="${workdaycategories}" name="category" value="${WorkdayCategory.findByName(workdayUnit.category)}"/></div>
  <div class="gray" style="float: left; vertical-align: top;"><g:message code="description"/>: <g:textArea style="height: 20px;" rows="1" cols="50" name="description" value="${workdayUnit.description.decodeHTML()}"/></div>

  <g:submitButton name="button" value="${message(code:'change')}"/>

</g:formRemote>