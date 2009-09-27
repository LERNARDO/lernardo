
<jq:jquery>
  $('#profile-content').fullCalendar({
    header: { left:'title', center:'today month basicWeek basicDay', right:'prev,next' },
    monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
    monthNamesShort: ['Jan','Feb','März','April','Mai','Jun','Jul','Aug','Sept','Okt','Nov','Dez'],
    dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
    dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
    buttonText: {
        prev: '&nbsp;&#9668;&nbsp;', // left triangle
        next: '&nbsp;&#9658;&nbsp;', // right triangle
        today: 'heute',
        month: 'monat',
        week: 'woche',
        day: 'tag'
    },
    titleFormat: {
        month: 'MMMM yyyy',                            // September 2009
        week: "MMM d[ yyyy]{ '&#8212;'[ MMM] d yyyy}", // Sep 7 - 13 2009
        day: 'dddd, d MMM yyyy'                       // Tuesday, Sep 8, 2009
    },
    aspectRatio: 1.35,
    events: '${g.createLink (controller:"calendar", action:"events", params:[name:"$name"])}',

    eventClick: function (calEvent, jsEvent, view) {
      console.info ("got a calEvent");
      console.dir (calEvent);
      top.location.href = "${g.createLink (controller:"activity",  action:"show")}"+"/"+calEvent.id
    }
  })

</jq:jquery>
