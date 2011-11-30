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

<table width="100%">
  <tr>
    <td style="padding-right: 15px; vertical-align: top; width: 250px;">

      <h1><g:message code="imgmenu.calendar.name"/></h1>

      <erp:getActiveCalPerson id="${currentEntity.id}">
        <div class="calenderperson">
          <table style="width: 100%;">
            <tr>
              <td>
                <a class="name" style="display: block; text-decoration: none;" href="#" onclick="togglePerson('person','${currentEntity.id}','-1'); return false;">
                  <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${currentEntity.id}','${i}','${active}');"/>
                  <div id="personcolor-1" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${currentEntity.profile.color ?: '#ccc'}; background-color: ${currentEntity.profile.color ?: '#ccc'};"></div> <erp:truncate string="${currentEntity.profile.fullName.decodeHTML()}"/></div>
                  <div id="personcolor-1-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${currentEntity.profile.fullName.decodeHTML()}"/></div>
                </a>
              </td>
              <td width="35">
                <a href="#" onclick="$('#colorme').toggle();"><img class="calendercolorpicker" src="${resource(dir: 'images/icons', file: 'bullet_arrow_down.png')}" alt="options" style="top: 2px; position: relative"/></a>
              </td>
            </tr>
          </table>
        </div>
        <div id="colorme" style="display: none; background: #eee; padding: 10px;">
          <g:form controller="profile" action="updateColor" id="${currentEntity.id}">
            <g:textField name="color" value="${currentEntity.profile.color ?: '#FFFFFF'}" class="kolorPicker"/>
            <g:submitButton name="submit" value="OK"/>
          </g:form>
        </div>
      </erp:getActiveCalPerson>
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

      <div style="font-size: 12px; margin: 0 0 5px 10px;"><g:message code="operators"/></div>

      <g:each in="${operators}" var="operator" status="i">
        <erp:getActiveCalPerson id="${operator.id}">
          <div class="calenderperson">
            <table style="width: 100%;">
              <tr>
                <td>
                  <a style="display: block; text-decoration: none;" href="#" onclick="togglePerson('operator','${operator.id}','${i}'); return false;">
                    <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${operator.id}','${i}','${active}');"/>
                    <div id="operatorcolor${i}" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${operator.profile.color ?: '#ccc'}; background-color: ${operator.profile.color ?: '#ccc'};"></div> <erp:truncate string="${operator.profile.fullName}"/></div>
                    <div id="operatorcolor${i}-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${operator.profile.fullName}"/></div>
                  </a>
                </td>
                <td width="35">
                  <a href="#" onclick="$('#colorop${i}').toggle();"><img class="calendercolorpicker" src="${resource(dir: 'images/icons', file: 'bullet_arrow_down.png')}" alt="options" style="top: 2px; position: relative"/></a>
                </td>
              </tr>
            </table>
          </div>
          <div id="colorop${i}" style="display: none; background: #eee; padding: 10px;">
            <g:form controller="profile" action="updateColor" id="${operator.id}">
              <g:textField name="color" value="${operator.profile.color ?: '#FFFFFF'}" class="kolorPicker"/>
              <g:submitButton name="submit" value="OK"/>
            </g:form>
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
                    <a style="display: block; text-decoration: none;" href="#" onclick="togglePerson('person','${educator.id}','${i}'); return false;">
                      <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${educator.id}','${i}','${active}');"/>
                      <div id="personcolor${i}" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${educator.profile.color ?: '#ccc'}; background-color: ${educator.profile.color ?: '#ccc'};"></div> <erp:truncate string="${educator.profile.fullName}"/></div>
                      <div id="personcolor${i}-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${educator.profile.fullName}"/></div>
                    </a>
                  </td>
                  <td width="35">
                    <a href="#" onclick="$('#colored${i}').toggle();"><img class="calendercolorpicker" src="${resource(dir: 'images/icons', file: 'bullet_arrow_down.png')}" alt="options" style="top: 2px; position: relative"/></a>
                  </td>
                </tr>
              </table>
            </div>
            <div id="colored${i}" style="display: none; background: #eee; padding: 10px;">
              <g:form controller="profile" action="updateColor" id="${educator.id}">
                <g:textField name="color" value="${educator.profile.color ?: '#FFFFFF'}" class="kolorPicker"/>
                <g:submitButton name="submit" value="OK"/>
              </g:form>
            </div>
          </erp:getActiveCalPerson>
        </g:each>
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



