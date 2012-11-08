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
    <span class="gray"><g:message code="projectDayBegin"/>:</span> <g:formatDate date="${projectDay.profile.date}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message code="clock"/>
  </p>
  <p>
    <span class="gray"><g:message code="projectDayEnd"/>:</span> <g:formatDate date="${projectDay?.profile?.endDate}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message code="clock"/>
  </p>

  <g:message code="projectDayMove"/>:
  <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'moveProjectDay', id: projectDay.id]" update="projectDay" before="showspinner('#projectDay')">
    <table>
      <tr>
        <td style="padding: 5px 10px 0 0;"><g:textField name="date" class="datetimepicker" value="${formatDate(date: projectDay.profile.date, format: 'dd. MM. yyyy HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/></td>
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
          <td style="padding: 5px 10px 0 0;"><g:select name="unit" from="${units}" optionKey="id" optionValue="profile"/></td>
          <td><span class="gray"><g:message code="time"/>:</span> <g:textField name="time" required="" class="timepick" size="4" value=""/></td>
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
      <g:remoteField name="remoteField" size="40" update="educatorresults" action="remoteEducators" id="${projectDay.id}" before="showspinner('#educatorresults')"/>
      <div id="educatorresults"></div>

    </div>

    <div id="educators2">
      <erp:getProjectDayEducators projectDay="${projectDay}">
        <g:render template="educators" model="[educators: educators, project: project, projectDay: projectDay]"/>
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
            <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${project.id}" params="[projectDay: projectDay.id]" before="showspinner('#remoteClients');"/>
            <div id="remoteClients"></div>

        </div>
        <div id="clients2">
            <erp:getProjectDayClients projectDay="${projectDay}">
                <g:render template="clientsday" model="[clients: clients, project: project, day: projectDay]"/>
            </erp:getProjectDayClients>
        </div>
    </div>

  <div class="zusatz">
    <h5><g:message code="resources.planned"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#resources');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

    <div class="zusatz-add" id="resources" style="display:none">
      <span class="bold"><g:message code="resources.required"/></span>
      <g:if test="${requiredResources}">
        <ul style="margin: 5px 5px 0 15px;">
          <g:each in="${requiredResources}" var="requiredResource">
            <li style="list-style-type: circle">${requiredResource.amount}x "${requiredResource.name}" - ${requiredResource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
          </g:each>
        </ul>
      </g:if>
      <g:else>
        <div class="italic" style="margin: 5px;"><g:message code="resources.noneRequired"/></div>
      </g:else>

      <span class="bold"><g:message code="resource.profile"/></span> %{--<g:remoteLink update="plannableresources" action="refreshplannableresources" id="${projectDay.id}" before="showspinner('#plannableresources')"><img src="${g.resource(dir:'images/icons', file:'arrow_refresh.png')}" alt="Aktualisieren" align="top"/></g:remoteLink>--}%
      <div id="plannableresources">
        <erp:getProjectDayUnits projectDay="${projectDay}">
          <g:if test="${units}">
            <g:render template="plannableresources" model="[plannableResources: plannableResources, projectDay: projectDay]"/>
          </g:if>
          <g:else>
            <span class="italic"><g:message code="resources.planInfo"/></span><br/>
          </g:else>
        </erp:getProjectDayUnits>
      </div>
    </div>
    <div class="zusatz-show" id="resources2">
      <g:render template="resources" model="[resources: resources, projectDay: projectDay]"/>
    </div>
  </div>

</div>