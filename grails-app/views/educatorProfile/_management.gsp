<script type="text/javascript">
    $(document).ready(function() {
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

<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="educator.profile.inOut" args="[grailsApplication.config.customerName]"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#dates');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>

    <div class="zusatz-add" id="dates" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'educatorProfile', action: 'addDate', id: educator.id]" update="dates2" before="showspinner('#dates2');" after="toggle('#dates');">
            <g:textField name="date" size="12" class="datepicker" value=""/>
            <g:submitButton name="button" value="${message(code: 'add')}"/>
        </g:formRemote>
    </div>

    <div class="zusatz-show" id="dates2">
        <g:render template="dates" model="[educator: educator]"/>
    </div>
</div>