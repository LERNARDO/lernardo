<script type="text/javascript">
$(document).ready(function() {
  $('.datetimepicker').datetimepicker({
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
          dateFormat: 'dd. mm. yy'
        });
});
</script>

<g:textField name="date" class="datetimepicker" value="${new Date().format('dd. MM. yyyy HH:mm')}"/>