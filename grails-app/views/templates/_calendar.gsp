<jq:jquery>
  $('.cal').fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
    monthNamesShort: ['Jan','Feb','März','April','Mai','Jun','Jul','Aug','Sept','Okt','Nov','Dez'],
    dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
    dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
    firstDay: 1,
    minTime: 4,
    maxTime: 22,
    firstHour: 10,
    defaultView: 'agendaWeek',
    buttonText: {
        prev: '&nbsp;&#9668;&nbsp;', // left triangle
        next: '&nbsp;&#9658;&nbsp;', // right triangle
        today: 'Heute',
        month: 'Monat',
        week: 'Woche',
        agendaWeek : 'Woche',
        agendaDay: 'Tag'
    },
    titleFormat: {
        agendaWeek: "MMM d[ yyyy]{ '&#8212;'[ MMM] d, yyyy}", // Sep 7 - 13 2009
        agendaDay: 'dddd, d MMM yyyy'                       // Tuesday, Sep 8, 2009
    },
    columnFormat: {
        month: 'ddd',    // Mon
        week: 'ddd d.M.', // Mon 9/7
        day: 'dddd, d.M.'  // Monday 9/7     
    },
    axisFormat: ' HH:mm', // H (:mm)
    timeFormat: 'HH:mm',
    aspectRatio: 1.34,
    editable: false,
    allDaySlot:true,
    allDayText:'',
    weekends: true,
    events: '${g.createLink (controller:"calendar", action:"events", id:id)}',
  
    eventClick: function (calEvent, jsEvent, view) {
      %{--console.info ("got a calEvent");--}%
      %{--console.dir (calEvent);--}%

      top.location.href = "${g.createLink (controller:"calendar",  action:"destination")}"+"/"+calEvent.id
    },

    dayClick: function (dayDate, allDay, jsEvent, view) {
      %{--elem = jQuery(view.element).parent().parent();--}%
      elem = jQuery('#profile-content') ;
     if (view.name == 'month')
       elem.fullCalendar('gotoDate', dayDate).fullCalendar('changeView', 'agendaWeek')  ;
     else if (view.name == 'agendaWeek')
       elem.fullCalendar('gotoDate', dayDate).fullCalendar('changeView', 'agendaDay')  ;
    }

  })
</jq:jquery>