<%@ page import="org.grails.plugins.jquery.calendar.domain.CalendarEventType" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Kalender: Lernardo Gesamt</title>
    <meta name="layout" content="private" />
    <jqueryCalendar:monthResources />
  </head>

  <body>
    <g:link controller="calendar" action="showall_month">Monatsansicht</g:link><br/>
    <g:link controller="calendar" action="showall_week">Wochenansicht</g:link><br/>
    <g:link controller="calendar" action="showall_day">Tagesansicht</g:link><br/>
    
      <div id="message" class="ui-corner-all"></div>
<g:select
        name="eventType"
        from="${CalendarEventType.list()}"
        optionKey="id"
        noSelection="['': message(code: 'view.calendarEvent.eventType.choose')]"
        valueMessagePrefix="calendarEventType" />

<jqueryCalendar:month
        year="${year}"
        data="javascript:function(start, end, callback) {filterMonthSource(start, end, callback);}"
        month="${month}"
        weekStart="${1}"
        draggable="${true}"
        readonly="${readOnly}"
        fixedWeeks="${true}"
        abbrevDayHeadings="${false}"
        title="${true}"
        showTime="guess" />
<script type="text/javascript">
    function filterMonthSource(start, end, callback) {
         var data = {
            'start': start.getTime(),
            'end': end.getTime(),
            'eventType': $('#eventType').val()
        }
        var tmpCallback = function(result) {
            if (result.length > 0) {
                hideMessage();
            } else {
                monthNoEvents();
            }
            callback(result);
        }
        $.post($MONTH_URL['events'], data, tmpCallback, "json");
    }

    $("#eventType").change(function() {
        $monthCalendar.fullCalendar("refresh");
    });
</script>

  </body>
</html>