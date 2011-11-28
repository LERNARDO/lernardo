<head>
  <title><g:message code="cal.title"/></title>
  <meta name="layout" content="private" />

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
            hideBigSpinner();
          }
          else if (result == "false") {
            $('#calendar').fullCalendar('removeEventSource', '${createLink (controller: "calendar", action: "togglePerson")}?id='+id);
            hideBigSpinner();
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
            hideBigSpinner();
          }
          else if (result == "false") {
            $('#calendar').fullCalendar('removeEventSource', '${createLink (controller: "calendar", action: "toggleThemes")}');
            hideBigSpinner();
          }
        }
      });

    };
  </script>
</head>

<body>

<div id="caltip"></div>

<div id="cal-left">

  <h1><g:message code="imgmenu.calendar.name"/></h1>

  <erp:getActiveCalPerson id="${currentEntity.id}">
    <div class="calenderperson">
      <table style="width: 100%;">
        <tr>
          <td>
            <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); togglePerson('person','${currentEntity.id}','-1'); return false;">
              <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${currentEntity.id}','${i}','${active}');"/>
              <div id="personcolor-1" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${currentEntity.profile.color ?: '#ccc'}; background-color: ${currentEntity.profile.color ?: '#ccc'};"></div> <erp:truncate string="${currentEntity.profile.fullName}"/></div>
              <div id="personcolor-1-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${currentEntity.profile.fullName}"/></div>
            </a>
          </td>
        </tr>
      </table>
    </div>
  </erp:getActiveCalPerson>
  <div class="calenderperson">
    <table style="width: 100%;">
      <tr>
        <td>
          <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); toggleThemes(); return false;">
            <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialThemes('${currentEntity.profile.calendar.showThemes}');"/>
            <div id="theme1" style="display: ${currentEntity.profile.calendar.showThemes ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #000; background-color: #000;"></div> <g:message code="themes"/></div>
            <div id="theme2" style="display: ${currentEntity.profile.calendar.showThemes ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <g:message code="themes"/></div>
          </a>
        </td>
      </tr>
    </table>
  </div>

  <div style="border-bottom: 1px solid #ddd; margin: 5px 0;"></div>

  <div style="font-size: 12px; margin: 0 0 5px 10px;"><g:message code="operators"/></div>

  <g:each in="${operators}" var="operator" status="i">
    <erp:getActiveCalPerson id="${operator.id}">
      <div class="calenderperson">
        <table style="width: 100%;">
          <tr>
            <td>
              <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); togglePerson('operator','${operator.id}','${i}'); return false;">
                <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${operator.id}','${i}','${active}');"/>
                <div id="operatorcolor${i}" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${operator.profile.color ?: '#ccc'}; background-color: ${operator.profile.color ?: '#ccc'};"></div> <erp:truncate string="${operator.profile.fullName}"/></div>
                <div id="operatorcolor${i}-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${operator.profile.fullName}"/></div>
              </a>
            </td>
          </tr>
        </table>
      </div>
    </erp:getActiveCalPerson>
  </g:each>

  <div style="border-bottom: 1px solid #ddd; margin: 5px 0;"></div>

  <div style="font-size: 12px; margin: 0 0 5px 10px;"><g:message code="educators"/></div>

  <div style="margin: 10px 0 0 8px; font-size: 12px;">
    <g:formRemote name="form" url="[controller: 'calendar', action: 'sort']" update="results">
      <g:select name="sort" from="['first', 'last']" valueMessagePrefix="sortBy"/>
      <g:submitButton name="submit" value="OK"/>
    </g:formRemote>
  </div>

  <div id="results">
    <g:each in="${educators}" var="educator" status="i">
      <erp:getActiveCalPerson id="${educator.id}">
        <div class="calenderperson">
          <table style="width: 100%;">
            <tr>
              <td>
                <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); togglePerson('person','${educator.id}','${i}'); return false;">
                  <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${educator.id}','${i}','${active}');"/>
                  <div id="personcolor${i}" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${educator.profile.color ?: '#ccc'}; background-color: ${educator.profile.color ?: '#ccc'};"></div> <erp:truncate string="${educator.profile.fullName}"/></div>
                  <div id="personcolor${i}-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${educator.profile.fullName}"/></div>
                </a>
              </td>
            </tr>
          </table>
        </div>
      </erp:getActiveCalPerson>
    </g:each>
  </div>
  %{--<div class="clear"></div>--}%
</div>

<div style="margin: 0 0 15px 0; float: left; width: 650px;" id="calendar">
  <g:render template="calendar"/>
</div>

</body>



