<head>
  <meta name="layout" content="private"/>
  <title><g:message code="project"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="project"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">

      <g:if test="${template}">
        <p><g:message code="projectTemplate"/>: <g:link controller="projectTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName}</g:link></p>
      </g:if>

      <p><g:message code="creator"/>: <erp:createdBy entity="${project}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></p>

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
          <td class="name-show"><g:message code="project.profile.description"/></td>
        </tr>

        <tr>
          <td colspan="3" class="value-show">${fieldValue(bean: project, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

      </table>

    </div>
    <div class="buttons">
      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" facilities="${facilities}" creatorof="${project}">
        %{--<g:if test="${new Date() < project.profile.startDate}">--}%<g:link class="buttonGreen" action="edit" id="${project?.id}" params="[entity: project?.id]"><g:message code="edit"/></g:link>%{--</g:if>--}%
      </erp:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="facility"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${project}"><span id="facilitybutton"><g:render template="facilitybutton" model="[facilities: facilities]"/></span></erp:accessCheck></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addFacility', id: project.id]" update="facilities2" before="showspinner('#facilities2'); toggle('#facilities');" after="${remoteFunction(action:'updateFacilityButton',update:'facilitybutton',id:project.id)}">
          <table>
            <tr>
              <td style="padding: 5px 10px 0 0;"><g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/></td>
              <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, project: project, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="clients"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#clients'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Betreute hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="clients" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addClientGroup', id:project.id]" update="clients2" before="showspinner('#clients2');" after="toggle('#clients');">
          <table>
            <tr>
              <td style="padding: 5px 10px 0 0;"><g:select name="clientgroup" from="${allClientGroups}" optionKey="id" optionValue="profile"/></td>
              <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, project: project, entity: currentEntity]"/>
      </div>
    </div>
       
    <div class="zusatz">
      <h5><g:message code="projectDays"/> (${projectDays.size()})</h5>
      <div id="projectDay">
        <g:render template="projectdaynav" model="[project: project, projectDays: projectDays, projectDay: day, allResources: allResources, allEducators: allEducators, allParents: allParents, units: units, entity: currentEntity]"/>
      </div>
    </div>

    %{--<g:remoteLink update="execute-result" class="buttonGray" action="execute" id="${project.id}" before="showspinner('#execute-result')">Projekt einplanen/aktualisieren</g:remoteLink>
    <div class="clear"></div>
    <div id="execute-result"></div>--}%

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: project]"/>
</erp:accessCheck>

</body>

