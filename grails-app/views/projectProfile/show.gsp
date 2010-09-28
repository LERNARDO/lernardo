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
      <p>Vorlage: <g:link controller="projectTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName}</g:link></p>

      <table>
        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="project.profile.name"/></td>
          <td valign="top" class="name-show"><g:message code="project.profile.startDate"/></td>
          <td valign="top" class="name-show"><g:message code="project.profile.endDate"/></td>
        </tr>
        <tr>
          <td width="300" valign="top" class="value-show">
            ${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}
          </td>
          <td width="230" valign="top" class="value-show">
            <g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy"/>
          </td>
          <td width="230" valign="top" class="value-show">
            <g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy"/>
          </td>
        </tr>

        <tr>
          <td class="name-show"><g:message code="projectTemplate.profile.description"/></td>
        </tr>
        <tr>
          <td colspan="3" class="value-show">${template?.profile?.description?.decodeHTML()}</td>
        </tr>

      </table>

    </div>
    <div class="buttons">
      <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']">
        <g:if test="${new Date() < project.profile.startDate}"><g:link class="buttonGreen" action="edit" id="${project?.id}"><g:message code="edit"/></g:link></g:if>
      </app:hasRoleOrType>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5>Einrichtung <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:if test="${facilities?.size() == 0}"><a onclick="toggle('#facilities'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Einrichtung hinzufügen"/></a></g:if></app:hasRoleOrType></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addFacility', id: project.id]" update="facilities2" before="showspinner('#facilities2')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, project: project, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Betreute <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#clients'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Betreute hinzufügen"/></a></app:hasRoleOrType></h5>
      <div class="zusatz-add" id="clients" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addClientGroup', id:project.id]" update="clients2" before="showspinner('#clients2')">
          <g:select name="clientgroup" from="${allClientGroups}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, project: project, entity: currentEntity]"/>
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
          <g:render template="projectday" model="[projectDay: projectDays[0], allResources: allResources, allEducators: allEducators, allParents: allParents, units: units, entity: currentEntity]"/>
        </div>

      </g:if>
    </div>

    <g:remoteLink update="execute-result" class="buttonGray" action="execute" id="${project.id}" before="showspinner('#execute-result')">Projekt einplanen/aktualisieren</g:remoteLink>
    <div class="clear"></div>
    <div id="execute-result"></div>

  </div>
</div>

<app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: project]"/>
</app:hasRoleOrType>

</body>

