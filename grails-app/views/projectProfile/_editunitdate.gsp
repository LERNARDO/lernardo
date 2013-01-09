<g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'updateUnitDate', id: unit.id, params: [i: i]]" update="unitDate${i}" before="showspinner('#unitDate${i}');">
    <g:textField name="time" required="" class="timepick" size="4" value="${formatDate(date: unit?.profile?.date, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
    <g:submitButton name="button" value="${message(code:'save')}"/>
</g:formRemote>

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