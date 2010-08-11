<head>
  <meta name="layout" content="private"/>
  <title>Projekt</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Projekt</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <p>Vorlage: <g:link controller="projectTemplateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link></p>

      <table>
        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="project.profile.name"/></td>
          <td valign="top" class="name-show"><g:message code="project.profile.startDate"/></td>
          <td valign="top" class="name-show"><g:message code="project.profile.endDate"/></td>
        </tr>
        <tr>
          <td width="300" valign="top" class="value-show">
            ${fieldValue(bean: project, field: 'profile.fullName')}
          </td>
          <td width="230" valign="top" class="value-show">
            <g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy"/>
          </td>
          <td width="230" valign="top" class="value-show">
            <g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy"/>
          </td>
        </tr>
      </table>

    </div>
    <div class="buttons">
      <g:if test="${new Date() < project.profile.startDate}"><g:link class="buttonGreen" action="edit" id="${project?.id}"><g:message code="edit"/></g:link></g:if>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5>Einrichtung <app:isMeOrAdmin entity="${entity}"><g:if test="${facilities?.size() == 0}"><a onclick="toggle('#facilities'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Einrichtung hinzufügen"/></a></g:if></app:isMeOrAdmin></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addFacility', id: project.id]" update="facilities2" before="showspinner('#facilities2')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, project: project]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Betreute <app:isMeOrAdmin entity="${entity}"><a onclick="toggle('#clients'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Betreute hinzufügen"/></a></app:isMeOrAdmin></h5>
      <div class="zusatz-add" id="clients" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addClient', id:project.id]" update="clients2" before="showspinner('#clients2')">
          <g:select name="client" from="${allClients}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, project: project]"/>
      </div>
    </div>
    
    <div class="zusatz">
      <h5>Projekttage (${projectDays.size()})</h5>
      <g:if test="${projectDays}">
        <div style="margin-left: 5px">
        <g:each in="${projectDays}" var="projectDay">
          <div class="daybox"><g:remoteLink update="projectDay" action="updateprojectday" id="${projectDay.id}" params="[project: project.id]" before="showspinner('#projectDay')"><g:formatDate date="${projectDay.profile.date}" format="EEEE"/><br/><g:formatDate date="${projectDay.profile.date}" format="dd. MMMM yyyy"/></g:remoteLink></div>
        </g:each>
        <div class="spacer"></div>
        </div>

        <div id="projectDay">
          <g:render template="projectday" model="[projectDay: projectDays[0], allResources: allResources, allEducators: allEducators, allParents: allParents, units: units, entity: entity]"/>
        </div>




        %{--<ul>
          <g:each in="${projectDays}" var="projectDay" status="j">
            <div class="element-box">
              <g:formatDate date="${projectDay.profile.date}" format="dd. MMMM yyyy, HH:mm"/><br/>

              <span class="bold">Einheiten <app:isMeOrAdmin entity="${entity}"><a onclick="toggle('#units${j}'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Einheit hinzufügen"/></a></app:isMeOrAdmin></span>
              <div id="units${j}" style="display:none">
                <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addUnit', id:projectDay.id, params:[j:j]]" update="units2${j}" before="showspinner('#units2${j}')">
                  <g:select name="unit" from="${units}" optionKey="id" optionValue="profile"/>
                  <div class="spacer"></div>
                  <g:submitButton name="button" value="${message(code:'add')}"/>
                  <div class="spacer"></div>
                </g:formRemote>
              </div>

              <div id="units2${j}">
                <app:getProjectDayUnits projectDay="${projectDay}">
                  <g:render template="units" model="[units: units, projectDay: projectDay, allParents: allParents, j: j]"/>
                </app:getProjectDayUnits>
              </div>

              <span class="bold">Pädagogen <app:isMeOrAdmin entity="${entity}"><a onclick="toggle('#educators${j}'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Pädagoge hinzufügen"/></a></app:isMeOrAdmin></span>
              <div id="educators${j}" style="display:none">
                <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addEducator', id:projectDay.id, params:[j:j]]" update="educators2${j}" before="showspinner('#educators2${j}')">
                  <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
                  <div class="spacer"></div>
                  <g:submitButton name="button" value="${message(code:'add')}"/>
                  <div class="spacer"></div>
                </g:formRemote>
              </div>

              <div id="educators2${j}">
                <app:getProjectDayEducators projectDay="${projectDay}">
                  <g:render template="educators" model="[educators: educators, projectDay: projectDay, j: j]"/>
                </app:getProjectDayEducators>
              </div>

              <span class="bold">Resourcen <app:isMeOrAdmin entity="${entity}"><a onclick="toggle('#resources${j}'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ressource hinzufügen"/></a></app:isMeOrAdmin></span>
              <div id="resources${j}" style="display:none">
                <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addResource', id:projectDay.id, params:[j:j]]" update="resources2${j}" before="showspinner('#resources2${j}')">
                  <g:select name="resource" from="${allResources}" optionKey="id" optionValue="profile"/>
                  <div class="spacer"></div>
                  <g:submitButton name="button" value="${message(code:'add')}"/>
                  <div class="spacer"></div>
                </g:formRemote>
              </div>

              <div id="resources2${j}">
                <app:getProjectDayResources projectDay="${projectDay}">
                  <g:render template="resources" model="[resources: resources, projectDay: projectDay, j: j]"/>
                </app:getProjectDayResources>
              </div>

            </div>
          </g:each>
        </ul>--}%
      </g:if>
    </div>

    <g:remoteLink update="execute-result" class="buttonGray" action="execute" id="${project.id}" before="showspinner('#execute-result')">Projekt einplanen/aktualisieren</g:remoteLink>
    <div class="clear"></div>
    <div id="execute-result"></div>

  </div>
</div>

<g:render template="/comment/box" model="[entity: entity, commented: project]"/>

</body>

