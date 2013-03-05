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
  });
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

  <h5><g:message code="projectUnits"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#units');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
  <div id="units" style="display:none;">
    <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'addUnit', id: projectDay.id]" update="units2" before="showspinner('#units2')">
      <table>
        <tr>
          <td style="padding: 5px 10px 0 0;"><g:textField required="" size="25" name="unit" value=""/>%{--<g:select name="unit" from="${units}" optionKey="id" optionValue="profile"/>--}%</td>
          <td><span class="gray"><g:message code="time"/>:</span> <g:textField name="time" required="" class="timepick" size="4" value=""/></td>
          <td style="padding-left: 10px;"><span class="gray"><g:message code="duration"/>:</span> <g:textField name="duration" required="" size="4" value=""/> <span class="gray">(<g:message code="minutes"/>)</span></td>
          <td style="padding-left: 10px;"><g:submitButton name="button" value="${message(code:'add')}"/></td>
        </tr>
      </table>
    </g:formRemote>
  </div>

  <div id="units2">
    <erp:getProjectDayUnits projectDay="${projectDay}">
      <g:render template="units" model="[units: units, project: project, projectDay: projectDay, allParents: allParents, allPartners: allPartners]"/>
    </erp:getProjectDayUnits>
  </div>

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

</div>