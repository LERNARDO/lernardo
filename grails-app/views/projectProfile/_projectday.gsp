<script type="text/javascript">
  $(document).ready(function() {
    $('.datetimepicker').datetimepicker({
      timeText: '${message(code: "time")}',
      hourText: '${message(code: "hour")}',
      minuteText: '${message(code: "minute")}',
      dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
                    '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
                    '${message(code: "saturday.short")}'],
      monthNames: ['${message(code: "january")}', '${message(code: "february")}', '${message(code: "march")}',
                   '${message(code: "april")}', '${message(code: "may")}', '${message(code: "june")}',
                   '${message(code: "july")}', '${message(code: "august")}', '${message(code: "september")}',
                   '${message(code: "october")}', '${message(code: "november")}', '${message(code: "december")}'],
      dateFormat: 'dd. mm. yy'
    });

      $('.timepick').timepicker({
          timeText: '${message(code: "time")}',
          hourText: '${message(code: "hour")}',
          minuteText: '${message(code: "minute")}',
          timeOnlyTitle: '${message(code: "chooseTime")}',
          stepMinute: 5
      });

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

      $('#calendar').fullCalendar({
          header: false,
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
          defaultView: 'agendaDay',

          titleFormat: {
              agendaWeek: "MMM d[ yyyy]{ '&#8212;'[ MMM] d, yyyy}", // Sep 7 - 13 2009
              agendaDay: 'dddd, d MMM yyyy'                       // Tuesday, Sep 8, 2009
          },
          columnFormat: {
              month: 'ddd',    // Mon
              week: 'ddd d.M.', // Mon 9/7
              day: '' //dddd, d.M.'  // Monday 9/7
          },
          axisFormat: ' HH:mm', // H (:mm)
          timeFormat: 'HH:mm{ - HH:mm}',
          %{--aspectRatio: 1.34,--}%
          contentHeight: 850,
          editable: false,
          allDaySlot:false,
          allDayText:'',
          weekends: true,

          eventClick: function (calEvent, jsEvent, view) {
              $('.unitBox').hide();
              $('#unit' + calEvent.id).show();
              //top.location.href = "${createLink (controller: "calendar", action: "destination")}"+"/"+calEvent.id
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

          dayClick: function (date, allDay, jsEvent, view) {
              $('#time').val($.fullCalendar.formatDate(date, "HH:mm"));
              $('#duration').val(60);
              $('#modal-calendar').modal();
          }

      });

  });

  addUnit = function(id){
      $('#calendar').fullCalendar('addEventSource', '${createLink (controller: "projectDayProfile", action: "toggleUnitCal")}?id='+id);
  };

</script>

