<g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'update_begin', id: projectDay.id]" update="begin" before="showspinner('#begin');">
    <g:textField name="date" required="" class="timepick" size="4" value="${formatDate(date: projectDay?.profile?.date, format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
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