<div class="element-box">
  <p><span class="bold">Derzeit ausgewählter Projekttag:</span> <g:formatDate date="${projectDay.profile.date}" format="EEEE, dd. MMMM yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/>
     <span class="bold">Projektbeginn an diesem Tag:</span> <g:formatDate date="${projectDay.profile.date}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> Uhr</p>

  <span class="bold"><g:message code="projectUnits"/> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#units'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></span>
  <div id="units" style="display:none">
    <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addUnit', id:projectDay.id]" update="units2" before="showspinner('#units2')">
      <table>
        <tr>
          <td style="padding: 5px 10px 0 0;"><g:select name="unit" from="${units}" optionKey="id" optionValue="profile"/></td>
          <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
        </tr>
      </table>
    </g:formRemote>
  </div>

  <div id="units2">
    <erp:getProjectDayUnits projectDay="${projectDay}">
      <g:render template="units" model="[units: units, project: project, projectDay: projectDay, allParents: allParents, allPartners: allPartners, entity: entity]"/>
    </erp:getProjectDayUnits>
  </div>

  <span class="bold"><g:message code="educators"/> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#educators'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></span>
  <div id="educators" style="display:none">

    <g:message code="search"/>:<br/>
    %{--TODO: this uses a custom tag because the official implementation is broken, see: http://jira.codehaus.org/browse/GRAILS-2512--}%
    <erp:remoteField size="40" name="remoteField" update="educatorresults" action="remoteEducators" id="${projectDay.id}" before="showspinner('#educatorresults')"/>
    <div id="educatorresults"></div>

  </div>

  <div id="educators2">
    <erp:getProjectDayEducators projectDay="${projectDay}">
      <g:render template="educators" model="[educators: educators, project: project, projectDay: projectDay, entity: entity]"/>
    </erp:getProjectDayEducators>
  </div>

  <span class="bold"><g:message code="substitutes"/> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#substitutes'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></span>
  <div id="substitutes" style="display:none">

    <g:message code="search"/>:<br/>
    %{--TODO: this uses a custom tag because the official implementation is broken, see: http://jira.codehaus.org/browse/GRAILS-2512--}%
    <erp:remoteField size="40" name="remoteField" update="substituteresults" action="remoteSubstitutes" id="${projectDay.id}" before="showspinner('#substituteresults')"/>
    <div id="substituteresults"></div>

  </div>

  <div id="substitutes2">
    <erp:getProjectDaySubstitutes projectDay="${projectDay}">
      <g:render template="substitutes" model="[substitutes: substitutes, project: project, projectDay: projectDay, entity: entity]"/>
    </erp:getProjectDaySubstitutes>
  </div>

  %{--<span class="bold">Resourcen <erp:accessCheck entity="${entity}" types="['Betreiber','Pädagoge']"><a onclick="toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></span>
  <div id="resources" style="display:none">
    <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addResource', id:projectDay.id]" update="resources2" before="showspinner('#resources2')">
      <g:select name="resource" from="${allResources}" optionKey="id" optionValue="profile"/>
      <div class="spacer"></div>
      <g:submitButton name="button" value="${message(code:'add')}"/>
      <div class="spacer"></div>
    </g:formRemote>
  </div>

  <div id="resources2">
    <erp:getProjectDayResources projectDay="${projectDay}">
      <g:render template="resources" model="[resources: resources, projectDay: projectDay, entity: entity]"/>
    </erp:getProjectDayResources>
  </div>--}%

</div>