<div class="projectday-container">

  <erp:accessCheck types="['Betreiber']" creatorof="${project}">
    <g:if test="${projectDays.size() > 1}">
      <div class="buttons cleared">
        <g:link class="buttonRed" controller="projectProfile" action="deleteProjectDay" id="${day.id}" params="[project: project.id]" onclick="return confirm('${message(code: 'sure')}');"><g:message code="projectDayDelete"/></g:link>
      </div>
    </g:if>
  </erp:accessCheck>

  <p>
    <span class="gray"><g:message code="projectDayComplete"/>:</span> <g:checkBox name="checkbox" value="${projectDay.profile.complete}" onclick="${remoteFunction(update: 'projectDay', controller: 'projectDayProfile', action: 'completeDay', id: projectDay.id, params: [project: project.id])}"/>
  </p>
  <p>
    <span class="gray"><g:message code="projectDayBegin"/>:</span> <span id="begin"><g:render template="show_begin" model="[projectDay: projectDay]"/></span>
  </p>
  <p>
    <span class="gray"><g:message code="projectDayEnd"/>:</span> <span id="end"><g:render template="show_end" model="[projectDay: projectDay]"/></span>
  </p>

  <g:message code="projectDayMove"/>:
  <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'moveProjectDay', id: projectDay.id]" update="projectDay" before="showspinner('#projectDay')">
    <table>
      <tr>
        <td style="padding: 5px 10px 0 0;"><g:textField name="date" class="datepicker" value="${formatDate(date: projectDay.profile.date, format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/></td>
        <td><g:submitButton name="button" value="${message(code:'change')}"/></td>
      </tr>
    </table>
  </g:formRemote>
  <g:if test="${outOfRange}">
    <span class="italic red">Dieses Datum liegt außerhalb des Projektzeitraums!</span>
  </g:if>
  <g:if test="${conflictingDate}">
    <span class="italic red">An diesem Datum gibt es bereits einen anderen Projekttag!</span>
  </g:if>

    <table>
        <tr>
            <td style="width: 600px;"><div id="calendar" style="width: 600px;"></div></td>
            <td style="width: 500px; vertical-align: top;"><div id="unit_info" style="margin-left: 10px;"><div id="units2">
                <erp:getProjectDayUnits projectDay="${projectDay}">
                    <g:render template="units" model="[units: units, project: project, projectDay: projectDay, allParents: allParents, allPartners: allPartners]"/>
                </erp:getProjectDayUnits>
            </div></div></td>
        </tr>
    </table>

  %{--<h5><g:message code="projectUnits"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#units');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
  <div id="units" style="display:none;">
    <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'addUnit', id: projectDay.id]" update="units2" before="showspinner('#units2')">
      <table>
        <tr>
          <td style="padding: 5px 10px 0 0;"><g:textField required="" size="25" name="unit" value=""/>--}%%{--<g:select name="unit" from="${units}" optionKey="id" optionValue="profile"/>--}%%{--</td>
          <td><span class="gray"><g:message code="time"/>:</span> <g:textField name="time" required="" class="timepick" size="4" value=""/></td>
          <td style="padding-left: 10px;"><span class="gray"><g:message code="duration"/>:</span> <g:textField name="duration" required="" size="4" value=""/> <span class="gray">(<g:message code="minutes"/>)</span></td>
          <td style="padding-left: 10px;"><g:submitButton name="button" value="${message(code:'add')}"/></td>
        </tr>
      </table>
    </g:formRemote>
  </div>--}%

  <div class="zusatz">
    <h5><g:message code="educators"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#educators');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div id="educators" style="display:none">

      <g:message code="search"/>:<br/>
      <erp:remoteField name="remoteField" size="40" update="educatorresults" action="remoteEducatorsDay" id="${project.id}" params="[projectDay: projectDay.id]" before="showspinner('#educatorresults')"/>
      <div id="educatorresults"></div>

    </div>

    <div id="educators2">
      <erp:getProjectDayEducators projectDay="${projectDay}">
        <g:render template="educatorsday" model="[educators: educators, project: project, projectDay: projectDay]"/>
      </erp:getProjectDayEducators>
    </div>
  </div>

  <div class="zusatz">
    <h5><g:message code="substitutes"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#substitutes');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div id="substitutes" style="display:none">

      <g:message code="search"/>:<br/>
      <g:remoteField size="40" name="remoteField" update="substituteresults" action="remoteSubstitutes" id="${projectDay.id}" before="showspinner('#substituteresults')"/>
      <div id="substituteresults"></div>

    </div>

    <div id="substitutes2">
      <erp:getProjectDaySubstitutes projectDay="${projectDay}">
        <g:render template="substitutes" model="[substitutes: substitutes, project: project, projectDay: projectDay]"/>
      </erp:getProjectDaySubstitutes>
    </div>
  </div>

    <div class="zusatz">
        <h5><g:message code="clients"/> <span id="clientsSize"></span> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#clients');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
        <div class="zusatz-add" id="clients" style="display:none">

            <g:message code="search"/>:<br/>
            <erp:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClientsDay" id="${project.id}" params="[projectDay: projectDay.id]" before="showspinner('#remoteClients');"/>
            <div id="remoteClients"></div>

        </div>
        <div id="clients2">
            <erp:getProjectDayClients projectDay="${projectDay}">
                <g:render template="clientsday" model="[clients: clients, project: project, day: projectDay]"/>
            </erp:getProjectDayClients>
        </div>
    </div>

    <div class="zusatz">
        <h5><g:message code="resources.required"/></h5>
        <div style="margin: 5px 0;"><g:message code="fromProject"/></div>
        <g:if test="${ownRequiredResources}">
            <ul>
                <g:each in="${ownRequiredResources}" var="requiredResource">
                    <li>${requiredResource.amount}x "${requiredResource.name}" - ${requiredResource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
                </g:each>
            </ul>
        </g:if>
        <g:else>
            <div class="italic" style="margin-top: 5px;"><g:message code="resources.noneRequired"/></div>
        </g:else>
        <div style="margin: 5px 0;"><g:message code="fromActivities"/></div>
        <g:if test="${requiredResources}">
            <ul>
                <g:each in="${requiredResources}" var="requiredResource">
                    <li>${requiredResource.amount}x "${requiredResource.name}" - ${requiredResource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
                </g:each>
            </ul>
        </g:if>
        <g:else>
            <div class="italic" style="margin-top: 5px;"><g:message code="resources.noneRequired"/></div>
        </g:else>
    </div>

  <div class="zusatz">
    <h5><g:message code="resources.planned"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#resources');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="resources" style="display:none">
      <div id="plannableresources">
      </div>
    </div>
    <div class="zusatz-show" id="resources2">
      <g:render template="resources" model="[resources: resources, projectDay: projectDay]"/>
    </div>
  </div>

<div id="modal-calendar" style="display: none;">
    <g:form controller="projectDayProfile" action="addUnit" id="${projectDay.id}">

        <table>

            <tr class="prop">
                <td class="name"><g:message code="title"/></td>
                <td class="value">
                    <g:textField required="" size="25" name="unit" value=""/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="time"/></td>
                <td class="value">
                    <g:textField id="time" name="time" required="" class="timepick" size="4" value=""/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="duration"/></td>
                <td class="value">
                    <g:textField id="duration" name="duration" required="" size="4" value=""/> <span class="gray">(<g:message code="minutes"/>)</span>
                </td>
            </tr>

        </table>

        <div class="buttons cleared">
            <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'add')}" /></div>
        </div>

    </g:form>
</div>

</div>