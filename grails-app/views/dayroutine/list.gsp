<head>
  <meta name="layout" content="database"/>
  <title>${entity.profile.fullName.decodeHTML()}: <g:message code="dayroutine"/></title>

  <g:javascript src="jquery/fullcalendar.min.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}">

  <script type="text/javascript">
    showDayRoutines = function(id){
      $('#calendar').fullCalendar('addEventSource', '${createLink (controller: "dayroutine", action: "showDayRoutines")}?id='+id);
    };

    updateRoutines = function() {
      $('.foo').slideUp(300).delay(300).queue(function() {
        $(this).remove();
      });
    }

  </script>
</head>

<body>

<div class="boxHeader">
  <h1>${entity.profile.fullName.decodeHTML()}: <g:message code="dayroutine"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <p><g:message code="dayroutine.create"/> <img onclick="toggle('#newroutine');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code:'dayroutine.create')}"/></p>
    <div id="newroutine" class="graypanel">

      <g:formRemote name="formRemote" url="[controller: 'dayroutine', action: 'save', id: entity.id]" update="dayroutine" before="showspinner('#dayroutine')">

        <table>

          <tr class="prop">
            <td class="name"><g:message code="period"/></td>
            <td class="value">
              <g:textField name="dateFrom" class="timepick" size="4"/> <g:message code="to"/> <g:textField name="dateTo" class="timepick" size="4"/> <g:message code="clock"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name">Tätigkeit</td>
            <td class="value">
              <g:textField name="title" size="30"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="description"/></td>
            <td class="value">
              <g:textArea name="description" rows="4" cols="50"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="activityInstance.profile.days"/></td>
            <td class="value">
              <g:checkBox name="monday"/> <g:message code="monday"/><br/>
              <g:checkBox name="tuesday"/> <g:message code="tuesday"/><br/>
              <g:checkBox name="wednesday"/> <g:message code="wednesday"/><br/>
              <g:checkBox name="thursday"/> <g:message code="thursday"/><br/>
              <g:checkBox name="friday"/> <g:message code="friday"/><br/>
              <g:checkBox name="saturday"/> <g:message code="saturday"/><br/>
              <g:checkBox name="sunday"/> <g:message code="sunday"/><br/>
            </td>
          </tr>

        </table>

        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <div class="clear"></div>
      </g:formRemote>

    </div>

    <div id="dayroutine">
      <g:render template="routineday" model="[routines: routines, entity: entity, day: day]"/>
    </div>

    <div id="calendar">
      <%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
      <div id="loadings" style="position: absolute; left: 50%; text-align: center; top: 50%;"></div>
      <jq:jquery>
        $('#calendar').fullCalendar({
       header: {
         left: 'false',
         center: 'false',
         right: 'false'
       },
       loading: function(bool, view) {
         if (bool)
           showspinner('#loadings');
         else
           hidespinner('#loadings');
       },
       monthNames: ['${message(code: "january")}',
                 '${message(code: "february")}',
                 '${message(code: "march")}',
                 '${message(code: "april")}',
                 '${message(code: "may")}',
                 '${message(code: "june")}',
                 '${message(code: "july")}',
                 '${message(code: "august")}',
                 '${message(code: "september")}',
                 '${message(code: "october")}',
                 '${message(code: "november")}',
                 '${message(code: "december")}'],
    monthNamesShort: ['${message(code: "january.short")}',
                     '${message(code: "february.short")}',
                     '${message(code: "march.short")}',
                     '${message(code: "april.short")}',
                     '${message(code: "may.short")}',
                     '${message(code: "june.short")}',
                     '${message(code: "july.short")}',
                     '${message(code: "august.short")}',
                     '${message(code: "september.short")}',
                     '${message(code: "october.short")}',
                     '${message(code: "november.short")}',
                     '${message(code: "december.short")}'],
    dayNames: ['${message(code: "sunday")}',
               '${message(code: "monday")}',
               '${message(code: "tuesday")}',
               '${message(code: "wednesday")}',
               '${message(code: "thursday")}',
               '${message(code: "friday")}',
               '${message(code: "saturday")}'],
    dayNamesShort: ['${message(code: "sunday.short")}',
                    '${message(code: "monday.short")}',
                    '${message(code: "tuesday.short")}',
                    '${message(code: "wednesday.short")}',
                    '${message(code: "thursday.short")}',
                    '${message(code: "friday.short")}',
                    '${message(code: "saturday.short")}'],
    buttonText: {
      prev: '&nbsp;&#9668;&nbsp;', // left triangle
      next: '&nbsp;&#9658;&nbsp;', // right triangle
      today: '${message(code: "today")}',
      month: '${message(code: "month")}',
      week: '${message(code: "week")}',
      agendaWeek : '${message(code: "week")}',
      agendaDay: '${message(code: "day")}'
    },
    firstDay: 1,
    minTime: 4,
    maxTime: 22,
    firstHour: 10,
    defaultView: 'agendaWeek',

    titleFormat: {
        agendaWeek: "MMM d[ yyyy]{ '&#8212;'[ MMM] d, yyyy}", // Sep 7 - 13 2009
        agendaDay: 'dddd, d MMM yyyy'                       // Tuesday, Sep 8, 2009
    },
    columnFormat: {
        month: 'ddd',    // Mon
        week: 'ddd', // Mon 9/7
        day: 'dddd, d.M.'  // Monday 9/7
    },
    axisFormat: ' HH:mm', // H (:mm)
    timeFormat: 'HH:mm{ - HH:mm}',
      %{--aspectRatio: 1.34,--}%
        contentHeight: 850,
       editable: false,
       allDaySlot:true,
       allDayText:'',
       weekends: true,
      %{--events: '${createLink (controller: "calendar", action: "events", params: [visibleEducators: visibleEducators])}',--}%

        eventClick: function (calEvent, jsEvent, view) {
      top.location.href = "${createLink (controller: "calendar", action: "destination")}"+"/"+calEvent.id
    },

    eventMouseover: function(e,m) {
      //console.log(e);
      var tPosX = m.pageX - 5 ;
      var tPosY = m.pageY + 20 ;
      $('#caltip').css({top: tPosY, left: tPosX, display: 'block'});
      var tt = '';
      tt += e.title+ '<br /><br />';
      tt += e.description+ '<br />';
      $('#caltip').html(tt);
    },
    eventMouseout: function() {
      $('#caltip').css({display: 'none'});
    },

    eventRender: function(event, element) {
      if (event.title == "${message (code: 'projectUnits.unplanned')}")
        element.find(".fc-event-time").prepend("<img src='${resource(dir: 'images/icons', file: 'bullet_error.png')}' height='16' width='16'/>");
    },

    })
      </jq:jquery>
    </div>

  </div>
</div>

<script type="text/javascript">
  $(function() {
    showDayRoutines('${entity.id}');
  });
</script>

</body>