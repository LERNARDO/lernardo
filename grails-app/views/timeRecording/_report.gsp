<script type="text/javascript">
    $(document).ready(function() {
        $(".datepicker-birthday").datepicker({
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
            maxDate: new Date(),
            firstDay: 1,
            yearRange: 'c-99:c+99',
            showMonthAfterYear: true,
            appendText: ' (DD. MM. YYYY)',
            autoSize: true});
    });
</script>

<h4><g:remoteLink update="content" controller="timeRecording" id="${entity.id}" before="showspinner('#content');"><g:message code="privat.workday"/></g:remoteLink> - <g:message code="report"/></h4>

<div class="boxContent">

    <div class="info-msg">
      <g:message code="privat.workday.chooseRange"/>
    </div>

    <g:formRemote name="formRemote" url="[controller: 'timeRecording', action: 'showReport', id: entity.id]" update="results" before="showspinner('#results')">
      <g:textField name="date1" size="30" class="datepicker-birthday"/>
      <g:textField name="date2" size="30" class="datepicker-birthday"/>
      <g:submitButton name="submitButton" value="OK"/>
    </g:formRemote>

    <div id="results" style="margin-top: 10px">
    </div>

</div>