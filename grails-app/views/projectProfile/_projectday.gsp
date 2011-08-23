<div class="element-box">
  <p><span class="bold"><g:message code="projectDayChosen"/>:</span> <g:formatDate date="${projectDay.profile.date}" format="EEEE, dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/>
     <span class="bold"><g:message code="projectDayBegin"/>:</span> <g:formatDate date="${projectDay.profile.date}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message code="clock"/></p>

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

  <span class="bold">Eingeplante Ressourcen <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#resources');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></span>

      <div class="zusatz-add" id="resources" style="display:none">
        <b><g:message code="resources.required"/></b>
        <g:if test="${requiredResources}">
          <ul style="margin-left: 5px">
            <g:each in="${requiredResources}" var="requiredResource">
              <li style="list-style-type: circle">${requiredResource.amount}x "${requiredResource.name}" - ${requiredResource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
            </g:each>
          </ul>
        </g:if>
        <g:else>
          <div class="gray" style="margin-bottom: 5px">Keine benötigten Ressourcen!</div>
        </g:else>

        <b><g:message code="resource.profile"/></b> <g:remoteLink update="plannableresources" action="refreshplannableresources" id="${projectDay.id}"><img src="${g.resource(dir:'images/icons', file:'arrow_refresh.png')}" alt="Aktualisieren" align="top"/></g:remoteLink>
        <div id="plannableresources">
          <erp:getProjectDayUnits projectDay="${projectDay}">
            <g:if test="${units}">
              <g:render template="plannableresources" model="[plannableResources: plannableResources, projectDay: projectDay]"/>
            </g:if>
            <g:else>
              <span class="italic gray">Sie können die Ressourcen erst einplanen, wenn Sie eine Projekteinheit ausgewählt haben!</span><br/>
            </g:else>
          </erp:getProjectDayUnits>
        </div>
      </div>
      <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, entity: entity, projectDay: projectDay]"/>
      </div>
    </div>

</div>