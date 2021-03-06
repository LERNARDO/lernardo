<head>
  <title><g:message code="cal.title"/></title>
  <meta name="layout" content="start" />

  <g:javascript src="jquery/fullcalendar.min.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}">

  <script type="text/javascript">

    showInitialEvents = function(id, i, active){
      if (active == "true")
        $('#calendar').fullCalendar('addEventSource', '${createLink (controller: "calendar", action: "togglePerson")}?id='+id);
    };

    showInitialThemes = function(active){
        if (active == "true")
          $('#calendar').fullCalendar('addEventSource', '${createLink (controller: "calendar", action: "toggleThemes")}');
      };

    togglePerson = function(element, id, i){
      $('#' + element + 'color' + i).toggle();
      $('#' + element + 'color' + i + '-2').toggle();

      $.ajax({
        url: '${createLink (controller: "calendar", action: "togglePersonInCal")}?_='+new Date().getTime(),
        dataType: 'text',
        data: "id="+id,
        //cache: false,
        success: function(result) {
          if (result == "true") {
            $('#calendar').fullCalendar('addEventSource', '${createLink (controller: "calendar", action: "togglePerson")}?id='+id);
          }
          else if (result == "false") {
            $('#calendar').fullCalendar('removeEventSource', '${createLink (controller: "calendar", action: "togglePerson")}?id='+id);
          }
        }
      });

    };

    toggleThemes = function(){
      $('#theme1').toggle();
      $('#theme2').toggle();

      $.ajax({
        url: '${createLink (controller: "calendar", action: "toggleThemesInCal")}?_='+new Date().getTime(),
        dataType: 'text',
        success: function(result) {
          if (result == "true") {
            $('#calendar').fullCalendar('addEventSource', '${createLink (controller: "calendar", action: "toggleThemes")}');
          }
          else if (result == "false") {
            $('#calendar').fullCalendar('removeEventSource', '${createLink (controller: "calendar", action: "toggleThemes")}');
          }
        }
      });

    };
  </script>
</head>

<body>

<div id="caltip"></div>

<table width="100%" style="margin-top: 15px;">
  <tr>
    <td style="padding-right: 15px; vertical-align: top; width: 220px;">

      <div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; text-align: center; color: #36808E; font-size: 16px; margin-bottom: 6px;"><g:message code="imgmenu.calendar.name"/></div>

        <div style="margin: 0 auto; width: 120px;">
            <div class="buttons cleared">
                <a style="width: 110px" class="buttonGreen" href="" onclick="$('#modal-calendar').modal(); return false;"><g:message code="object.create" args="[message(code: 'appointment')]"/></a>
            </div>
        </div>

      <div class="calenderperson">
        <table style="width: 100%;">
          <tr>
            <td>
              <a style="display: block; text-decoration: none;" href="#" onclick="toggleThemes(); return false;">
                <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialThemes('${currentEntity.profile.calendar.showThemes}');"/>
                <div id="theme1" style="display: ${currentEntity.profile.calendar.showThemes ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #000; background-color: #000;"></div> <g:message code="themes"/></div>
                <div id="theme2" style="display: ${currentEntity.profile.calendar.showThemes ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <g:message code="themes"/></div>
              </a>
            </td>
          </tr>
        </table>
      </div>

      <div style="border-bottom: 1px solid #ddd; margin: 5px 0;"></div>

      <g:remoteField style="margin: 10px 0 0 8px; font-size: 12px;" placeholder="${message(code: 'addPerson')}" size="30" name="instantSearch" update="calender-results" paramName="name" url="[controller: 'calendar', action: 'search', params: [child: 'yes', client: 'yes', educator: 'yes', operator: 'yes', parent: 'yes', partner: 'yes', pate: 'yes', user: 'yes']]" before="showspinner('#calender-results')" />
      <div style="margin: 10px 0 0 8px; font-size: 12px;" class="membersearch-results" id="calender-results"></div>

      <div id="results">
        <g:render template="educators" model="[calEntities: calEntities]"/>
      </div>

    </td>
    <td>
      <div style="margin: 0 0 15px 0;" id="calendar">
        <g:render template="calendar"/>
      </div>
    </td>
  </tr>
</table>

</body>



