<head>
  <title><g:message code="cal.title"/></title>
  <meta name="layout" content="private-cal" />
</head>

<body>

<div id="caltip"></div>

  %{--<div class="boxHeader">
    <div class="second">
      <h1><g:message code="cal.caption"/></h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <div style="margin: 5px 0 5px 0">
        <span style="background: #5b5; padding: 5px; color: #fff; -moz-border-radius: 2px; margin: 0 3px 0 0;"><g:message code="cal.theme"/></span>
        <span style="background: #55b; padding: 5px; color: #fff; -moz-border-radius: 2px; margin: 0 3px 0 0;"><g:message code="cal.groupActivity"/></span>
        <span style="background: #b55; padding: 5px; color: #fff; -moz-border-radius: 2px; margin: 0 3px 0 0;"><g:message code="cal.activityInstance"/></span>
        <span style="background: #bb5; padding: 5px; color: #fff; -moz-border-radius: 2px; margin: 0 3px 0 0;"><g:message code="cal.projectUnit"/></span>
      </div>
    </div>
  </div>--}%

  <div class="boxHeader">
    <div class="second">
      <h1><g:message code="educators"/></h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <g:each in="${educators}" var="educator" status="i">
        <erp:getActiveEducator id="${educator.id}">
          <div class="calendereducator">
            <a style="display: block; color: #000; text-decoration: none;" href="#" onclick="togglePerson('${educator.id}','${i}'); return false"><img src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="toolTip" align="top"/> ${educator.profile.fullName}</a><div id="educatorcolor${i}" style="background: ${grailsApplication.config.colors[i]}; display: ${active ? 'block' : 'none'}; height: 22px; margin: -22px 0 0 0;"></div>
            %{--<g:remoteLink update="calendar" style="display: block; color: #000; text-decoration: none;" controller="calendar" action="updatecalendar" id="${educator.id}" before="ftoggle('#educatorcolor${i}')"><img src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="toolTip" align="top"/> ${educator.profile.fullName}</g:remoteLink><div id="educatorcolor${i}" style="background: ${grailsApplication.config.colors[i]}; display: ${active ? 'block' : 'none'}; height: 22px; margin: -22px 0 0 0;"></div>--}%
          </div>
        </erp:getActiveEducator>
      </g:each>
      <div class="clear"></div>
    </div>
  </div>
<div id="blabla"></div>

  <p>
    <g:checkBox name="showThemes" value="${currentEntity.profile.calendar.showThemes}" onclick="toggleThemes()"/> Zeige Themen
  </p>

  <div class="boxHeader">
    <div class="second">
      <h1><g:message code="imgmenu.calendar.name"/></h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second cal" id="calendar">
        <g:render template="calendar" model="[visibleEducators: visibleEducators]"/>
    </div>
  </div>

<script type="text/javascript">
  togglePerson = function(id, i){
    ftoggle('#educatorcolor' + i);

    $.ajax({
      url: '/lernardo/calendar/addOrRemove',
      dataType: 'text',
      data: "id="+id,
      success: function(result) {
        if (result == "true") {
          $('.cal').fullCalendar('addEventSource', '${createLink (controller:"calendar", action:"togglePerson")}?id='+id+'&i='+i);
        }
        else if (result == "false") {
          $('.cal').fullCalendar('removeEventSource', '${createLink (controller:"calendar", action:"togglePerson")}?id='+id+'&i='+i);
        }
      }
    });

  };

  toggleThemes = function(){

    $.ajax({
      url: '/lernardo/calendar/toggleT',
      dataType: 'text',
      success: function(result) {
        if (result == "true") {
          $('.cal').fullCalendar('addEventSource', '${createLink (controller:"calendar", action:"toggleThemes")}');
        }
        else if (result == "false") {
          $('.cal').fullCalendar('removeEventSource', '${createLink (controller:"calendar", action:"toggleThemes")}');
        }
      }
    });

  };
</script>
</body>

