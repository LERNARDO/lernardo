<script type="text/javascript">
  $(document).ready(function() {
    $('.timepick').timepicker({
      timeText: '${message(code: "time")}',
      hourText: '${message(code: "hour")}',
      minuteText: '${message(code: "minute")}',
      timeOnlyTitle: '${message(code: "chooseTime")}',
      stepMinute: 5
    });

    $(".datepicker").datepicker({
      monthNamesShort: ['${message(code: "january.short")}', '${message(code: "february.short")}', '${message(code: "march.short")}',
        '${message(code: "april.short")}', '${message(code: "may.short")}', '${message(code: "june.short")}',
        '${message(code: "july.short")}', '${message(code: "august.short")}', '${message(code: "september.short")}',
        '${message(code: "october.short")}', '${message(code: "november.short")}', '${message(code: "december.short")}'],
      dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
        '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
        '${message(code: "saturday.short")}'],
      changeMonth: true,
      changeYear: true,
      dateFormat: 'dd. mm. yy',
      minDate: new Date(1900, 1, 1),
      firstDay: 1,
      autoSize: true});

  });
</script>

<g:message code="begin"/> <g:textField name="periodStart" size="10" class="datepicker ${hasErrors(bean: ac, field: 'periodStart', 'errors')}" value="${formatDate(date: ac?.periodStart, format: 'dd. MM. yyyy')}"/>
<g:message code="end"/> <g:textField name="periodEnd" size="10" class="datepicker ${hasErrors(bean: ac, field: 'periodEnd', 'errors')}" value="${formatDate(date: ac?.periodEnd, format: 'dd. MM. yyyy')}"/>

<table width="100%" class="${hasErrors(bean: ac, field: 'weekdays', 'errors')}">
  <tr>
    <td colspan="7" class="label">Bitte die Wochentage mit Beginnzeit auswählen!</td>
  </tr>
  <tr>
    <td style="padding: 6px;">
      <div style="margin-bottom: 3px;"><g:checkBox name="monday" value="${ac?.monday}"/> <g:message code="monday"/></div>
      <g:textField name="mondayStart" class="timepick ${hasErrors(bean: ac, field: 'mondayStart', 'errors')}" size="4" value="${formatDate(date: ac?.mondayStart, format: 'HH:mm')}"/>
    </td>
    <td style="padding: 6px;">
      <div style="margin-bottom: 3px;"><g:checkBox name="tuesday" value="${ac?.tuesday}"/> <g:message code="tuesday"/></div>
      <g:textField name="tuesdayStart" class="timepick ${hasErrors(bean: ac, field: 'tuesdayStart', 'errors')}" size="4" value="${formatDate(date: ac?.tuesdayStart, format: 'HH:mm')}"/>
    </td>
    <td style="padding: 6px;">
      <div style="margin-bottom: 3px;"><g:checkBox name="wednesday" value="${ac?.wednesday}"/> <g:message code="wednesday"/></div>
      <g:textField name="wednesdayStart" class="timepick ${hasErrors(bean: ac, field: 'wednesdayStart', 'errors')}" size="4" value="${formatDate(date: ac?.wednesdayStart, format: 'HH:mm')}"/>
    </td>
    <td style="padding: 6px;">
      <div style="margin-bottom: 3px;"><g:checkBox name="thursday" value="${ac?.thursday}"/> <g:message code="thursday"/></div>
      <g:textField name="thursdayStart" class="timepick ${hasErrors(bean: ac, field: 'thursdayStart', 'errors')}" size="4" value="${formatDate(date: ac?.thursdayStart, format: 'HH:mm')}"/>
    </td>
    <td style="padding: 6px;">
      <div style="margin-bottom: 3px;"><g:checkBox name="friday" value="${ac?.friday}"/> <g:message code="friday"/></div>
      <g:textField name="fridayStart" class="timepick ${hasErrors(bean: ac, field: 'fridayStart', 'errors')}" size="4" value="${formatDate(date: ac?.fridayStart, format: 'HH:mm')}"/>
    </td>
    <td style="padding: 6px;">
      <div style="margin-bottom: 3px;"><g:checkBox name="saturday" value="${ac?.saturday}"/> <g:message code="saturday"/></div>
      <g:textField name="saturdayStart" class="timepick ${hasErrors(bean: ac, field: 'saturdayStart', 'errors')}" size="4" value="${formatDate(date: ac?.saturdayStart, format: 'HH:mm')}"/>
    </td>
    <td style="padding: 6px;">
      <div style="margin-bottom: 3px;"><g:checkBox name="sunday" value="${ac?.sunday}"/> <g:message code="sunday"/></div>
      <g:textField name="sundayStart" class="timepick ${hasErrors(bean: ac, field: 'sundayStart', 'errors')}" size="4" value="${formatDate(date: ac?.sundayStart, format: 'HH:mm')}"/>
    </td>
  </tr>
</table>