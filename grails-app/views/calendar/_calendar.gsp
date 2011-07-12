<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<jq:jquery>
  $('.cal').fullCalendar({
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
      monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
	  monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'],
	  dayNames: ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'],
	  dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
	  dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
      buttonText: {
        prev: '&nbsp;&#9668;&nbsp;', // left triangle
        next: '&nbsp;&#9658;&nbsp;', // right triangle
        today: 'hoy',
        month: 'mes',
        week: 'semana',
        agendaWeek : 'semana',
        agendaDay: 'dia'
      },
    </g:if>
    <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
      monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
      monthNamesShort: ['Jan','Feb','März','April','Mai','Jun','Jul','Aug','Sept','Okt','Nov','Dez'],
      dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
      dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
      buttonText: {
        prev: '&nbsp;&#9668;&nbsp;', // left triangle
        next: '&nbsp;&#9658;&nbsp;', // right triangle
        today: 'Heute',
        month: 'Monat',
        week: 'Woche',
        agendaWeek : 'Woche',
        agendaDay: 'Tag'
      },
    </g:if>
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
        week: 'ddd d.M.', // Mon 9/7
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
    %{--events: '${createLink (controller:"calendar", action:"events", params:[visibleEducators: visibleEducators])}',--}%
    %{--eventSources: '${createLink (controller:"calendar", action:"events")}',--}%
  
    eventClick: function (calEvent, jsEvent, view) {
      %{--console.info ("got a calEvent");--}%
      %{--console.dir (calEvent);--}%

      top.location.href = "${createLink (controller:"calendar", action:"destination")}"+"/"+calEvent.id
    },

    eventMouseover: function(e,m) {
				//console.log(e);
				var tPosX = m.pageX - 5 ;
				var tPosY = m.pageY + 20 ;
				$('#caltip').css({top: tPosY, left: tPosX, display: 'block'});
				var tt = '';
				tt += e.title+'<br /><br />';
				tt += e.description+'<br />';
				$('#caltip').html(tt);
			},
			eventMouseout: function() {
				$('#caltip').css({display: 'none'});
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