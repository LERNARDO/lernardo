<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="project"/> - ${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="project"/> - ${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/projectNavigation" model="[entity: project]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="projectProfile" action="show" id="${project.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${project.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${project}"/></g:remoteLink></li>
        <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
          <li><g:remoteLink style="border-right: none" update="content" controller="comment" action="show" id="${project.id}"><g:message code="comments"/> (${project.profile.comments.size()}) </g:remoteLink></li>
          <li><g:link style="border-right: none" controller="projectProfile" action="listevaluations" id="${project.id}" params="[entity:project.id]"><g:message code="privat.evaluation"/></g:link></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>

      <g:if test="${template}">
        <p><g:message code="projectTemplate"/>: <g:link controller="projectTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName}</g:link></p>
      </g:if>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: project]"/></span> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${project.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/></td>
          <td class="two">${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="begin"/></td>
          <td class="two"><g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy" /></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="end"/></td>
          <td class="two"><g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy" /></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/></td>
          <td class="two">${fieldValue(bean: project, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="project.profile.educationalObjective"/></td>
          <td class="two">
            <g:if test="${project.profile.educationalObjective}">
              <g:message code="goal.${project.profile.educationalObjective}"/>
            </g:if>
            <g:else>
              <span class="italic"><g:message code="none"/></span>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="project.profile.educationalObjectiveText"/></td>
          <td class="two">${fieldValue(bean: project, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        </tbody>
      </table>

      <h4><g:message code="management"/></h4>
      <div class="zusatz">
        <h5><g:message code="labels"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${project}" checkoperator="true"><a onclick="toggle('#labels');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="labels" style="display:none">
          <g:formRemote name="formRemote2" url="[controller:'projectProfile', action:'addLabel', id:project.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
            <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="labels2">
          <g:render template="labels" model="[project: project, entity: currentEntity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="themes"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#themes');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Zu Thema zuordnen"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="themes" style="display:none">
          <g:if test="${allThemes}">
            <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addTheme', id: project.id]" update="themes2" before="showspinner('#themes2');"  after="toggle('#themes');">
              <g:select name="theme" from="${allThemes}" optionKey="id" optionValue="profile"/>
              <div class="clear"></div>
              <g:submitButton name="button" value="${message(code:'add')}"/>
              <div class="clear"></div>
            </g:formRemote>
          </g:if>
          <g:else>
            <g:message code="project.noThemes"/>
          </g:else>
        </div>
        <div class="zusatz-show" id="themes2">
          <g:render template="themes" model="[themes: themes, project: project, entity: currentEntity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="facility"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${project}"><span id="facilitybutton"><g:render template="facilitybutton" model="[facilities: facilities]"/></span></erp:accessCheck></h5>
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
        <h5><g:message code="clients"/> (${clients.size()}) <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#clients'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="clients" style="display:none">

          <g:message code="search"/>:<br/>
          <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${project.id}" before="showspinner('#remoteClients');"/>
          <div id="remoteClients"></div>

        </div>
        <div class="zusatz-show" id="clients2">
          <g:render template="clients" model="[clients: clients, entity: currentEntity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="projectDays"/> (${projectDays.size()})</h5>
        <div id="projectDay">
          <g:render template="projectdaynav" model="[project: project, projectDays: projectDays, projectDay: day, resources: resources, allEducators: allEducators, allParents: allParents, units: units, active: active, entity: currentEntity, plannableResources: plannableResources, requiredResources: requiredResources]"/>
        </div>
      </div>

    </div>

    %{--<erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
      <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: project]"/>
    </erp:accessCheck>--}%
  </div>
</div>

</body>

