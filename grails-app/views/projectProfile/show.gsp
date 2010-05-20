<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Projekt</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Projekt</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <p>Vorlage: <g:link controller="projectTemplateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link></p>
        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="project.profile.name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: project, field: 'profile.fullName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="project.profile.startDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${project.profile.startDate}" format="dd. MMMM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="project.profile.endDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${project.profile.endDate}" format="dd. MMMM. yyyy"/></td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:if test="${new Date() < project.profile.startDate}"><g:link class="buttonBlue" action="edit" id="${project?.id}"><g:message code="edit"/></g:link></g:if>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

    <h1>Projekttage</h1>
    <g:if test="${projectDays}">     
      <ul>
        <g:each in="${projectDays}" var="projectDay" status="j">
          <li>
            <g:formatDate date="${projectDay.profile.date}" format="dd. MMMM yyyy, HH:mm"/><br/>

            <p class="bold">Einheiten <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-units${j}"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einheit hinzufügen" /></a></app:isMeOrAdmin></p>
            <jq:jquery>
              <jq:toggle sourceId="show-units${j}" targetId="units${j}"/>
            </jq:jquery>
            <div id="units${j}" style="display:none">
              <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addUnit', id:projectDay.id, params:[j:j]]" update="units2${j}" before="hideform('#units${j}')">
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

            <p class="bold">Pädagogen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-educators${j}"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Pädagoge hinzufügen" /></a></app:isMeOrAdmin></p>
            <jq:jquery>
              <jq:toggle sourceId="show-educators${j}" targetId="educators${j}"/>
            </jq:jquery>
            <div id="educators${j}" style="display:none">
              <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addEducator', id:projectDay.id, params:[j:j]]" update="educators2${j}" before="hideform('#educators${j}')">
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

            <p class="bold">Resourcen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-resources${j}"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ressource hinzufügen" /></a></app:isMeOrAdmin></p>
            <jq:jquery>
              <jq:toggle sourceId="show-resources${j}" targetId="resources${j}"/>
            </jq:jquery>
            <div id="resources${j}" style="display:none">
              <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addResource', id:projectDay.id, params:[j:j]]" update="resources2${j}" before="hideform('#resources${j}')">
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

          </li>
        </g:each>
      </ul>
    </g:if>

    <div>
      <h1>Betreute <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-clients"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Betreute hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-clients" targetId="clients"/>
      </jq:jquery>
      <div id="clients" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addClient', id:project.id]" update="clients2" before="hideform('#clients')">
          <g:select name="client" from="${allClients}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="clients2">
        <g:render template="clients" model="[clients: clients, project: project]"/>
      </div>
    </div>

    <div>
      <h1>Einrichtung <app:isMeOrAdmin entity="${entity}"><g:if test="${facilities?.size() == 0}"><a href="#" id="show-facilities"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einrichtung hinzufügen" /></a></g:if></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-facilities" targetId="facilities"/>
      </jq:jquery>
      <div id="facilities" style="display:none">
        <g:formRemote  name="formRemote" url="[controller:'projectProfile', action:'addFacility', id: project.id]" update="facilities2" before="hideform('#facilities')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, project: project]"/>
      </div>
    </div>

  </div>
</div>

<g:render template="/comment/box" model="[entity: entity, commented: project]"/>

</body>

