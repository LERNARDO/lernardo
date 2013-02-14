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

<g:if test="${date}">
    <script type="text/javascript">
        $(document).ready(function() {
            ${remoteFunction(controller: "timeRecording", action: "showRecords", update: "records", id: entity.id, params:[date: formatDate(date: date, format: "dd. MM. yy")], before: "showspinner('#records')")}
        });
    </script>
</g:if>

<h4><g:message code="privat.workday"/> - <g:remoteLink update="content" controller="timeRecording" action="report" id="${entity.id}" before="showspinner('#content');"><g:message code="report"/></g:remoteLink></h4>

<div class="boxContent">

    <div class="info-msg">
      <g:message code="privat.workday.chooseDay"/>
    </div>

    <g:formRemote name="formRemote" url="[controller: 'timeRecording', action: 'showRecords', id: entity.id]" update="records" before="showspinner('#records')">
      <g:textField name="date" size="30" value="${date ? formatDate(date: date, format: "dd. MM. yyyy") : new Date().format('dd. MM. yyyy')}" class="datepicker-birthday"/>
      <g:submitButton name="submitButton" value="OK"/>
    </g:formRemote>

    <div id="records" style="margin-top: 10px;"></div>

</div>